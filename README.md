# WinkChat 📍💬

Anonimowy czat 1:1 z osobami w pobliżu — bez kont, bez rejestracji, bez historii.

Aplikacja mobilna (Flutter, iOS + Android) łącząca się z serwerem WinkChat przez
WebSocket. Widzisz listę osób w zadanym promieniu, wysyłasz zaproszenie,
rozmawiacie — a po zakończeniu rozmowy wszystko znika.

> **Uwaga:** ten projekt powstaje w trybie nauki — jest budowany krok po kroku
> zgodnie z [planem nauki](docs/LEARNING_PLAN.md), z naciskiem na profesjonalne
> praktyki (Clean Architecture, testy, CI/CD, Conventional Commits).

## Status projektu

🚧 **W budowie** — aktualna faza: patrz [docs/LEARNING_PLAN.md](docs/LEARNING_PLAN.md)

## Szybki start

```bash
# Wymagania: Flutter (stable), Xcode (iOS), Android Studio (Android)
flutter pub get
flutter run
```

Szczegółowa konfiguracja środowiska: [docs/TOOLS.md](docs/TOOLS.md)

## Dokumentacja

| Dokument | Opis |
|---|---|
| [PROJECT_OVERVIEW](docs/PROJECT_OVERVIEW.md) | Czym jest WinkChat — produkt, przepływy, słownik pojęć |
| [LEARNING_PLAN](docs/LEARNING_PLAN.md) | Plan nauki / mapa budowy projektu |
| [ARCHITECTURE](docs/ARCHITECTURE.md) | Architektura aplikacji — warstwy, przepływ danych, stan |
| [CLEAN_ARCHITECTURE](docs/CLEAN_ARCHITECTURE.md) | Zasady Clean Architecture obowiązujące w projekcie |
| [PROJECT_STRUCTURE](docs/PROJECT_STRUCTURE.md) | Struktura katalogów i konwencje nazewnictwa |
| [TECH_STACK](docs/TECH_STACK.md) | Technologie i pakiety — z uzasadnieniem wyborów |
| [TOOLS](docs/TOOLS.md) | Narzędzia developerskie i setup środowiska |
| [SERVER_PROTOCOL](docs/SERVER_PROTOCOL.md) | Protokół komunikacji z serwerem (WebSocket) |
| [ERROR_HANDLING](docs/ERROR_HANDLING.md) | Strategia obsługi błędów |
| [SECURITY](docs/SECURITY.md) | Zasady bezpieczeństwa |
| [GIT_WORKFLOW](docs/GIT_WORKFLOW.md) | Praca z gitem, Conventional Commits, branching |
| [TESTING](docs/TESTING.md) | Strategia i konwencje testowania |
| [CI_CD](docs/CI_CD.md) | Automatyzacja budowania i weryfikacji |
| [CODE_DOCUMENTATION](docs/CODE_DOCUMENTATION.md) | Standard dokumentowania kodu |
| [DEFINITION_OF_DONE](docs/DEFINITION_OF_DONE.md) | Kiedy zadanie jest naprawdę skończone |
| [docs/adr/](docs/adr/) | Rejestr decyzji architektonicznych (ADR) |

## Powiązane repozytoria

- **Serwer:** [WinkChat-server](https://github.com/GrzSwa) — gotowy backend
  (WebSocket), którego protokół opisuje [SERVER_PROTOCOL](docs/SERVER_PROTOCOL.md).

## Licencja

Projekt edukacyjny / prywatny.
