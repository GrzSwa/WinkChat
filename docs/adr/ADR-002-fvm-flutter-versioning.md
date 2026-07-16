# ADR-002: FVM do zarządzania wersją Fluttera

- **Status:** zaakceptowany
- **Data:** 2026-07-16

## Kontekst

Flutter na maszynie deweloperskiej jest domyślnie instalowany **globalnie** —
jeden klon SDK w jednej wersji obsługuje wszystkie projekty na komputerze
(u nas: `/Users/grzegorz/Develop/flutter`, wersja 3.38.6). Rodzi to dwa
problemy, które ujawniają się z czasem:

1. **Brak izolacji między projektami.** Aktualizacja SDK dla jednego projektu
   (`flutter upgrade`) zmienia wersję dla *wszystkich* projektów naraz.
   Ponieważ wydania Fluttera bywają zmianami łamiącymi (deprecjacje API,
   zmiany w toolchainie natywnym), podbicie wersji pod nowy projekt potrafi
   „popsuć" starszy, którego akurat nie dotykamy.
2. **Brak powtarzalności środowiska.** Wersja Fluttera to niejawna zależność
   projektu, która nigdzie w repozytorium nie jest zapisana. Inny deweloper,
   nowa maszyna albo pipeline CI mogą użyć innej wersji SDK niż autor kodu —
   klasyczne „u mnie działa". To szczególnie boli przy CI (Faza 10), gdzie
   build musi być deterministyczny.

Projekt jest długoterminowy i docelowo zyska CI, więc powtarzalność wersji
SDK jest realną wartością, a nie teoretyczną.

## Decyzja

Używamy **FVM (Flutter Version Management)** do instalowania i przypinania
wersji Fluttera **per projekt**. Wybrana wersja stable jest zapisana w repo
(`.fvmrc`), a wszystkie polecenia SDK wołamy przez FVM (`fvm flutter ...`,
`fvm dart ...`). Global SDK pozostaje tylko jako zależność samego FVM
(bootstrap), nie jako narzędzie używane bezpośrednio w projekcie.

## Rozważane alternatywy

- **Globalny SDK (stan obecny)** — najprostszy, zero dodatkowych warstw
  i prefiksów. Odrzucony, bo nie daje izolacji między projektami ani
  powtarzalności w CI; wersja SDK pozostaje niezapisana w repozytorium.
- **FVM** *(wybrane)* — przypina wersję do projektu, zapisuje ją w repo,
  pozwala trzymać wiele wersji obok siebie. Koszt: prefiks `fvm` przed
  poleceniami i drobna konfiguracja edytora (wskazanie ścieżki do SDK
  zarządzanego przez FVM). Model znany z innych ekosystemów (nvm dla Node,
  pyenv/rbenv), więc uczy przenośnego nawyku.
- **asdf / mise (uniwersalne menedżery wersji z pluginem Flutter)** —
  jedno narzędzie do wielu języków. Odrzucone na tym etapie: dodatkowa
  ogólna warstwa i mniej materiałów specyficznych dla Fluttera niż przy FVM,
  które jest w tym ekosystemie de facto standardem. Do rozważenia, gdyby
  projekt urósł o inne środowiska językowe (wtedy → nowy ADR).

## Konsekwencje

- ✅ Wersja Fluttera staje się **jawną, wersjonowaną zależnością** projektu
  (`.fvmrc` w repo) — koniec rozjazdu wersji między maszynami i CI.
- ✅ Izolacja: aktualizacja Fluttera w tym projekcie nie dotyka innych
  projektów na komputerze.
- ✅ Fundament pod deterministyczne CI (Faza 10 użyje tej samej wersji, którą
  zapisze `.fvmrc`).
- ➖ Każde polecenie SDK wymaga prefiksu `fvm` (`fvm flutter run` zamiast
  `flutter run`) — nawyk do wyrobienia; łagodzimy aliasem w edytorze.
- ➖ Konieczna jednorazowa konfiguracja edytora (VS Code / Android Studio),
  by wskazywał na SDK w `.fvm/`, a nie na globalny — inaczej podpowiedzi
  i analiza używałyby złej wersji.
- ➖ Dodatkowa zależność narzędziowa (sam FVM), którą trzeba zainstalować
  i utrzymać.
