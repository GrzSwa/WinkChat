# Plan nauki — mapa budowy WinkChat

Każdy punkt przechodzi cykl: **teoria → zadanie → Twoja implementacja →
code review → commit → ☑**. Punkt można odhaczyć dopiero, gdy spełnia
[DEFINITION_OF_DONE.md](DEFINITION_OF_DONE.md).

Legenda: `[ ]` do zrobienia · `[x]` skończone · 🎓 = lekcja z większą dawką
teorii · 🔨 = głównie praktyka · 📝 = ćwiczenie z pisania ADR/dokumentacji

---

## Faza 0 — Środowisko

Cel: `flutter doctor` bez żadnych błędów, działający symulator iOS i emulator
Androida.

- [x] 0.1 🎓 Jak działa toolchain Fluttera (SDK, kanały, silnik, embeddery
      iOS/Android) i po co nam FVM
- [x] 0.2 🔨 Aktualizacja: Xcode + Command Line Tools, Flutter do najnowszego
      stable (decyzja: FVM czy globalny SDK → 📝 ADR-002)
      → Flutter 3.44.6 przez FVM, Xcode 26.2 + CocoaPods 1.17.0,
      Android SDK 36.0.0; web świadomie pominięty
- [x] 0.3 🔨 Symulator iOS: uruchomienie, podstawy obsługi (lokalizacja
      symulowana!), emulator Androida w Android Studio
      → iPhone 17 (iOS 26.2) + Pixel 10 Pro (Android 17) wykryte przez
      `fvm flutter devices`
- [x] 0.4 🔨 Konfiguracja edytora: pluginy Flutter/Dart, format-on-save,
      DevTools → edytor: Zed (wtyczki Flutter/Dart/BLoC, format-on-save on).
      Dopięcie Zeda do SDK z FVM (.fvm/flutter_sdk) → do zrobienia w Fazie 2

## Faza 1 — Przypomnienie Darta

Cel: swoboda w konstrukcjach, na których stoi cały projekt. Formuła: krótkie
ćwiczenia w `dartpad` / katalogu scratch, nie w repo.

- [x] 1.1 🎓 Null safety na poważnie: `?`, `!`, `late`, `required`, promowanie
      typów → typ ma odzwierciedlać domenę (`String?` = wartość naprawdę bywa null)
- [x] 1.2 🎓 Klasy: konstruktory nazwane/fabryczne, niemutowalność (`final`/
      `const`), fabryka `fromMap`, `num.toInt()/toDouble()` przy JSON.
      `sealed`/`abstract`, mixiny, `extension` — pełny drill w Fazie 5
- [x] 1.3 🎓 **Asynchroniczność: `Future`, `async/await`, obsługa błędów** —
      fundament (uwaga: żaden `return`/`throw` w `finally`)
- [x] 1.4 🎓 **`Stream` i `StreamController`** — na tym stoi WebSocket i BLoC;
      broadcast vs single-subscription, `listen` (onData/onError/onDone),
      sprzątanie subskrypcji (`cancel`)
- [x] 1.5 🔨 Ćwiczenie zbiorcze: mini-symulator „serwera" na Streamach
      (Future=request/response, Stream=push; zapowiedź FakeWinkChatServer)

## Faza 2 — Inicjalizacja projektu

Cel: puste, ale profesjonalnie skonfigurowane repo z aplikacją „szkieletem"
odpaloną na obu platformach.

- [ ] 2.1 🎓 Anatomia projektu Flutter: co generuje `flutter create`, do czego
      są katalogi `ios/`, `android/`, czym jest `pubspec.yaml`
- [ ] 2.2 🔨 `flutter create` (org, nazwa pakietu — decyzja świadoma!),
      pierwsze uruchomienie na iOS i Androidzie
- [ ] 2.3 🔨 Porządki w repo: poprawny `.gitignore` dla aplikacji Flutter
      (m.in. **commitujemy `pubspec.lock`** — wyjaśnienie: aplikacja vs
      biblioteka), usunięcie śmieci z szablonu
- [ ] 2.4 🔨 Linter: `very_good_analysis`, zasada „zero warningów",
      `dart format`
- [ ] 2.5 🎓 Git: Conventional Commits + branching wg
      [GIT_WORKFLOW.md](GIT_WORKFLOW.md); pierwsze commity wg konwencji,
      push na GitHub, konfiguracja branch protection
- [ ] 2.6 🔨 Struktura katalogów wg [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)
      (na razie puste katalogi z plikami README/`.gitkeep`)
- [ ] 2.7 🔨 Przypięcie wersji do projektu: `fvm use 3.44.6` (powstaje
      `.fvmrc`), `.gitignore` pod FVM (commit `.fvmrc`, ignoruj `.fvm/`),
      dopięcie edytora Zed do `.fvm/flutter_sdk` (analiza na wersji z FVM)

## Faza 3 — Podstawy Flutter: UI bez logiki

Cel: statyczne makiety głównych ekranów wg projektu z Claude Design;
swoboda w budowaniu layoutów.

- [ ] 3.1 🎓 Drzewo widgetów, `StatelessWidget` vs `StatefulWidget`,
      `BuildContext`, cykl życia stanu
- [ ] 3.2 🎓 Layout: `Row`/`Column`/`Stack`/`Expanded`/`Flexible`,
      constraints („constraints go down, sizes go up"), overflow
- [ ] 3.3 🔨 Theming: `ThemeData`, Material 3, kolory/typografia z projektu
      Claude Design, tryb jasny/ciemny
- [ ] 3.4 🔨 Ekran onboardingu (formularz profilu) — statycznie
- [ ] 3.5 🔨 Ekran listy nearby (karta użytkownika, dystans „~") — statycznie,
      na sztucznych danych
- [ ] 3.6 🔨 Ekran czatu (dymki, pole wiadomości, licznik znaków) — statycznie
- [ ] 3.7 🎓 Nawigacja: go_router, trasy, przekazywanie parametrów, deep-link
      mindset; spięcie ekranów
- [ ] 3.8 🔨 L10n od początku: konfiguracja `flutter_localizations` + ARB
      (pl/en), wszystkie teksty ekranów przez `AppLocalizations`

## Faza 4 — Clean Architecture w praktyce

Cel: zrozumieć i postawić szkielet warstw na jednym małym, kompletnym
przykładzie.

- [ ] 4.1 🎓 Wykład: reguła zależności, warstwy, encje vs modele,
      use case'y — [CLEAN_ARCHITECTURE.md](CLEAN_ARCHITECTURE.md)
- [ ] 4.2 🎓 Dependency Injection: po co, czym jest get_it, rejestracja
      zależności, kompozycja w `main.dart`
- [ ] 4.3 🔨 Pierwszy pełny pion: feature `profile` (lokalny zapis profilu
      użytkownika) — encja, repozytorium (interfejs w domain, implementacja
      w data na `shared_preferences`), use case
- [ ] 4.4 🔨 Testy jednostkowe do 4.3 (mocktail) — pierwsze testy w projekcie
- [ ] 4.5 📝 ADR-003: feature-first + Clean Architecture (napisz sam, ja
      zrecenzuję)

## Faza 5 — Protokół i warstwa danych (serce projektu)

Cel: kompletny, przetestowany klient protokołu WinkChat — jeszcze bez UI.
Najdłuższa i najważniejsza faza.

- [ ] 5.1 🎓 Anatomia protokołu: ramka, `correlation_id`, handshake, wersja —
      czytanie [SERVER_PROTOCOL.md](SERVER_PROTOCOL.md) ze zrozumieniem
- [ ] 5.2 🎓 Modelowanie eventów: freezed + json_serializable, sealed classes
      jako reprezentacja eventów serwera, zasada „nieznany `type` ignoruj"
- [ ] 5.3 🔨 Modele wszystkich eventów klient→serwer i serwer→klient + testy
      (de)serializacji
- [ ] 5.4 🔨 Niskopoziomowy klient WS (`web_socket_channel`): connect, wysyłka,
      strumień ramek, wykrywanie zamknięcia i kodów 1002/1013/4001/4003
- [ ] 5.5 🔨 Warstwa żądanie–odpowiedź: generowanie `correlation_id` (uuid),
      dopasowywanie odpowiedzi i błędów, timeouty
- [ ] 5.6 🎓+🔨 **Maszyna stanów połączenia**: disconnected → connecting →
      handshake (init/resume) → connected → reconnecting; exponential backoff;
      ścieżka `RESUME_FAILED` → pełny init
- [ ] 5.7 🔨 Fake serwer WS do testów + testy integracyjne całego klienta
      (scenariusze z §2 protokołu: init, zaproszenia, czat, resume, ban)
- [ ] 5.8 🔨 Trwałość: `device_id` i `resume_token` w `flutter_secure_storage`
      wg [SECURITY.md](SECURITY.md)

## Faza 6 — BLoC i pierwsze żywe ekrany

Cel: aplikacja naprawdę łączy się z serwerem; działa onboarding i lista nearby.

- [ ] 6.1 🎓 Wykład BLoC: event → bloc → state, `Equatable`/freezed states,
      `BlocProvider`/`BlocBuilder`/`BlocListener`, kiedy Cubit wystarcza
- [ ] 6.2 🔨 Lokalizacja: geolocator, uprawnienia (iOS `Info.plist` /
      Android manifest), odczyt pozycji, obsługa odmowy uprawnień
- [ ] 6.3 🔨 Onboarding na żywo: walidacja formularza (username 1–50,
      wiek, promień ≤ 10 km), `connection.init`, obsługa `connection.banned`
- [ ] 6.4 🔨 Lista nearby na żywo: `nearby.updated` jako pełny snapshot,
      `location.update` z throttlingiem, pull-to-refresh pozycji
- [ ] 6.5 🔨 Testy: bloc_test dla ConnectionBloc i NearbyBloc, widget testy
      ekranów

## Faza 7 — Zaproszenia i czat

Cel: pełny happy path produktu + wszystkie rozgałęzienia zaproszeń.

- [ ] 7.1 🔨 Wysyłanie zaproszeń: stan oczekiwania, odliczanie z `expires_at`
      serwera, rozstrzygnięcia (accepted/rejected/cancelled/expired), limit
      1 wychodzącego
- [ ] 7.2 🔨 Odbiór zaproszeń: stos wielu zaproszeń, akceptacja/odrzucenie,
      ciche znikanie po `invitation.expired`
- [ ] 7.3 🔨 Pokój: `room.created` → natychmiast `room.join` → czekanie na
      `room.ready`
- [ ] 7.4 🔨 Czat: wysyłka, **renderowanie z echa** (`message.received` także
      własnych), stan „wysyłanie" do czasu echa, licznik 2000 znaków,
      rate limit w UI
- [ ] 7.5 🔨 Zakończenie rozmowy (wszystkie 4 przyczyny `conversation.ended`)
      i powrót do listy; zgłaszanie rozmówcy (`report.create`, jednorazowość)
- [ ] 7.6 🔨 Testy blocków i widgetów czatu/zaproszeń

## Faza 8 — Odporność: lifecycle, reconnect, bany

Cel: aplikacja przeżywa windę, tunel i przełączenie Wi-Fi→LTE.

- [ ] 8.1 🎓 Cykl życia aplikacji mobilnej (`AppLifecycleState`), co system
      robi z socketem w tle na iOS/Androidzie
- [ ] 8.2 🔨 Powrót do foreground = ścieżka `session.resume`; obsługa
      `room.peer_disconnected/reconnected` w UI
- [ ] 8.3 🔨 Ekran blokady (ban): `connection.banned`/`ban.imposed`, kod 4003,
      zakaz łączenia przed `expires_at`
- [ ] 8.4 🔨 `connection.replaced` (4001) i serwer pełny (1013) — komunikaty
      i zachowanie
- [ ] 8.5 🔨 Testy scenariuszy odporności na fake serwerze

## Faza 9 — Testowanie na poważnie

Cel: domknięcie piramidy testów; pewność przy refaktorach.

- [ ] 9.1 🎓 Wykład: piramida testów we Flutterze, co testować na którym
      poziomie — [TESTING.md](TESTING.md)
- [ ] 9.2 🔨 Uzupełnienie luk w unit/widget testach (przegląd pokrycia)
- [ ] 9.3 🔨 Golden testy kluczowych ekranów (jasny/ciemny, pl/en)
- [ ] 9.4 🔨 Testy integracyjne (`integration_test`): pełny przepływ
      onboarding → zaproszenie → czat → koniec, na fake serwerze

## Faza 10 — CI/CD

Cel: każdy PR automatycznie zweryfikowany; main zawsze zielony.

- [ ] 10.1 🎓 Wykład: po co CI, anatomia GitHub Actions (workflow, job, step,
      cache) — [CI_CD.md](CI_CD.md)
- [ ] 10.2 🔨 Workflow PR: format-check → analyze → test → build (Android APK
      + iOS bez podpisu)
- [ ] 10.3 🔨 Branch protection na `main` (wymagane przejście CI), badge
      w README
- [ ] 10.4 📝 ADR-004: zakres CI/CD (bez dystrybucji — świadoma decyzja)

## Faza 11 — Szlif

- [ ] 11.1 🔨 Audyt obsługi błędów: każdy kod z §3 protokołu ma zachowanie
      w UI wg [ERROR_HANDLING.md](ERROR_HANDLING.md)
- [ ] 11.2 🔨 Przegląd l10n: kompletność pl/en, formaty liczb/dat
- [ ] 11.3 🔨 Ikona aplikacji, splash screen, nazwa wyświetlana
- [ ] 11.4 🔨 Dostępność: rozmiary dotykowe, semantics, kontrast
- [ ] 11.5 🔨 Przegląd dokumentacji kodu wg
      [CODE_DOCUMENTATION.md](CODE_DOCUMENTATION.md); `dart doc` bez błędów

## Faza 12 — Build produkcyjny

- [ ] 12.1 🎓 Release build: obfuskacja, flavory/dart-define (adres serwera
      dev vs prod), różnice debug/profile/release
- [ ] 12.2 🔨 Android: podpisany APK/AAB (keystore — i jak go NIE zgubić)
- [ ] 12.3 🔨 iOS: build release na własne urządzenie (bez dystrybucji)
- [ ] 12.4 📝 Retrospektywa: co było najtrudniejsze, co zrobilibyśmy inaczej;
      aktualizacja CHANGELOG i wersji 1.0.0

---

## Zasady prowadzenia planu

- Plan jest **żywy** — wolno dodawać/rozbijać punkty, ale zmiany kolejności
  faz wymagają uzasadnienia.
- Jedna sesja nauki ≈ 1–3 punkty; nie zaczynamy nowej fazy z niedokończoną
  poprzednią.
- Odhaczenie punktu = spełniony [DEFINITION_OF_DONE.md](DEFINITION_OF_DONE.md)
  i zmiana w repo.
