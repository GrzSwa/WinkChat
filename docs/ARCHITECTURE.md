# Architektura aplikacji WinkChat

Ten dokument opisuje, **jak konkretnie** WinkChat realizuje zasady z
[CLEAN_ARCHITECTURE.md](CLEAN_ARCHITECTURE.md). Aktualizowany w miarę rozwoju
projektu (sekcje oznaczone 🚧 doprecyzujemy, gdy dojdziemy do nich w planie).

## 1. Widok z lotu ptaka

```
┌─────────────────────────────────────────────────────────┐
│ PRESENTATION   ekrany (widgety) ← BLoC/Cubit             │
│                     go_router (nawigacja)                │
├─────────────────────────────────────────────────────────┤
│ DOMAIN         encje · use case'y · interfejsy repo      │
│                błędy domenowe (Failure)                  │
├─────────────────────────────────────────────────────────┤
│ DATA           repozytoria (impl) · mappery              │
│   źródła:  WsClient (WebSocket) · SecureStorage ·        │
│            Geolocator · SharedPreferences                │
└─────────────────────────────────────────────────────────┘
        DI: get_it (kompozycja w main.dart)
```

Aplikacja jest **sterowana eventami serwera**: jedno połączenie WebSocket
jest źródłem prawdy o świecie (lista nearby, zaproszenia, wiadomości), a UI
reaguje na strumień eventów. Stąd centralna rola Streamów i BLoC.

## 2. Przepływ danych (przykład: przychodzi wiadomość)

```
serwer ──ramka JSON──▶ WsClient ──▶ ServerEvent (DTO, sealed class)
  ──▶ ChatRepositoryImpl (mapowanie DTO→encja ChatMessage)
  ──▶ Stream<ChatMessage> (kontrakt z domain)
  ──▶ ChatBloc (nowy stan z dopiętą wiadomością)
  ──▶ BlocBuilder → przerysowanie listy dymków
```

W drugą stronę (użytkownik wysyła): widget → event do `ChatBloc` → use case /
repo → `WsClient.send()` z `correlation_id`; dymek lokalnie w stanie
„wysyłanie", potwierdzenie przez **echo** `message.received`.

## 3. Rdzeń: warstwa połączenia

Najważniejszy element architektury — wszystko inne na nim stoi.

### 3.1 WsClient (data source)
- Cienkie opakowanie na `web_socket_channel`: connect/close, `Stream` ramek
  przychodzących, wysyłka, ekspozycja kodu zamknięcia.
- Nie zna protokołu WinkChat — operuje surowym JSON-em.

### 3.2 SessionManager / ConnectionRepository 🚧 (nazwa do ustalenia w Fazie 5)
Właściciel **maszyny stanów połączenia**:

```
 idle ──connect──▶ connecting ──socket open──▶ handshaking
   ▲                                             │ init / resume
   │                                   ┌─────────┴─────────┐
   │                          accepted/resumed        error/banned
   │                                   ▼                   ▼
   └──────backoff────── reconnecting ◀── socket lost    terminal
```

Odpowiada za: handshake jako pierwszą ramkę, `session.resume` po zerwaniu,
exponential backoff (1→2→4…max 30 s), reakcje na kody zamknięcia
(1002/1013/4001/4003), okres łaski ~120 s, rotację `resume_token`.

### 3.3 Dispatcher eventów
Rozdziela `Stream<ServerEvent>` do repozytoriów tematycznych (nearby,
invitations, chat, session). Odpowiedzi żądań dopasowywane po
`correlation_id` (mapa oczekujących żądań + timeout). Nieznane `type` —
ignorowane (forward compatibility).

## 4. Zarządzanie stanem (BLoC)

- **Zasada:** jeden BLoC na obszar odpowiedzialności ekranu, nie na widget.
- Przewidywane blocki 🚧: `ConnectionBloc` (globalny stan sesji — dostępny
  nad routerem, bo ban/replaced mogą przyjść wszędzie), `OnboardingBloc`,
  `NearbyBloc`, `InvitationsBloc`, `ChatBloc`, `ReportCubit`.
- Cubit zamiast Bloca tam, gdzie nie ma złożonych eventów (proste formularze).
- Stany i eventy jako klasy freezed (unie) — wyczerpujące `switch` gwarantuje
  obsłużenie każdego przypadku.
- **Kolejność eventów bywa zaskakująca** (protokół §4.8): każdy stan czatu
  musi umieć przejść do „rozmowa zakończona", a każdy ekran do „zbanowany".

## 5. Nawigacja

- `go_router`; trasy 🚧: `/onboarding`, `/nearby`, `/chat/:roomId`, `/banned`.
- Nawigacją sterują **stany globalne**: `ConnectionBloc` w stanie `banned` →
  redirect na `/banned`; `conversation.ended` → powrót na `/nearby` z każdego
  miejsca. Redirecty w routerze, nie rozsiane po widgetach.

## 6. DI i kompozycja

- `get_it` konfigurowany w jednym miejscu (`lib/core/di/`).
- Rejestracje: data sources i repozytoria jako singletony (jedno połączenie!),
  use case'y jako fabryki, blocki tworzone per ekran przez `BlocProvider`
  (poza globalnym `ConnectionBloc`).
- Testy podmieniają rejestracje na fake'i/mocki.

## 7. Konfiguracja środowisk

- Adres serwera przez `--dart-define=WS_URL=...`; dev: `ws://localhost:8000/ws`,
  prod: `wss://…`. Zero adresów zahardkodowanych w kodzie źródłowym.

## 8. L10n

- `flutter_localizations` + pliki ARB (`lib/l10n/app_pl.arb`, `app_en.arb`).
- Żadnych stringów użytkownika w kodzie — wszystko przez `AppLocalizations`.

## 9. Decyzje architektoniczne

Każda istotna decyzja ma wpis w [docs/adr/](adr/). Dotychczas:
- ADR-001: flutter_bloc jako zarządzanie stanem.
