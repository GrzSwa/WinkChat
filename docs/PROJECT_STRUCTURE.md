# Struktura projektu

Stosujemy podejście **feature-first**: kod dzielimy najpierw według
funkcjonalności (feature), a dopiero wewnątrz feature'a według warstw
Clean Architecture. Alternatywę (layer-first: globalne katalogi
`data/domain/presentation`) odrzucamy, bo przy rosnącym projekcie rozrzuca
jeden feature po całym drzewie.

## 1. Drzewo katalogów

```
winkchat/
├── android/                  # projekt natywny Android (nie ruszamy bez potrzeby)
├── ios/                      # projekt natywny iOS (jw.)
├── assets/                   # obrazy, fonty (rejestrowane w pubspec.yaml)
├── docs/                     # dokumentacja projektu (ten katalog)
│   └── adr/                  # Architecture Decision Records
├── lib/
│   ├── main.dart             # entrypoint: DI, uruchomienie aplikacji
│   ├── app/                  # korzeń aplikacji
│   │   ├── app.dart          # widget App (MaterialApp.router, theme, l10n)
│   │   ├── router/           # konfiguracja go_router, redirecty globalne
│   │   └── theme/            # ThemeData, kolory, typografia
│   ├── core/                 # kod wspólny, NIE-biznesowy
│   │   ├── di/               # konfiguracja get_it
│   │   ├── error/            # bazowe typy Failure, Result
│   │   ├── utils/            # drobiazgi ogólne (formatery itp.)
│   │   └── widgets/          # współdzielone widgety „głupie" (przyciski itp.)
│   ├── features/
│   │   ├── connection/       # sesja: init/resume/reconnect/ban  ★ rdzeń
│   │   │   ├── data/
│   │   │   │   ├── datasources/   # WsClient, storage tokenów
│   │   │   │   ├── models/        # DTO ramek protokołu
│   │   │   │   └── repositories/  # implementacje
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   ├── repositories/  # interfejsy (abstract class)
│   │   │   │   └── usecases/
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       ├── screens/
│   │   │       └── widgets/       # widgety prywatne feature'a
│   │   ├── onboarding/       # profil + uprawnienia + wejście
│   │   ├── nearby/           # lista osób w pobliżu, location updates
│   │   ├── invitations/      # wysyłanie/odbiór zaproszeń
│   │   ├── chat/             # pokój, wiadomości, zgłaszanie, koniec rozmowy
│   │   └── ban/              # ekran blokady
│   └── l10n/                 # app_pl.arb, app_en.arb
├── test/                     # lustrzane odbicie lib/ (patrz TESTING.md)
│   ├── features/...
│   ├── core/...
│   └── helpers/              # fake serwer WS, buildery testowe, fixtures
├── integration_test/         # testy end-to-end
├── pubspec.yaml
├── analysis_options.yaml
├── CLAUDE.md · README.md · CHANGELOG.md
└── .github/workflows/        # CI (patrz CI_CD.md)
```

> **Uwaga:** powyższe drzewo to stan **docelowy**, nie stan do odtworzenia od
> razu. Katalogów nie tworzymy „na zapas" — powstają wtedy, gdy pojawia się
> w nich realny kod (YAGNI). Nie stosujemy też plików-wypełniaczy
> (`README.md`/`.gitkeep`) w pustych katalogach: strukturę dokumentuje ten
> plik i tylko on.

## 2. Zasady rozmieszczania kodu (nie łamiemy)

1. **Plik należy do feature'a, którego dotyczy.** Do `core/` trafia wyłącznie
   kod bez wiedzy biznesowej, używany przez ≥ 2 feature'y. „Może się przyda"
   ≠ powód, by coś było w `core/`.
2. **Wewnątrz feature'a obowiązuje reguła zależności** —
   [CLEAN_ARCHITECTURE.md](CLEAN_ARCHITECTURE.md) §2.
3. **Między feature'ami:** wolno importować wyłącznie z warstwy `domain`
   innego feature'a (np. `chat` używa encji sesji z `connection/domain`).
   Import cudzego `data/` lub `presentation/` — zabroniony.
4. **Widget współdzielony przez ≥ 2 feature'y** → `core/widgets/`; używany
   przez jeden → `features/<x>/presentation/widgets/`.
5. **Testy lustrzane:** test pliku `lib/features/chat/domain/usecases/
   send_message.dart` leży w `test/features/chat/domain/usecases/
   send_message_test.dart`.

## 3. Konwencje nazewnictwa

| Co | Konwencja | Przykład |
|---|---|---|
| Pliki i katalogi | `snake_case` | `nearby_user.dart` |
| Klasy, enumy, typedefy | `UpperCamelCase` | `NearbyUser` |
| Zmienne, metody, stałe | `lowerCamelCase` | `sendInvitation` |
| DTO | sufiks `Dto` | `NearbyUserDto` |
| Interfejs repo | bez prefiksu `I` | `ChatRepository` |
| Implementacja repo | sufiks `Impl` | `ChatRepositoryImpl` |
| Use case | czasownik + rzeczownik | `SendMessage`, `EndConversation` |
| Bloc/Cubit/eventy/stany | sufiksy `Bloc`/`Cubit`/`Event`/`State` | `ChatBloc`, `ChatState` |
| Ekrany | sufiks `Screen` | `NearbyScreen` |
| Pliki generowane | `*.g.dart`, `*.freezed.dart` | (commitowane — patrz ADR w przyszłości) |

## 4. Zasady dla katalogów natywnych (`ios/`, `android/`)

- Zmieniamy tylko świadomie i punktowo (uprawnienia w `Info.plist`/
  `AndroidManifest.xml`, ikony, podpisywanie) — każda zmiana natywna to
  osobny commit z wyjaśnieniem.
- Sekretów (keystore, hasła) **nigdy** nie commitujemy —
  [SECURITY.md](SECURITY.md).
