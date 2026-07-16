# ADR-001: flutter_bloc jako biblioteka zarządzania stanem

- **Status:** zaakceptowany
- **Data:** 2026-07-16

## Kontekst

WinkChat jest aplikacją **sterowaną eventami serwera**: jedno połączenie
WebSocket wypycha zdarzenia (nearby, zaproszenia, wiadomości, bany), na które
UI musi reagować — także bez akcji użytkownika. Potrzebujemy podejścia do
stanu, które: (1) naturalnie modeluje strumienie zdarzeń, (2) jest testowalne
w izolacji od UI, (3) uczy wzorców używanych w komercyjnych projektach.

## Decyzja

Używamy `flutter_bloc` (wzorzec BLoC; Cubit tam, gdzie pełny Bloc jest
przerostem). Stany i eventy modelujemy jako unie freezed.

## Rozważane alternatywy

- **Riverpod** — nowoczesny i bardzo dobry; odrzucony, bo model
  provider/notifier słabiej mapuje się na „strumień eventów → przejścia
  stanów" niż jawne eventy BLoC, a celem nauki jest też sam wzorzec
  event-driven.
- **Provider / ChangeNotifier** — za mało struktury dla tej złożoności
  (maszyna stanów połączenia, wyścigi eventów).
- **setState** — nie skaluje się poza pojedynczy widget.

## Konsekwencje

- ✅ jawny, audytowalny przepływ: event → bloc → state; `bloc_test` do
  deklaratywnych testów.
- ✅ wymusza oddzielenie UI od logiki (wspiera Clean Architecture).
- ➖ więcej boilerplate'u niż w Riverpod; łagodzimy freezed'em.
- ➖ stromsza krzywa nauki — akceptowana świadomie (cel edukacyjny).
