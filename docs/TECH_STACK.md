# Stack technologiczny

Każda pozycja ma uzasadnienie i odrzucone alternatywy — w profesjonalnym
projekcie „bo tak" nie jest argumentem. Wersje pakietów ustalimy przy
faktycznym dodawaniu do `pubspec.yaml` (zawsze aktualna stabilna).

## 1. Fundament

| Technologia | Rola | Dlaczego |
|---|---|---|
| **Flutter (kanał stable)** | framework UI, iOS + Android z jednego kodu | cel nauki; dojrzały ekosystem; jeden kod na obie platformy |
| **Dart** | język | null safety, sealed classes, świetne wsparcie async/Streams — idealne pod protokół eventowy |

## 2. Pakiety produkcyjne

| Pakiet | Rola | Dlaczego / odrzucone alternatywy |
|---|---|---|
| `flutter_bloc` | zarządzanie stanem | jawny przepływ event→state pasuje do aplikacji sterowanej eventami serwera; standard komercyjny; świetne narzędzia testowe. Odrzucone: Riverpod (dobry, ale mniej „eventowy"), Provider (za mało struktury), setState (nie skaluje się). **ADR-001** |
| `go_router` | nawigacja | deklaratywne trasy + globalne redirecty (ban, koniec rozmowy) sterowane stanem; wspierany przez zespół Fluttera. Odrzucone: Navigator 1.0 (imperatywny, trudne globalne redirecty), auto_route (więcej magii generowanej) |
| `get_it` | dependency injection | prosty service locator, zero magii, łatwa podmiana w testach. Odrzucone: injectable (codegen na wyrost przy tej skali), wstrzykiwanie przez konstruktory ręcznie w main (nieczytelne przy większej liczbie zależności) |
| `freezed` + `json_serializable` | niemutowalne modele, unie, (de)serializacja | sealed unie idealne na eventy protokołu i stany bloców; eliminują ręczny boilerplate `==`/`copyWith`/`fromJson` |
| `web_socket_channel` | klient WebSocket | oficjalny, minimalny — API Streamów, na którym budujemy własną warstwę protokołu (cel dydaktyczny: rozumieć, nie tylko używać). Odrzucone: socket_io (inny protokół!), gotowe „kombajny" reconnectujące (uczymy się backoffu sami) |
| `geolocator` | lokalizacja + uprawnienia | de facto standard, obsługuje oba systemy i strumień pozycji |
| `flutter_secure_storage` | Keychain / EncryptedSharedPreferences | wymóg protokołu: `device_id` i `resume_token` to sekrety (SERVER_PROTOCOL §5.1, §4.5) |
| `shared_preferences` | trwałe dane niewrażliwe | profil użytkownika (pseudonim/wiek/promień) do ponownego initu |
| `uuid` | generowanie `device_id` i `correlation_id` | wymóg protokołu |
| `intl` + `flutter_localizations` | l10n pl/en | wymóg projektu: oba języki od startu |
| `equatable` | — nie używamy | freezed załatwia porównywanie; jeden mechanizm zamiast dwóch |

## 3. Pakiety developerskie (dev_dependencies)

| Pakiet | Rola |
|---|---|
| `very_good_analysis` | surowy zestaw reguł lintera (ponad `flutter_lints`); zasada „zero warningów" |
| `build_runner` | uruchamianie generatorów (freezed, json_serializable) |
| `mocktail` | mocki w testach bez codegenu (odrzucone: mockito — wymaga generacji) |
| `bloc_test` | deklaratywne testy bloców (`blocTest`) |
| `golden_toolkit` / wbudowane golden testy | testy wyglądu — decyzja w Fazie 9 |

## 4. Zasady zarządzania zależnościami

1. **Każdy nowy pakiet wymaga uzasadnienia** — wpis w tej tabeli w tym samym
   PR, który go dodaje. Duże decyzje → ADR.
2. Preferujemy pakiety: utrzymywane przez zespoły Flutter/Dart lub o ugruntowanej
   pozycji (pub.dev: likes, popularity, aktywne wydania).
3. `pubspec.lock` **jest commitowany** (aplikacja = powtarzalne buildy).
4. Wersje przypinamy przez `^` (caret); podbicia zależności to osobne commity
   `chore(deps): ...`.
5. Nie dodajemy pakietu, gdy funkcja to < 50 linii własnego kodu, który
   rozumiemy (przykład: exponential backoff piszemy sami).
