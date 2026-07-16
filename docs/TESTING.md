# Strategia testowania

## 1. Piramida testów we Flutterze

```
        ▲  integration_test   — mało: pełne przepływy, wolne, na urządzeniu
       ▲▲  widget testy       — średnio: ekrany i widgety w izolacji
     ▲▲▲▲  unit testy         — dużo: domain, protokół, blocki; milisekundy
```

Zasada: **testuj na najniższym poziomie, na którym da się złapać błąd.**
Logika walidacji wiadomości nie potrzebuje widget testu; wygląd dymka czatu
nie potrzebuje testu integracyjnego.

## 2. Co testujemy na którym poziomie

| Poziom | Co | Narzędzia |
|---|---|---|
| Unit | encje, use case'y, mappery DTO↔encja, (de)serializacja ramek, maszyna stanów połączenia, backoff, blocki (`blocTest`) | `flutter_test`, `mocktail`, `bloc_test` |
| Widget | pojedyncze ekrany z zamockowanym blokiem: renderowanie stanów (loading/dane/błąd), interakcje (tap → event), walidacja formularzy w UI | `flutter_test` (`testWidgets`), `mocktail` |
| Golden | wygląd kluczowych ekranów: jasny/ciemny motyw, pl/en, stany brzegowe (pusta lista, długi pseudonim) | golden testy (decyzja nt. narzędzia w Fazie 9) |
| Integration | pełne przepływy na **fake serwerze**: onboarding→lista→zaproszenie→czat→koniec; reconnect/resume; ban | `integration_test` |

## 3. Fake serwer WebSocket — kluczowe narzędzie projektu

Prawdziwy serwer nie bierze udziału w testach automatycznych. W `test/helpers/`
utrzymujemy **FakeWinkChatServer**: lokalny serwer WS (albo kanał w pamięci),
który mówi protokołem z [SERVER_PROTOCOL.md](SERVER_PROTOCOL.md) i pozwala
skryptować scenariusze:

```dart
fakeServer.expectFrame('connection.init');
fakeServer.sendAccepted(nearbyUsers: [aUser()]);
fakeServer.dropConnection();          // symulacja utraty sieci
fakeServer.expectFrame('session.resume');
```

Dzięki temu testujemy także scenariusze **niemożliwe do wywołania ręcznie**:
wyścig `invitation.expired` vs `accept`, `conversation.ended` w trakcie
pisania, ban w środku rozmowy, kolejność eventów z §4.8 protokołu.

## 4. Konwencje

1. **Lustrzana struktura:** `lib/features/chat/domain/usecases/send_message.dart`
   → `test/features/chat/domain/usecases/send_message_test.dart`.
2. **Nazwy testów opisują zachowanie**, po angielsku, wzorzec
   „given/when/then" w treści:
   ```dart
   test('emits sending then sent when server echoes the message', ...);
   ```
3. **Struktura testu: Arrange–Act–Assert** — trzy wyraźne sekcje.
4. **Buildery danych testowych** w `test/helpers/builders.dart`
   (`aNearbyUser(distance: 500)`) zamiast kopiowania literałów po testach.
5. Mockujemy **interfejsy z domain**, nie klasy z data (mock granicy, nie
   implementacji). Fake > mock, gdy obiekt ma zachowanie (fake serwer).
6. Test, który czasem nie przechodzi (flaky), jest traktowany jak błąd —
   naprawiamy albo usuwamy, nigdy nie ignorujemy.
7. Żadnych `sleep`/realnych opóźnień — czas kontrolujemy przez
   `fakeAsync`/`blocTest`'owe `wait` tylko gdy konieczne.

## 5. Pokrycie

- Mierzymy: `flutter test --coverage` (raport w `coverage/lcov.info`).
- Cel orientacyjny: **domain + warstwa protokołu ≥ 90 %**, całość ≥ 70 %.
  Pokrycie to termometr, nie cel sam w sobie — nie piszemy testów „pod
  procenty", piszemy pod ryzyko.

## 6. Kiedy piszemy testy

- Razem ze zmianą, w tym samym commicie/PR ([GIT_WORKFLOW.md](GIT_WORKFLOW.md) §3).
- Naprawa buga zaczyna się od testu, który go **reprodukuje** (czerwony →
  fix → zielony).
- Zanim uznasz punkt planu za skończony —
  [DEFINITION_OF_DONE.md](DEFINITION_OF_DONE.md).
