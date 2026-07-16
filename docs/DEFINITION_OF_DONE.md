# Definition of Done

Punkt z [LEARNING_PLAN.md](LEARNING_PLAN.md) wolno odhaczyć dopiero, gdy
**wszystkie** pasujące pozycje są spełnione. To jest checklist używany przy
każdym code review.

## Kod

- [ ] Działa na **obu** platformach (uruchomione i sprawdzone na symulatorze
      iOS i emulatorze Androida — nie „powinno działać").
- [ ] `dart format .` — bez zmian; `flutter analyze` — zero warningów.
- [ ] Zgodny z regułą zależności i strukturą
      ([CLEAN_ARCHITECTURE.md](CLEAN_ARCHITECTURE.md),
      [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)).
- [ ] Obsłużone stany brzegowe i błędy wg [ERROR_HANDLING.md](ERROR_HANDLING.md)
      (nie tylko happy path).
- [ ] Teksty użytkownika przez l10n (pl **i** en — żadnych "TODO translation").
- [ ] Zero sekretów/danych wrażliwych w kodzie i logach
      ([SECURITY.md](SECURITY.md)).

## Testy

- [ ] Nowa logika ma testy na właściwym poziomie piramidy
      ([TESTING.md](TESTING.md)).
- [ ] `flutter test` — całość zielona (nie tylko nowe testy).

## Dokumentacja

- [ ] Publiczne API domain/core ma dartdoc
      ([CODE_DOCUMENTATION.md](CODE_DOCUMENTATION.md)).
- [ ] Zaktualizowane dokumenty w `docs/`, jeśli zmiana ich dotyczy
      (nowy pakiet → TECH_STACK; nowa decyzja → ADR; nowy scope → GIT_WORKFLOW).
- [ ] Wpis w `CHANGELOG.md` (sekcja Unreleased), jeśli zmiana jest widoczna
      dla użytkownika.

## Repozytorium

- [ ] Zmiany podzielone atomowo, commity wg Conventional Commits
      ([GIT_WORKFLOW.md](GIT_WORKFLOW.md)).
- [ ] PR opisany (co/dlaczego/jak przetestowano), CI zielone (od Fazy 10).

## Zrozumienie (kryterium nauki!)

- [ ] Potrafisz **własnymi słowami** wyjaśnić, dlaczego rozwiązanie wygląda
      tak, a nie inaczej — i jaką alternatywę odrzuciliśmy.
