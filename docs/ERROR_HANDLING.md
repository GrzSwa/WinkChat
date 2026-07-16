# Strategia obsługi błędów

Protokół WinkChat ma bogaty katalog błędów i „zaskakującą" kolejność eventów
(SERVER_PROTOCOL §3–4). Bez spójnej strategii obsługa rozlazłaby się po
widgetach — dlatego zasady spisujemy tu, a szczegóły dopracujemy w Fazach 5–8.

## 1. Trzy kategorie niepowodzeń

| Kategoria | Przykłady | Kto obsługuje |
|---|---|---|
| **Oczekiwane biznesowo** | `USER_UNAVAILABLE`, `INVITATION_NOT_FOUND`, `RATE_LIMITED`, rozmówca zakończył rozmowę | UI — konkretny komunikat/zachowanie z tabeli §3 |
| **Techniczne przejściowe** | utrata sieci, timeout odpowiedzi, serwer pełny (1013) | warstwa połączenia — retry/backoff/resume; UI pokazuje tylko stan „łączenie…" |
| **Błędy programisty** | `INVALID_PAYLOAD`, `NOT_INITIALIZED`, `UNSUPPORTED_VERSION` | nie pokazujemy użytkownikowi; logujemy + w debug builderze głośny assert — to sygnał do naprawy kodu |

## 2. Zasady architektoniczne

1. **Wyjątki nie przekraczają granicy warstwy data.** Repozytoria łapią
   wyjątki techniczne i mapują je na **`Failure`** — typy domenowe
   (sealed class w `core/error/`), zwracane jako `Result<T>` / unie stanów.
2. **Domain i presentation nie znają kodów protokołu** — znają `Failure`'y
   (`PeerUnavailable`, `RateLimited(cooldown)`, `SessionExpired`…).
   Mapowanie kod→Failure żyje w jednym miejscu w warstwie data.
3. **Każdy stan bloca ma reprezentację błędu** — nie ma „cichych" niepowodzeń;
   unie freezed wymuszają obsłużenie w UI.
4. **Walidacja przed wysłaniem** (username 1–50, wiadomość 1–2000, powód
   1–1000, współrzędne) żyje w domain — serwerowy `INVALID_PAYLOAD` to
   ostatnia linia obrony i w praktyce błąd programisty.

## 3. Mapa: kod błędu → zachowanie UI

(Źródło: SERVER_PROTOCOL §3; ta tabela = nasza implementacyjna checklista
do audytu w Fazie 11.1.)

| Kod / zdarzenie | Zachowanie aplikacji |
|---|---|
| `USER_NOT_FOUND` | snackbar „użytkownik niedostępny" + odświeżenie listy |
| `USER_UNAVAILABLE` | snackbar „rozmawia z kimś innym" + odświeżenie listy |
| `INVITATION_ALREADY_SENT` | przycisk zapraszania zablokowany do rozstrzygnięcia |
| `INVITATION_NOT_FOUND` | **cicho** usuń zaproszenie z UI (wyścig z expiry — §4.8) |
| `NOT_IN_ROOM` / `ROOM_NOT_FOUND` | nawigacja na listę nearby |
| `MESSAGE_TOO_LONG` | nie powinno wystąpić (walidacja + licznik znaków); jeśli — log |
| `DUPLICATE_REPORT` | nie powinno wystąpić (przycisk ukryty po `report.ack`); jeśli — log |
| `RATE_LIMITED` | krótki toast + wyszarzenie przycisku na czas cooldownu |
| `RESUME_FAILED` | automatyczny pełny `connection.init` z zapisanego profilu — bez udziału użytkownika |
| `USER_BANNED` / `ban.imposed` / kod 4003 | ekran blokady z odliczaniem z `expires_at`; zakaz reconnectu przed terminem |
| `INTERNAL_ERROR` | toast „spróbuj ponownie" + log |
| kod 1013 (serwer pełny) | ekran „spróbuj później", retry z backoffem |
| kod 4001 (`connection.replaced`) | komunikat „zalogowano na innym połączeniu", bez auto-reconnectu |
| timeout odpowiedzi na żądanie | traktuj jak błąd techniczny przejściowy; sprawdź stan socketu |

## 4. Zasady UX błędów

- Komunikaty **po polsku/angielsku przez l10n**, pisane językiem użytkownika
  („Nie udało się wysłać" zamiast „ERROR: NOT_IN_ROOM").
- Odliczania (ban, zaproszenia, cooldowny) zawsze z **`expires_at` serwera**,
  nigdy z lokalnych stałych.
- Błąd nie może zgubić pracy użytkownika: tekst niewysłanej wiadomości
  zostaje w polu.
- `conversation.ended` może przyjść **w każdej chwili** — każdy ekran czatu
  umie z gracją wrócić do listy z krótką informacją o przyczynie.

## 5. Logowanie

- W debug: logi zdarzeń połączenia i błędów (bez treści wiadomości).
- **Nigdy nie logujemy:** `resume_token`, `device_id`, treści rozmów,
  dokładnych współrzędnych — [SECURITY.md](SECURITY.md).
- Struktura logów do ustalenia w Fazie 5 (prosty `Logger` w `core/`).
