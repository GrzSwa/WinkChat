# Clean Architecture — zasady obowiązujące w projekcie

Ten dokument to **podręcznik zasad** — uniwersalne reguły, których w projekcie
nie łamiemy. Jak te zasady wyglądają konkretnie w WinkChat (jakie mamy warstwy,
blocki, repozytoria) opisuje [ARCHITECTURE.md](ARCHITECTURE.md).

## 1. Po co nam to

Clean Architecture porządkuje kod tak, żeby **logika biznesowa nie zależała od
szczegółów technicznych** (frameworka UI, biblioteki sieciowej, bazy danych).
Zyski, dla których płacimy ceną dodatkowych plików:

- logikę można testować bez Fluttera i bez sieci (szybkie unit testy),
- wymiana szczegółu (np. biblioteki WS) nie dotyka reguł biznesowych,
- czytelnik wie, gdzie szukać: „co robi apka" (domain) vs „jak to robi" (data,
  presentation).

## 2. Reguła zależności — jedyna święta zasada

```
presentation ──▶ domain ◀── data
```

**Zależności wskazują zawsze do środka, na domain. Nigdy odwrotnie.**

- `domain` **nie importuje niczego** z `presentation` ani `data`, ani żadnego
  pakietu frameworkowego (`flutter/*`, `flutter_bloc`, `web_socket_channel`,
  `geolocator`...). Dozwolone: czysty Dart + pakiety czysto darowe
  (np. `freezed_annotation`).
- `data` implementuje **interfejsy zdefiniowane w domain** (odwrócenie
  zależności) — domain mówi *czego* potrzebuje, data mówi *jak* to dostarczy.
- `presentation` woła domain (use case'y / repozytoria przez interfejs),
  nigdy bezpośrednio klas z `data`.
- Sprawdzian: **importy**. Jeśli plik w `domain/` importuje coś z `data/`
  lub `package:flutter/` — to błąd do naprawy, bez wyjątków.

## 3. Warstwy i ich obowiązki

### 3.1 Domain (środek — czysty Dart)
- **Encje** — obiekty biznesowe (np. `NearbyUser`, `ChatMessage`,
  `Invitation`). Niemutowalne, bez wiedzy o JSON-ie.
- **Interfejsy repozytoriów** — kontrakty, np. `abstract class
  ChatRepository { Stream<ChatMessage> get messages; ... }`.
- **Use case'y** — pojedyncze operacje biznesowe (np. `SendInvitation`).
  Jeden use case = jedna publiczna metoda `call()`.
- **Błędy domenowe** — typy niepowodzeń zrozumiałe biznesowo
  (patrz [ERROR_HANDLING.md](ERROR_HANDLING.md)).

### 3.2 Data (zewnętrze — „jak")
- **Modele/DTO** — reprezentacja ramek protokołu (freezed +
  json_serializable), z mapowaniem do/z encji domenowych.
- **Źródła danych (data sources)** — klient WebSocket, secure storage,
  geolocator; klasy „głupie", bez logiki biznesowej.
- **Implementacje repozytoriów** — sklejają data sources, tłumaczą DTO ↔
  encje i błędy techniczne → błędy domenowe.

### 3.3 Presentation (zewnętrze — „pokaż")
- **BLoC-i/Cubity** — stan ekranów; wołają use case'y, mapują wyniki na
  stany UI. Zero logiki biznesowej (walidacje reguł — w domain).
- **Widgety/ekrany** — czysto deklaratywne; zero decyzji biznesowych,
  zero bezpośrednich wywołań repozytoriów.

## 4. Encja vs model (DTO) — rozróżnienie, które musi wejść w krew

| | Encja (domain) | Model/DTO (data) |
|---|---|---|
| Reprezentuje | pojęcie biznesowe | kształt danych na drucie (JSON ramki) |
| Wie o JSON | ❌ | ✅ (`fromJson`/`toJson`) |
| Zmienia się gdy | zmienia się produkt | zmienia się protokół serwera |
| Przykład | `NearbyUser` z `Distance` | `NearbyUserDto` z `approx_longitude` |

Mapowanie DTO → encja odbywa się **w warstwie data** (w repozytorium lub
dedykowanym mapperze). UI nigdy nie widzi DTO.

## 5. Use case'y — kiedy tak, kiedy nie

- Use case ma sens, gdy operacja niesie **regułę biznesową** lub orkiestruje
  więcej niż jedno repozytorium (np. `InitializeSession` = wczytaj profil +
  odczytaj pozycję + połącz).
- Gdy use case byłby *czystym przelotem* (`call() => repo.x()`), wolno
  wstrzyknąć repozytorium (przez interfejs!) prosto do bloca. Pragmatyzm >
  dogmat — ale decyzję odnotowujemy w code review.

## 6. Czego świadomie NIE robimy (nadinżynieria)

- Osobnego pakietu na każdą warstwę (wystarczą katalogi + dyscyplina importów).
- Repozytoriów „na zapas" dla danych, których nie ma (np. brak REST → brak
  warstwy HTTP).
- Interfejsów dla klas, które mają i zawsze będą miały jedną implementację
  **i** nie są mockowane w testach.

## 7. Szybka checklista code review

1. Czy jakiś plik w `domain/` importuje Fluttera lub coś z `data/`? → błąd.
2. Czy widget/bloc dotyka DTO albo data source bezpośrednio? → błąd.
3. Czy encja ma `fromJson`? → błąd (to rola DTO).
4. Czy logika walidacji biznesowej siedzi w widgecie? → przenieś do domain.
5. Czy nowa zależność zewnętrzna wpięła się w domain? → opakuj ją w data.
