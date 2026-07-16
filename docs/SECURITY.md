# Zasady bezpieczeństwa

Krótki dokument, ale bezwzględnie egzekwowany — punkty biorą się wprost
z wymagań protokołu (SERVER_PROTOCOL §4–5) i zdrowego rozsądku mobile.

## 1. Sekrety sesji i urządzenia

| Dana | Gdzie żyje | Zasady |
|---|---|---|
| `device_id` | `flutter_secure_storage` (Keychain / EncryptedSharedPreferences) | generowany **raz** (uuid v4) przy pierwszym uruchomieniu; nigdy nie regenerowany, nigdy nie pokazywany w UI, nigdy nie logowany |
| `resume_token` | `flutter_secure_storage` | nadpisywany po **każdym** `connection.accepted`; nigdy w logach; czyszczony, gdy serwer odrzuci resume |
| `user_id` | tylko pamięć procesu | efemeryczny — **zakaz** trwałego zapisu i budowania na nim jakiejkolwiek historii |

## 2. Transport

- Produkcja: **wyłącznie `wss://`**. Plain `ws://` dozwolony tylko dla
  `localhost` w developmencie.
- Adres serwera przez `--dart-define` — brak adresów produkcyjnych
  zahardkodowanych w kodzie.
- Nie wyłączamy weryfikacji certyfikatów TLS („na chwilę, bo dev" — nie).

## 3. Dane wrażliwe w logach i narzędziach

**Nigdy nie logujemy:** `resume_token`, `device_id`, treści wiadomości,
powodów zgłoszeń, dokładnych współrzędnych użytkownika. W logach ramek
(debug) pola wrażliwe maskujemy (`"resume_token": "***"`).

## 4. Prywatność lokalizacji

- Prosimy o lokalizację **when-in-use** (nie background) — więcej nie
  potrzebujemy.
- Pozycje innych użytkowników są celowo rozmyte przez serwer — w UI zawsze
  „~" przy dystansie; **nie rysujemy pinezek na mapie**.
- Teksty uzasadnień uprawnień (`Info.plist` / manifest) mówią prawdę: po co
  i kiedy używamy lokalizacji.

## 5. Repozytorium

- Zakaz commitowania: keystore Androida, haseł, tokenów, plików `.env*`
  (jest w `.gitignore`), profili provisioning.
- Gdy sekret wycieknie do historii gita → traktujemy jako skompromitowany:
  rotacja, nie tylko usunięcie pliku.

## 6. Walidacja wejścia

- Wszystko, co idzie do serwera, walidujemy lokalnie (limity z SERVER_PROTOCOL
  §1.4) — nie wysyłamy śmieci licząc, że serwer odrzuci.
- Wszystko, co przychodzi z serwera, parsujemy defensywnie: błędna ramka
  nie może wywrócić aplikacji (log + zignorowanie ramki).
