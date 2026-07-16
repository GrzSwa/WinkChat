# Git workflow — zasady pracy z repozytorium

## 1. Model gałęzi

- **`main`** — zawsze zielony (CI przechodzi), zawsze uruchamialny. Nigdy nie
  commitujemy bezpośrednio (branch protection od Fazy 10; do tego czasu —
  dyscyplina własna od Fazy 2.5).
- **Gałęzie robocze** — krótko żyjące, jedna gałąź = jedno zadanie z planu:

```
feat/nearby-list          # nowa funkcjonalność
fix/resume-after-ban      # naprawa błędu
docs/testing-guide        # dokumentacja
chore/update-deps         # prace porządkowe
refactor/ws-client-split  # refaktoryzacja
```

- Scalanie przez **Pull Request** (nawet solo — PR to miejsce na code review
  nauczyciela i zapis historii decyzji). Metoda: **squash and merge** —
  historia `main` czysta, 1 PR = 1 commit.

## 2. Conventional Commits — obowiązkowo

Format:

```
<typ>(<zakres>): <opis w trybie rozkazującym, małą literą, bez kropki>

[treść — CO i DLACZEGO, nie JAK]

[stopka, np. BREAKING CHANGE: ..., Refs: #12]
```

### Typy używane w projekcie

| Typ | Kiedy |
|---|---|
| `feat` | nowa funkcjonalność widoczna dla użytkownika |
| `fix` | naprawa błędu |
| `docs` | tylko dokumentacja (md, dartdoc) |
| `test` | tylko testy (dodanie/poprawa, bez zmian produkcyjnych) |
| `refactor` | zmiana struktury kodu bez zmiany zachowania |
| `style` | formatowanie, białe znaki (bez zmiany logiki) |
| `chore` | zależności, konfiguracja, porządki |
| `build` | system budowania, konfiguracja natywna (Gradle/Xcode) |
| `ci` | pliki workflow CI |
| `perf` | poprawa wydajności |

### Zakresy (scope) ustalone dla WinkChat

`connection` · `onboarding` · `nearby` · `invitations` · `chat` · `ban` ·
`core` · `l10n` · `deps` · `docs` — lista rośnie wraz z projektem; nowy scope
dopisujemy tutaj.

### Przykłady

```
✅ feat(chat): render messages from server echo
✅ fix(connection): reset backoff after successful resume
✅ test(invitations): cover expiry during accept race
✅ chore(deps): bump flutter_bloc to 9.x
✅ docs(adr): add ADR-003 feature-first structure

❌ update code                      # brak typu, nic nie mówi
❌ feat: dodałem czat i naprawiłem  # dwie zmiany w jednym + czas przeszły
   bug w liście                    # commit robi JEDNĄ rzecz
❌ fix(chat): Fixed bug.            # wielka litera, czas przeszły, kropka
```

## 3. Podział zmian — zasada atomowości

**Jeden commit = jedna logiczna zmiana.** Praktycznie:

1. Zmiana produkcyjna + jej testy + jej dokumentacja = **jeden** commit
   (to jedna logiczna zmiana).
2. Refaktor przygotowujący pod feature = **osobny** commit przed featurem
   (`refactor: ...`, potem `feat: ...`).
3. Poprawka formatowania niezwiązana z zadaniem = osobny commit (`style:`)
   albo wcale (nie mieszamy).
4. Wygenerowane pliki (`*.freezed.dart`) commitujemy razem ze źródłem, które
   je wygenerowało.
5. Test przed commitem: czy potrafisz opisać zmianę jednym zdaniem bez „i"?
   Jeśli nie — podziel.

## 4. Checklist przed commitem

```bash
dart format .            # 1. sformatowane
flutter analyze          # 2. zero warningów
flutter test             # 3. testy przechodzą
git add -p               # 4. przejrzyj KAŻDĄ dodawaną zmianę (nie `git add .`)
git commit               # 5. wiadomość wg konwencji
```

## 5. Czego nie commitujemy

- Sekretów: kluczy, keystore'ów, tokenów — [SECURITY.md](SECURITY.md).
- Plików IDE/OS: `.idea/`, `.vscode/` (poza uzgodnionymi), `.DS_Store`.
- Artefaktów builda: `build/`, `.dart_tool/`.
- **Uwaga:** `pubspec.lock` COMMITUJEMY (aplikacja, nie biblioteka).

## 6. Pull Requesty

- Tytuł PR = wiadomość przyszłego squash-commita (konwencja jw.).
- Opis: co, dlaczego, jak przetestowano; link do punktu LEARNING_PLAN.
- PR ma być mały — jeśli review wymaga > ~400 zmienionych linii, zwykle
  należało podzielić.
