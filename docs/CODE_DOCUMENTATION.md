# Dokumentowanie kodu

## 1. Dwa poziomy dokumentacji — nie mylić

1. **Dokumentacja projektu** (`docs/*.md`) — architektura, decyzje, konwencje.
   Odpowiada na „jak jest zbudowany system i dlaczego".
2. **Dokumentacja kodu** (dartdoc `///` + komentarze `//`) — przy kodzie,
   wersjonowana razem z nim. Odpowiada na „jak używać tego elementu i jakie
   ma nieoczywiste właściwości".

## 2. Dartdoc (`///`) — co dokumentujemy

**Obowiązkowo:**
- publiczne klasy warstwy `domain` (encje, use case'y, interfejsy repo) —
  to jest API biznesowe projektu,
- publiczne API `core/`,
- wszystko, co ma **nieoczywisty kontrakt**: np. że `nearby.updated` to pełny
  snapshot, że `resume_token` rotuje po każdym `connection.accepted`.

**Nie dokumentujemy** rzeczy oczywistych — `/// Zwraca listę użytkowników`
nad `List<User> getUsers()` to szum, nie dokumentacja.

### Zasady stylu dartdoc

```dart
/// Pojedyncze zdanie podsumowujące — zaczyna się wielką literą, kończy kropką.
///
/// Dalsze akapity: kontrakt, przypadki brzegowe, ograniczenia.
/// Odwołania do kodu w [nawiasach]: [ChatRepository], [sendMessage].
///
/// Rzuca [SessionExpiredException], gdy sesji nie da się wznowić.
abstract class ChatRepository { ... }
```

- Pierwsze zdanie musi działać samodzielnie (pojawia się w podpowiedziach IDE
  i w wygenerowanej dokumentacji).
- Dokumentujemy **kontrakt** (co gwarantuje, co rzuca, co jest niedozwolone),
  nie implementację.
- Parametry opisujemy prozą w treści, gdy są nieoczywiste (Dart nie używa
  `@param`).
- Język dartdoc (`///`): **angielski** — standard branżowy, spójny
  z angielskimi nazwami w kodzie i lepiej wygląda w portfolio.
  Komentarze wyjaśniające `//` (patrz §3) piszemy natomiast **po polsku** —
  to warstwa dydaktyczna „dlaczego". Rozmowa i dokumenty `.md`: polski.

## 3. Komentarze `//` w treści kodu

Komentarz liniowy pisze się tylko wtedy, gdy kod **nie może** powiedzieć tego
sam — wyjaśnia *dlaczego*, nigdy *co*:

```dart
✅ // Serwer liczy limit także dla żądań odrzuconych (SERVER_PROTOCOL §4.2),
   // więc cooldown startuje od wysłania, nie od odpowiedzi.
✅ // Celowo ignorujemy nieznane typy ramek — forward compatibility (§4.9).
❌ // Zwiększamy licznik o 1
❌ // Pętla po użytkownikach
```

- Odwołania do protokołu zapisujemy jak wyżej: `SERVER_PROTOCOL §x.y` —
  czytelnik wie, gdzie szukać źródła prawdy.
- `// TODO(grzegorz): opis + odnośnik do punktu planu/issue` — TODO bez
  właściciela i kontekstu nie przechodzi review.

### Wyjątek dydaktyczny

Kod generowany przez nauczyciela (Claude) na wyraźną prośbę zawiera
**celowo obszerne komentarze po polsku** wyjaśniające decyzje — pełnią rolę
materiału do nauki (patrz `CLAUDE.md`). Kod pisany samodzielnie stosuje
normalne zasady z §3.

## 4. Generowanie i weryfikacja

```bash
dart doc            # generuje HTML do doc/api/ (ignorowane w git)
flutter analyze     # very_good_analysis pilnuje m.in. formatu dartdoc
```

Przegląd kompletności dokumentacji: Faza 11.5 planu nauki.

## 5. Checklist review dokumentacji

1. Czy publiczne API domain/core ma dartdoc z sensownym pierwszym zdaniem?
2. Czy komentarze mówią „dlaczego", a nie „co"?
3. Czy nieoczywiste zachowania protokołu mają odwołanie do `SERVER_PROTOCOL`?
4. Czy nie ma komentarzy-trupów (opisujących kod, którego już nie ma)?
