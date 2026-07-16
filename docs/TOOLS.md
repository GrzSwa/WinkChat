# Narzędzia developerskie i środowisko

Rozróżnienie: **technologie** (to, co trafia do aplikacji —
[TECH_STACK.md](TECH_STACK.md)) vs **narzędzia** (to, co masz zainstalowane
na komputerze — ten dokument).

## 1. Wymagane narzędzia

| Narzędzie | Rola | Weryfikacja |
|---|---|---|
| **Flutter SDK** (stable, aktualny) | kompilator, CLI, DevTools | `flutter --version` |
| **Xcode** (aktualny) + Command Line Tools | build i symulator iOS | `xcodebuild -version` |
| **CocoaPods** | zależności natywne iOS | `pod --version` |
| **Android Studio** + Android SDK | build i emulator Androida | `flutter doctor` |
| **VS Code / Android Studio** z pluginami Flutter+Dart | edytor | — |
| **Git** + konto GitHub | kontrola wersji | `git --version` |
| **GitHub CLI (`gh`)** | PR-y z terminala (opcjonalnie, wygodne) | `gh --version` |

**Złota zasada:** `flutter doctor -v` musi być czyste (zero ✗) zanim
zaczniemy jakąkolwiek pracę. To pierwsze polecenie przy każdym dziwnym
problemie ze środowiskiem.

## 2. Codzienny warsztat

```bash
flutter pub get                  # po każdej zmianie pubspec.yaml
flutter run                      # uruchomienie (wybór urządzenia: flutter devices)
flutter run --dart-define=WS_URL=ws://localhost:8000/ws   # z konfiguracją dev
r / R                            # hot reload / hot restart (w działającej sesji)
flutter analyze                  # analiza statyczna — zero warningów przed commitem
dart format .                    # formatowanie — nie dyskutujemy o stylu
flutter test                     # unit + widget testy
dart run build_runner build --delete-conflicting-outputs  # codegen (freezed itd.)
dart run build_runner watch      # codegen w tle podczas pracy
```

### Hot reload vs hot restart — kiedy które
- **Hot reload (`r`)** — wstrzykuje zmieniony kod, zachowuje stan aplikacji.
  Nie zadziała po zmianach: w `main()`, inicjalizacji stanu, enumach,
  kodzie generowanym.
- **Hot restart (`R`)** — restartuje aplikację Darta (stan przepada), wciąż
  szybszy niż pełny rebuild.
- Zmiany natywne (`ios/`, `android/`, dodanie pluginu) → pełne zatrzymanie
  i `flutter run` od nowa.

## 3. Symulatory i emulatory

### iOS Simulator
- Start: `open -a Simulator` lub przez Xcode.
- **Lokalizacja symulowana:** Features → Location → Custom Location…
  (kluczowe dla WinkChat!). Do testów dwóch użytkowników obok siebie —
  dwa symulatory z pozycjami oddalonymi o < promień.
- Ograniczenia symulatora: brak prawdziwego GPS, powiadomień push, kamery.

### Android Emulator
- Tworzenie: Android Studio → Device Manager.
- Lokalizacja: trzy kropki (Extended controls) → Location.
- `10.0.2.2` = localhost hosta (ważne przy łączeniu z lokalnym serwerem!);
  na symulatorze iOS localhost działa wprost.

## 4. DevTools

`flutter run` wypisuje link do DevTools. Najużyteczniejsze zakładki:
- **Widget Inspector** — drzewo widgetów, debugowanie layoutu (overflow!),
- **Logging/Network** — podgląd logów,
- **Performance** — gdy UI klatkuje (jank).

## 5. Higiena środowiska

- Aktualizacje Fluttera: `flutter upgrade` świadomie (nie w środku sprintu);
  po aktualizacji: `flutter clean && flutter pub get` i pełny przebieg testów.
- `flutter clean` — pierwsza pomoc przy „niemożliwych" błędach builda
  (po nim trzeba `pub get` i na iOS często `pod install` w `ios/`).
- Wersję Fluttera, na której pracujemy, odnotowujemy w README po Fazie 0
  (decyzja FVM vs globalny SDK → ADR-002).
