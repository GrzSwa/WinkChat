# Design system WinkChat

Źródło: projekt „WinkChat Mobile UI Design" (Claude Design). **Ten dokument jest
jedynym źródłem prawdy o tokenach wizualnych.** Wartości stąd trafiają do
`ThemeData` i klas tokenów w `lib/app/theme/` — a nigdy bezpośrednio do widgetów.

## 1. Zasady (nie łamiemy)

1. **Tylko tryb ciemny.** Aplikacja nie ma wariantu jasnego — decyzja
   produktowa. Nie budujemy `ThemeData.light()` „na wszelki wypadek".
2. **Zero magicznych wartości w widgetach.** Żadnego `Color(0xFFCB69F5)`,
   `fontSize: 15` czy `EdgeInsets.all(14)` rozsianego po ekranach. Wszystko
   przez tokeny z `lib/app/theme/`.
3. **Nazwy tokenów opisują rolę, nie wygląd.** `AppColors.textMuted`, nie
   `AppColors.grayPurple` — gdy kolor się zmieni, nazwa dalej będzie prawdziwa.
4. Nowy token = wpis w tym dokumencie w tym samym PR-ze.

## 2. Kolory

### 2.1 Tła i powierzchnie

| Token | Hex | Zastosowanie |
|---|---|---|
| `backgroundDeep` | `#050309` | najgłębsze tło (za modalami, obwódka „ekranu telefonu") |
| `background` | `#0A0710` | główne tło ekranu |
| `surface` | `#0D0A14` | subtelnie wyniesiona powierzchnia |
| `surfaceRaised` | `#17121F` | karty, pola formularza, wiersze listy |
| `surfaceHighest` | `#1F1830` | elementy aktywne / hover / najwyższa warstwa |

### 2.2 Akcent (marka)

| Token | Hex | Zastosowanie |
|---|---|---|
| `primary` | `#CB69F5` | akcent główny: przyciski, aktywne elementy, linki, poświaty |
| `primaryDeep` | `#6C1AE4` | głęboki fiolet: gradienty, tła poświat, radial-gradient tła |
| `primaryHover` | `#DFA6FA` | stan hover/pressed jaśniejszy od `primary` |

Gradient tła ekranu (z projektu):
`radial-gradient(1200px 700px at 20% -5%, rgba(108,26,228,.18), transparent 60%)`
nałożony na `background`.

### 2.3 Tekst

| Token | Hex | Zastosowanie |
|---|---|---|
| `textPrimary` | `#F3EEFA` | tekst główny, nagłówki |
| `textSecondary` | `#B8ADC9` | tekst drugorzędny |
| `textMuted` | `#9A8FB0` | opisy, metadane, podpisy (najczęściej używany szary) |
| `textDisabled` | `#6E6482` | elementy wyłączone, placeholdery |

### 2.4 Kolory semantyczne

| Token | Hex | Zastosowanie |
|---|---|---|
| `success` | `#4ADE80` | potwierdzenia, stan „połączono" |
| `successSoft` | `#A7EBC0` | tekst na tle sukcesu |
| `warning` | `#F5B040` | ostrzeżenia, blokada czasowa, wygasające zaproszenie |
| `warningSoft` | `#F5D89A` | tekst na tle ostrzeżenia |
| `error` | `#FF5050` | błędy, blokada trwała, akcja destrukcyjna |
| `errorSoft` | `#FF7A7A` | tekst na tle błędu |

### 2.5 Obramowania (zawsze półprzezroczyste)

| Token | Wartość | Zastosowanie |
|---|---|---|
| `borderSubtle` | `rgba(255,255,255,0.06)` | delikatne separatory |
| `borderDefault` | `rgba(255,255,255,0.08)` | domyślne obramowanie kart i pól |
| `borderAccent` | `rgba(203,105,245,0.22)` | obramowanie elementu aktywnego |
| `borderAccentStrong` | `rgba(203,105,245,0.35)` | fokus, zaznaczenie |

## 3. Typografia

**Krój: Manrope**, bundlowany lokalnie (`assets/fonts/`) — decyzja świadoma:
działa offline i deterministycznie, bez pobierania w runtime. Wagi: 500, 600,
700, 800.

| Token | Rozmiar / waga | Zastosowanie |
|---|---|---|
| `displayLarge` | 34 / 800 | hero na onboardingu |
| `displayMedium` | 30 / 800 | duże liczby, nagłówki sekcji hero |
| `headlineLarge` | 26 / 700 | nagłówek ekranu |
| `headlineMedium` | 24 / 700 | nagłówek sekcji |
| `titleLarge` | 22 / 700 | tytuły kart |
| `titleMedium` | 20 / 700 | tytuły mniejsze |
| `titleSmall` | 17 / 600 | podtytuły, nazwy użytkowników |
| `bodyLarge` | 16 / 500 | tekst wyróżniony |
| `bodyMedium` | **15 / 500** | **tekst podstawowy — dominujący w projekcie** |
| `bodySmall` | 14 / 500 | tekst pomocniczy |
| `labelLarge` | 13 / 600 | etykiety pól, chipy |
| `labelMedium` | 12 / 600 | metadane, dystans, czas |
| `labelSmall` | 11 / 600 | najdrobniejsze podpisy |

## 4. Odstępy

Skala znormalizowana z wartości użytych w projekcie (dominują 8/10/12/14):

| Token | px |
|---|---|
| `xs` | 4 |
| `sm` | 8 |
| `md` | 12 |
| `base` | 14 |
| `lg` | 18 |
| `xl` | 24 |
| `xxl` | 28 |
| `xxxl` | 44 |
| `huge` | 56 |

## 5. Zaokrąglenia

| Token | px | Zastosowanie |
|---|---|---|
| `radiusXs` | 3 | paski postępu, drobne wskaźniki |
| `radiusSm` | 12 | chipy, małe pola |
| `radiusMd` | 14 | pola formularza |
| `radiusLg` | 16 | karty, wiersze listy |
| `radiusXl` | 20 | duże karty, bottom sheety |
| `radiusXxl` | 24 | modale |
| `radiusPill` | 46 | przyciski (kształt pigułki) |

## 6. Cienie i poświaty

Poświata (glow) w kolorze akcentu to charakterystyczny element tej identyfikacji —
używana przy aktywnych elementach i punktach na radarze.

| Token | Wartość |
|---|---|
| `glowAccent` | `0 0 18px rgba(203,105,245,0.9)` |
| `glowAccentSoft` | `0 0 30px rgba(203,105,245,0.6)` |
| `glowAccentSubtle` | `0 0 12px rgba(203,105,245,0.8)` |
| `shadowDeep` | `0 30px 70px rgba(0,0,0,0.6)` |
| `shadowSheet` | `0 -20px 60px rgba(0,0,0,0.5)` |

## 7. Animacje

| Nazwa | Opis | Gdzie |
|---|---|---|
| `radarSweep` | ciągły obrót 360° | radar na ekranie „W pobliżu" |
| `blipPulse` | pulsowanie punktu (opacity + scale) | użytkownicy na radarze |
| `searchPulse` | rozchodząca się fala (scale 0.3→1.8, zanik) | stan wyszukiwania |
| `ringCountdown` | odliczanie po obwodzie (`stroke-dashoffset`) | TTL zaproszenia |
| `floatDot` | subtelne unoszenie (±4 px) | elementy dekoracyjne |

> **Uwaga do `ringCountdown`:** animacja jest tylko warstwą wizualną. Czas
> odliczania **musi** wynikać z `expires_at` przysłanego przez serwer
> (SERVER_PROTOCOL §4.7), nigdy ze stałej w kodzie — zegar telefonu może
> odbiegać.

## 8. Ekrany w projekcie

| Sekcja | Zawartość | Faza planu |
|---|---|---|
| 01 Wejście i onboarding | hero, formularz profilu (pseudonim, płeć, wiek, promień), CTA | 3.4 / 6.3 |
| 02 W pobliżu (radar) | radar z blipami, stan pusty „Nikogo w zasięgu" | 3.5 / 6.4 |
| 03 Zaproszenia | ring odliczania, stany rozstrzygnięć | 7.1–7.2 |
| 04 Pokój rozmowy | dymki, stany „Łączenie…", „Rozmowa zakończona" | 3.6 / 7.3–7.5 |
| 05 Zgłoszenia i blokady | formularz zgłoszenia, ekran blokady (czasowa/trwała) | 7.5 / 8.3 |
| 06 Style guide | przyciski, pola/chipy, wiersz listy, dymki, ring, banery | 3.3 |

## 9. Mapowanie na Flutter

- Tokeny żyją w `lib/app/theme/` — osobne pliki na kolory, typografię, wymiary.
- `ThemeData` budujemy **raz**, w `lib/app/theme/`, i wstrzykujemy w `MaterialApp`.
- W widgetach sięgamy przez `Theme.of(context)` albo bezpośrednio po klasy
  tokenów — nigdy po surowe wartości.
- Logo dostępne jako SVG (`assets/winkchat-logo.svg` w projekcie designu) —
  wymaga decyzji: `flutter_svg` czy eksport do PNG (ustalimy w 3.3).

## 10. Dostępność

- Kontrast: `textMuted` (`#9A8FB0`) na `background` (`#0A0710`) ma wysoki
  kontrast — OK. Uważać na `textDisabled` (`#6E6482`): używać **wyłącznie**
  do elementów nieaktywnych, nigdy do treści istotnej.
- Minimalny obszar dotykowy: 48×48 dp niezależnie od wizualnego rozmiaru
  elementu (weryfikacja w 11.4).
