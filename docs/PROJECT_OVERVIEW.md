# WinkChat — opis projektu

## 1. Czym jest WinkChat

WinkChat to mobilna aplikacja do **anonimowych rozmów 1:1 z osobami znajdującymi
się w pobliżu geograficznym**. Filozofia produktu:

- **Zero kont** — brak rejestracji, logowania, haseł i e-maili. Użytkownik
  podaje tylko pseudonim, płeć i wiek — deklaratywnie, na czas sesji.
- **Ulotność** — tożsamość (`user_id`) żyje tylko przez jedną sesję; nie ma
  historii rozmów, listy znajomych ani profili do przeglądania.
- **Bliskość** — widzisz wyłącznie osoby w zadanym promieniu (max 10 km),
  a ich pozycja jest celowo rozmyta o 300–500 m (prywatność).
- **Tylko tekst** — bez zdjęć, plików, głosówek, typing indicators
  i potwierdzeń przeczytania. Świadomie.

## 2. Główne przepływy użytkownika

### 2.1 Onboarding i wejście
1. Pierwsze uruchomienie: użytkownik podaje pseudonim, płeć, wiek i promień
   wyszukiwania; aplikacja prosi o uprawnienie do lokalizacji.
2. Aplikacja łączy się z serwerem (WebSocket) i pokazuje **listę osób
   w pobliżu** z przybliżoną odległością (zawsze z „~").

### 2.2 Zaproszenie
1. Użytkownik wybiera osobę z listy i wysyła zaproszenie do rozmowy.
2. Zaproszenie ma termin ważności (odliczanie w UI); w danym momencie można
   mieć **jedno** wychodzące zaproszenie.
3. Druga strona może mieć wiele zaproszeń przychodzących — akceptuje jedno,
   pozostałe serwer anuluje automatycznie.

### 2.3 Rozmowa
1. Po akceptacji obie strony trafiają do pokoju czatu i widzą profil rozmówcy.
2. Wiadomości tekstowe do 2000 znaków; kolejność i potwierdzenie doręczenia
   wyznacza **echo serwera** (własna wiadomość wraca jako `message.received`).
3. Każda ze stron może w dowolnym momencie zakończyć rozmowę lub **zgłosić**
   rozmówcę (raz na rozmowę); po zakończeniu obie wracają do listy.

### 2.4 Odporność na realia mobile
1. Zerwanie połączenia (brak zasięgu, aplikacja w tle) nie kończy rozmowy od
   razu — serwer daje **~120 s okresu łaski** na powrót (`session.resume`).
2. Rozmówca widzi w tym czasie status „rozłączony / wrócił".
3. Naruszenia regulaminu skutkują **blokadą urządzenia** (ban czasowy lub
   permanentny) — aplikacja pokazuje ekran blokady z terminem wygaśnięcia.

## 3. Słownik pojęć

| Pojęcie | Znaczenie |
|---|---|
| **Sesja** | Życie użytkownika na serwerze — od `connection.init` do wygaśnięcia; z każdą nową sesją przydzielany jest nowy `user_id`. |
| **`user_id`** | Efemeryczny identyfikator użytkownika. **Nie wolno** go trwale zapisywać ani budować na nim historii. |
| **`device_id`** | Trwały, wygenerowany raz UUID urządzenia (secure storage). Podstawa egzekwowania banów. Nigdy nie pokazywany w UI. |
| **`resume_token`** | Sekret pozwalający wznowić sesję po zerwaniu łącza. Trzymany wyłącznie w secure storage / pamięci. |
| **Okres łaski** | ~120 s po zerwaniu socketu, w których sesja (i rozmowa) jeszcze żyje na serwerze. |
| **Pokój (room)** | Kanał rozmowy 1:1; istnieje tylko na czas rozmowy. |
| **Zaproszenie** | Propozycja rozmowy z TTL; rozstrzyga się jako: accepted / rejected / cancelled / expired. |
| **Nearby list** | Pełny snapshot osób w pobliżu, wypychany przez serwer (`nearby.updated`) — zawsze zastępuje poprzedni. |
| **Pozycja zaszumiona** | Pozycja innych użytkowników przesunięta o stały (per sesja) wektor 300–500 m. |

## 4. Zakres projektu (scope)

**Robimy:** wszystko z §2 + pełna obsługa błędów i eventów protokołu
(`docs/SERVER_PROTOCOL.md`), l10n (pl/en), testy, CI.

**Świadomie NIE robimy:** kont i logowania, historii rozmów, multimediów,
typing indicators, read receipts, mapy z pinezkami użytkowników, powiadomień
push (serwer ich nie wspiera — komunikacja tylko przez żywy socket).

## 5. Kontekst techniczny

- **Backend jest gotowy** (osobne repo `WinkChat-server`). Jedyny kanał
  komunikacji: WebSocket, tekstowy JSON. Pełna specyfikacja:
  [SERVER_PROTOCOL.md](SERVER_PROTOCOL.md) — to **jedyne źródło prawdy** o API;
  przy sprzeczności z innym dokumentem wygrywa SERVER_PROTOCOL.
- **Platformy:** iOS i Android, rozwijane równolegle z jednego kodu Flutter.
- **Design:** projekt graficzny UI istnieje (stworzony w Claude Design) —
  ekrany implementujemy na jego podstawie, nie projektujemy od zera.
- **Charakter repo:** projekt edukacyjny prowadzony wg
  [LEARNING_PLAN.md](LEARNING_PLAN.md), ale ze standardami produkcyjnymi.
