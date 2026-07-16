# WinkChat — przewodnik integracji klienta mobilnego z serwerem

Dokument dla agenta AI budującego aplikację mobilną (Android/iOS). Opisuje
**wyłącznie** komunikację z serwerem WinkChat i jej poprawną obsługę po stronie
frontendu. Serwer: anonimowy czat 1:1 w czasie rzeczywistym między osobami
w pobliżu geograficznym — bez kont, logowania i rejestracji.

---

## 1. Sposób komunikacji

### 1.1 Transport

- Jedyny kanał: **WebSocket** — `wss://<host>/ws` (produkcja zawsze WSS;
  `ws://localhost:8000/ws` tylko dev).
- Wszystkie ramki to **tekstowy JSON UTF-8** (żadnych ramek binarnych).
- Keep-alive: ping/pong na poziomie protokołu WebSocket (RFC 6455) — biblioteki
  WS obsługują to automatycznie; nie ma osobnych eventów JSON typu "ping".

### 1.2 Format ramki (w obie strony)

```json
{
  "v": 1,
  "type": "message.send",
  "correlation_id": "uuid-wygenerowany-przez-nadawcę",
  "payload": { }
}
```

| Pole | Zasady |
|---|---|
| `v` | zawsze `1`; inna wartość → błąd `UNSUPPORTED_VERSION` |
| `type` | nazwa eventu (namespace kropkowy) |
| `correlation_id` | klient generuje UUID per żądanie; odpowiedź serwera na to żądanie niesie **ten sam** `correlation_id`; eventy inicjowane przez serwer mają `null` |
| `payload` | obiekt zależny od eventu (poniżej) |

### 1.3 Handshake — pierwsza ramka

**Pierwszą ramką po otwarciu połączenia MUSI być** `connection.init` (nowa
sesja) **albo** `session.resume` (wznowienie). Cokolwiek innego → `error`
`NOT_INITIALIZED` i zamknięcie połączenia (kod 1002).

### 1.4 Eventy klient → serwer (co serwer przyjmuje)

| `type` | `payload` | Ograniczenia |
|---|---|---|
| `connection.init` | `username`, `sex`, `age`, `device_id`, `longitude`, `latitude`, `radius_m` | `username` 1–50 znaków; `sex` ∈ `"male"\|"female"\|"other"`; `age` int 1–150; `device_id` 1–256 znaków; `longitude` −180…180; `latitude` −90…90; `radius_m` int ≥ 1, domyślnie 1000, serwer przycina do 10 000 |
| `session.resume` | `resume_token` | token z `connection.accepted` |
| `location.update` | `longitude`, `latitude` | zakresy jw. |
| `invitation.send` | `to_user_id` | max 1 oczekujące wychodzące zaproszenie |
| `invitation.accept` | `from_user_id` | |
| `invitation.reject` | `from_user_id` | |
| `room.join` | `room_id` | |
| `message.send` | `room_id`, `text` | `text` 1–2000 znaków, tylko tekst (żadnych plików/multimediów) |
| `conversation.end` | `room_id` | |
| `report.create` | `reported_user_id`, `reason` | tylko w trakcie rozmowy; `reason` 1–1000 znaków; max 1 zgłoszenie na rozmowę |

### 1.5 Eventy serwer → klient (co serwer wysyła)

| `type` | `payload` | Kiedy |
|---|---|---|
| `connection.accepted` | `user_id`, `resume_token`, `nearby_users[]` | odpowiedź na `connection.init` |
| `connection.banned` | `reason`, `expires_at` (ISO 8601 lub `null` = permanentna) | urządzenie zablokowane; serwer zamyka socket (4003) |
| `connection.replaced` | `{}` | to samo urządzenie połączyło się ponownie — stary socket zamykany (4001) |
| `session.resumed` | `user_id`, `room_id` (lub `null`), `nearby_users[]` (lub `null`, gdy w pokoju) | odpowiedź na `session.resume` |
| `nearby.updated` | `nearby_users[]` | push przy każdej zmianie listy pobliskich |
| `invitation.sent` | `to_user_id`, `expires_at` | ack `invitation.send` (ten sam `correlation_id`) |
| `invitation.received` | `from_user_id`, `profile{username,sex,age}`, `expires_at` | ktoś Cię zaprasza (może przyjść wiele) |
| `invitation.accepted` | `by_user_id`, `room_id` | Twoje zaproszenie przyjęto |
| `invitation.rejected` | `by_user_id` | Twoje zaproszenie odrzucono — możesz zapraszać ponownie |
| `invitation.cancelled` | `to_user_id`, `cause` ∈ `"peer_busy"\|"peer_left"` | Twoje zaproszenie anulowane (adresat zaakceptował kogoś innego / rozłączył się) — możesz zapraszać ponownie |
| `invitation.expired` | `from_user_id` **lub** `to_user_id` | TTL zaproszenia minął (obie strony dostają swoją wersję) |
| `room.created` | `room_id` | pokój utworzony — **wyślij `room.join`** |
| `room.ready` | `room_id`, `peer_profile{username,sex,age}` (może być `null`) | obie strony dołączyły — można pisać |
| `message.received` | `room_id`, `from_user_id`, `text`, `sent_at` (ISO 8601 UTC) | wiadomość; **dostaje ją też nadawca** (echo) |
| `room.peer_disconnected` | `room_id` | rozmówca stracił połączenie (trwa okres łaski) |
| `room.peer_reconnected` | `room_id` | rozmówca wrócił |
| `conversation.ended` | `room_id`, `cause` ∈ `"own_request"\|"peer_request"\|"peer_expired"\|"peer_banned"` | rozmowa zakończona, pokój nie istnieje |
| `report.ack` | `reported_user_id` | zgłoszenie przyjęte (serwer nie ujawnia liczby zgłoszeń) |
| `ban.imposed` | `reason`, `expires_at` (ISO lub `null`) | nałożono blokadę w trakcie sesji; serwer kończy rozmowę i zamyka socket (4003) |
| `error` | `code`, `message` | patrz §3 |

Element `nearby_users[]`:

```json
{
  "user_id": "uuid",
  "username": "…",
  "sex": "female",
  "age": 25,
  "approx_longitude": 21.0139,
  "approx_latitude": 52.2312,
  "distance_m": 644.4
}
```

`approx_*` i `distance_m` liczone są z pozycji **zaszumionej o 300–500 m**
(stały wektor na sesję) — patrz §4.

### 1.6 Kody zamknięcia WebSocket

| Kod | Znaczenie | Reakcja klienta |
|---|---|---|
| `1002` | błąd protokołu (zła pierwsza ramka, zły JSON, zła wersja) | popraw implementację; nie retry'uj tej samej ramki |
| `1013` | serwer pełny | pokaż "spróbuj później", retry z backoffem |
| `4001` | sesja zastąpiona nowym połączeniem tego urządzenia | zamknij ekran / nie wznawiaj automatycznie |
| `4003` | blokada (ban) | pokaż ekran blokady z `expires_at`; nie łącz ponownie przed upływem |

---

## 2. Przypadki użycia (sekwencje eventów)

### 2.1 Połączenie i lista pobliskich
1. Otwórz WSS → wyślij `connection.init`.
2. Odbierz `connection.accepted` → **zapisz `user_id` (na sesję) i
   `resume_token` (do wznowień)**; wyrenderuj `nearby_users`.
3. Nasłuchuj `nearby.updated` — każdy event niesie **pełną, nową listę**
   (zastąp, nie doklejaj).
4. Alternatywnie: `connection.banned` → ekran blokady, socket zamknięty.

### 2.2 Aktualizacja pozycji (użytkownik się przemieszcza)
1. Wyślij `location.update` (sensownie: po przesunięciu o ~50–100 m, nie
   częściej niż ~1/s).
2. Serwer odpowie własnym `nearby.updated` z odświeżoną listą.

### 2.3 Wysłanie zaproszenia
1. `invitation.send {to_user_id}` → ack `invitation.sent` z `expires_at`
   (odliczanie w UI **z `expires_at`**, nie z lokalnej stałej).
2. Zakończenie oczekiwania — dokładnie jedno z:
   `invitation.accepted` (→ 2.5), `invitation.rejected`,
   `invitation.cancelled`, `invitation.expired`.
3. Po każdym z tych trzech ostatnich można zapraszać ponownie (limit: §4).

### 2.4 Odbiór zaproszeń
1. `invitation.received` może przyjść **wiele równocześnie** — pokaż stos/listę
   z odliczaniem do `expires_at` każdego.
2. `invitation.accept {from_user_id}` → dalej jak 2.5, pozostałe zaproszenia
   serwer sam anuluje (ich nadawcy dostaną `invitation.cancelled`).
3. `invitation.reject {from_user_id}` → zaproszenie znika.
4. Zaproszenie może samo zniknąć: `invitation.expired` (usuń z UI).

### 2.5 Utworzenie pokoju i rozmowa (obie strony identycznie)
1. Odbierz `room.created {room_id}` → **natychmiast wyślij `room.join {room_id}`**.
2. Czekaj na `room.ready` (przyjdzie, gdy dołączą obie strony) → pokaż czat
   z `peer_profile`.
3. Wysyłanie: `message.send` → wiadomość wraca jako `message.received` do
   **obu** stron. **Renderuj wiadomości z `message.received` (także własne)** —
   echo jest potwierdzeniem doręczenia i jedynym źródłem kolejności; lokalnie
   dodany dymek oznacz jako "wysyłanie" do czasu echa.
4. Wysyłanie przed `room.ready` → błąd `NOT_IN_ROOM`.

### 2.6 Zakończenie rozmowy
1. `conversation.end {room_id}` → dostaniesz `conversation.ended` z
   `cause="own_request"`; rozmówca z `cause="peer_request"`.
2. Po `conversation.ended` (dowolna przyczyna): wróć do listy pobliskich —
   świeży `nearby.updated` przyjdzie zaraz po nim.

### 2.7 Zgłoszenie rozmówcy
1. Tylko w trakcie rozmowy: `report.create {reported_user_id: <user_id rozmówcy>, reason}`.
2. Odbierz `report.ack`. Rozmowa trwa dalej (chyba że próg kar został osiągnięty).
3. Jeżeli zgłoszenie przekroczyło próg: Ty dostaniesz `conversation.ended`
   z `cause="peer_banned"`, a zgłoszony — `ban.imposed` i zamknięcie socketu (4003).
4. Drugie zgłoszenie w tej samej rozmowie → `DUPLICATE_REPORT`.

### 2.8 Utrata połączenia i wznowienie (kluczowe dla mobile)
1. Socket padł (brak zasięgu, zmiana sieci, ubicie aplikacji w tle) — serwer
   trzyma sesję jeszcze przez **okres łaski (domyślnie 120 s)**; w tym czasie
   rozmówca widzi `room.peer_disconnected`, ale pokój żyje.
2. Po odzyskaniu sieci: otwórz nowy socket i jako **pierwszą ramkę** wyślij
   `session.resume {resume_token}`.
3. `session.resumed`:
   - `room_id != null` → wróć prosto do czatu (rozmówca dostał
     `room.peer_reconnected`); `nearby_users` będzie `null`;
   - `room_id == null` → rozmowa wygasła/zakończyła się; wróć do listy
     (`nearby_users` w payloadzie).
4. `error RESUME_FAILED` → sesja przepadła: wykonaj pełny `connection.init`
   (profil trzymaj lokalnie, żeby zrobić to bez udziału użytkownika).
5. Retry łączenia: exponential backoff (np. 1 s → 2 s → 4 s… max 30 s).

### 2.9 Druga instancja / reinstalacja
Połączenie z tym samym `device_id`, gdy stara sesja żyje → stara dostaje
`connection.replaced` i zamknięcie 4001, nowa działa normalnie.

---

## 3. Błędy

Ramka błędu (z `correlation_id` żądania, jeśli dotyczyło konkretnego żądania):

```json
{ "v": 1, "type": "error", "correlation_id": "…", "payload": { "code": "RATE_LIMITED", "message": "rate limit exceeded" } }
```

| `code` | Kiedy | Obsługa w UI |
|---|---|---|
| `UNSUPPORTED_VERSION` | `v != 1` | wymuś aktualizację aplikacji |
| `INVALID_PAYLOAD` | zły JSON / walidacja / nieznany `type` / self-invite | błąd programisty — loguj, nie pokazuj użytkownikowi |
| `NOT_INITIALIZED` | event przed `connection.init`/`session.resume` | błąd programisty |
| `USER_BANNED` | operacja przy aktywnej blokadzie | ekran blokady |
| `USER_NOT_FOUND` | adresat zniknął (sesja wygasła) | odśwież listę, komunikat "użytkownik niedostępny" |
| `USER_UNAVAILABLE` | adresat (lub Ty) jest już w rozmowie | komunikat + odśwież listę |
| `INVITATION_ALREADY_SENT` | drugie wychodzące zaproszenie | zablokuj przycisk do rozstrzygnięcia pierwszego |
| `INVITATION_NOT_FOUND` | akceptacja/odrzucenie nieistniejącego (zwykle: wygasło) | usuń zaproszenie z UI |
| `NOT_IN_ROOM` | operacja pokojowa spoza pokoju / pokój niegotowy | wróć do listy pobliskich |
| `ROOM_NOT_FOUND` | nieistniejący `room_id` | wróć do listy pobliskich |
| `MESSAGE_TOO_LONG` | > 2000 znaków | walidbuj przed wysłaniem; licznik znaków w UI |
| `DUPLICATE_REPORT` | drugie zgłoszenie w tej samej rozmowie | ukryj/zablokuj przycisk zgłoszenia po `report.ack` |
| `RATE_LIMITED` | przekroczony limit częstotliwości (§4) | krótki toast + cooldown na przycisku |
| `RESUME_FAILED` | zły/wygasły `resume_token` | pełny `connection.init` |
| `INTERNAL_ERROR` | błąd serwera | toast "spróbuj ponownie", loguj |

Błędy **nie zrywają połączenia** (poza fazą handshake'u — tam po błędzie
serwer zamyka socket).

---

## 4. O czym trzeba pamiętać

1. **Echo wiadomości**: `message.received` przychodzi też do nadawcy — to
   potwierdzenie doręczenia i źródło kolejności. Nie dubluj dymków.
2. **Rate limity per połączenie** (przekroczenie → `RATE_LIMITED`):
   `message.send` 10/s; `invitation.send` 1 na 5 s — **uwaga: żądanie
   odrzucone błędem też zużywa limit**; `location.update` ~1/s (burst 3);
   `report.create` 1 na 5 s. Wyszaruj przyciski na czas cooldownu.
3. **Pozycje innych są celowo niedokładne**: zaszumione o 300–500 m, stały
   wektor na sesję; `distance_m` liczony od pozycji zaszumionej. W UI zawsze
   "~" przy dystansie; nie rysuj dokładnych pinezek na mapie.
4. **`user_id` jest efemeryczny** — nowy przy każdej sesji. Nie zapisuj go
   trwale, nie buduj na nim historii ani "znajomych".
5. **`resume_token` to sekret sesji** — trzymaj w pamięci/secure storage,
   nigdy w logach; po `connection.accepted` zawsze nadpisuj.
6. **`nearby.updated` to pełny snapshot** — zastępuj całą listę.
7. **Odliczania rób z `expires_at` serwera** (zaproszenia, ban) — nie z
   lokalnych stałych; zegar telefonu może odbiegać, czasy są w UTC (ISO 8601).
8. **Kolejność eventów bywa "zaskakująca" dla UI**: `conversation.ended` może
   przyjść w każdej chwili (rozmówca zakończył / wygasł / został zbanowany) —
   każdy ekran czatu musi umieć wrócić do listy. `invitation.expired` może
   przyjść, gdy użytkownik właśnie klika "akceptuj" (dostaniesz wtedy
   `INVITATION_NOT_FOUND` — obsłuż cicho).
9. **Nieznane `type` ignoruj** (forward compatibility) — serwer może dodawać
   nowe eventy bez podbijania wersji.
10. **Walidacja wieku należy do frontendu** — serwer przyjmuje `age` 1–150
    deklaratywnie i niczego nie weryfikuje.
11. **Radius**: serwer przycina `radius_m` do 10 000 m — nie oferuj w UI
    większego zakresu.
12. **Tylko tekst**: brak zdjęć, plików, głosówek, typing indicators i
    potwierdzeń przeczytania — nie projektuj ich.
13. **Aplikacja w tle (iOS/Android)**: system uśpi socket — traktuj powrót do
    foreground jak utratę połączenia: sprawdź stan socketu i w razie potrzeby
    przejdź ścieżkę `session.resume` (2.8). Masz na to ~120 s od zerwania.

---

## 5. Co jest wymagane od aplikacji

1. **Stabilny `device_id`**: wygeneruj UUID przy pierwszym uruchomieniu
   i przechowuj trwale (Keychain / EncryptedSharedPreferences, przeżywa
   aktualizacje aplikacji). To podstawa egzekwowania blokad — nie regeneruj go
   i nie pokazuj nigdzie w UI.
2. **Uprawnienie do lokalizacji** + odczyt współrzędnych przed
   `connection.init`; aktualizacje pozycji w trakcie sesji (`location.update`).
3. **Klient WebSocket** z: automatycznym pong na ping, wykrywaniem zerwania,
   reconnectem z backoffem i ścieżką `session.resume` jako pierwszą ramką.
4. **Generowanie `correlation_id`** (UUID) dla każdego żądania i dopasowywanie
   odpowiedzi/błędów po nim.
5. **Walidacja przed wysłaniem**: username 1–50, wiadomość 1–2000, powód
   zgłoszenia 1–1000, zakresy współrzędnych — nie polegaj na serwerowym
   `INVALID_PAYLOAD` jako pierwszej linii obrony.
6. **Obsługa wszystkich eventów serwera z §1.5** — w tym tych, które mogą
   przyjść bez akcji użytkownika (`nearby.updated`, `invitation.received`,
   `invitation.cancelled/expired`, `room.peer_disconnected/reconnected`,
   `conversation.ended`, `ban.imposed`, `connection.replaced`).
7. **Obsługa kodów zamknięcia** 1002/1013/4001/4003 zgodnie z §1.6 (w
   szczególności: po 4003 nie łączyć ponownie przed `expires_at`).
8. **WSS na produkcji** — plain `ws://` wyłącznie do lokalnego developmentu.
