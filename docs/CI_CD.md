# CI/CD — automatyzacja weryfikacji i budowania

## 1. Zakres (świadoma decyzja)

Na tym etapie: **CI bez CD** — automatyczna weryfikacja i budowanie
artefaktów, **bez dystrybucji** (TestFlight/Sklep Play wymaga płatnych kont
deweloperskich; decyzja odłożona — patrz przyszły ADR-004).

Platforma: **GitHub Actions** (repo już na GitHubie; darmowy limit dla
prywatnych repozytoriów wystarcza).

## 2. Pipeline PR (workflow `ci.yml`) — plan

Uruchamiany na: `pull_request` do `main` oraz `push` na `main`.

```
┌─────────┐   ┌─────────┐   ┌───────┐   ┌───────────────────┐
│ format  │──▶│ analyze │──▶│ test  │──▶│ build (android+ios)│
└─────────┘   └─────────┘   └───────┘   └───────────────────┘
```

| Krok | Polecenie | Zasada |
|---|---|---|
| Format | `dart format --set-exit-if-changed .` | niesformatowany kod nie wchodzi |
| Analiza | `flutter analyze` | zero warningów (very_good_analysis) |
| Codegen | `dart run build_runner build -d` | weryfikacja, że wygenerowane pliki są aktualne |
| Testy | `flutter test --coverage` | wszystkie zielone |
| Build Android | `flutter build apk --debug` | na runnerze `ubuntu-latest` (tanio) |
| Build iOS | `flutter build ios --no-codesign` | na `macos-latest` — tylko weryfikacja kompilacji |

Szczegóły (cache pub/Gradle, wybór akcji do instalacji Fluttera, podział na
joby) opracujemy w Fazie 10 — to materiał lekcji, nie do przepisania z góry.

## 3. Zasady

1. **`main` jest chroniony**: merge tylko przez PR z zielonym CI (konfiguracja
   branch protection w Fazie 10.3).
2. **Czerwone CI = stop**: nie merge'ujemy „bo lokalnie działa"; najpierw
   naprawa pipeline'u.
3. CI wykonuje **dokładnie te same polecenia**, co checklist lokalny
   ([GIT_WORKFLOW.md](GIT_WORKFLOW.md) §4) — żadnej magii dostępnej tylko w CI.
4. Sekrety wyłącznie przez GitHub Secrets (na razie żadnych nie potrzebujemy —
   build iOS bez podpisu).
5. Workflow też podlega review — zmiany w `.github/workflows/` to commity
   `ci: ...`.

## 4. Możliwa przyszłość (poza zakresem, zapisane żeby nie zapomnieć)

- Golden testy w CI (uwaga na różnice renderowania między maszynami).
- Automatyczny CHANGELOG/wersjonowanie z Conventional Commits.
- Dystrybucja: TestFlight / Firebase App Distribution + fastlane — wymaga
  Apple Developer Program (99 USD/rok) / konta Google Play (25 USD).
