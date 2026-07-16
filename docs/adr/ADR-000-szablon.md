# ADR-000: Szablon i zasady prowadzenia ADR

- **Status:** zaakceptowany
- **Data:** 2026-07-16

## Czym jest ADR

Architecture Decision Record dokumentuje **jedną istotną decyzję** — wraz
z kontekstem i odrzuconymi alternatywami — w momencie jej podejmowania.
Za pół roku nikt nie pamięta „dlaczego bloc, a nie Riverpod"; ADR pamięta.

## Kiedy piszemy ADR

- wybór technologii/pakietu o szerokim wpływie (state management, DI, router),
- decyzja strukturalna (podział na warstwy, strategia błędów),
- świadome odstępstwo od przyjętych zasad,
- rezygnacja z czegoś „standardowego" (np. brak CD).

Nie piszemy ADR dla decyzji trywialnych lub łatwo odwracalnych.

## Zasady

1. Numeracja kolejna (`ADR-001`, `ADR-002`…), plik:
   `ADR-XXX-krotki-opis.md`.
2. ADR jest **niemutowalny po akceptacji** — zmiana decyzji = nowy ADR,
   a stary dostaje status „zastąpiony przez ADR-YYY".
3. Statusy: `proponowany` → `zaakceptowany` | `odrzucony` | `zastąpiony
   przez ADR-YYY`.
4. Krótko — 1 strona; liczy się kontekst i konsekwencje, nie elaborat.

## Szablon (kopiuj poniższe)

```markdown
# ADR-XXX: Tytuł decyzji

- **Status:** proponowany | zaakceptowany | zastąpiony przez ADR-YYY
- **Data:** RRRR-MM-DD

## Kontekst
Jaki problem rozwiązujemy? Jakie siły/ograniczenia działają?

## Decyzja
Co postanowiliśmy — jednym/dwoma zdaniami, w trybie oznajmującym.

## Rozważane alternatywy
- **Opcja A** — dlaczego nie.
- **Opcja B** — dlaczego nie.

## Konsekwencje
Pozytywne, negatywne i neutralne skutki. Na co się godzimy?
```
