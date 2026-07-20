import 'package:flutter/material.dart';

/// Punkt wejścia aplikacji — montuje drzewo widgetów WinkChat.
void main() {
  // runApp bierze widget i czyni go korzeniem całego drzewa UI.
  // const, bo WinkChatApp nie zależy od żadnych zmiennych danych —
  // Flutter może taki widget współdzielić/optymalizować (reguła prefer_const).
  runApp(const WinkChatApp());
}

/// Korzeń aplikacji WinkChat.
///
/// Konfiguruje [MaterialApp] (tytuł, nawigacja, motyw). Na tym etapie
/// renderuje jedynie ekran-zaślepkę; właściwe ekrany (onboarding, lista
/// pobliskich, czat) powstaną w kolejnych fazach planu nauki.
class WinkChatApp extends StatelessWidget {
  /// Tworzy korzeń aplikacji.
  const WinkChatApp({super.key});

  // build() opisuje, jak wygląda ten fragment UI. Wywoływany przez Flutter,
  // gdy trzeba narysować/odświeżyć widget. To serce każdego widgetu.
  @override
  Widget build(BuildContext context) {
    // MaterialApp to "rama" aplikacji w stylu Material Design: zapewnia
    // nawigację, motyw, lokalizację itp. W Flutter 3.44 Material 3 jest
    // domyślny, więc nie musimy nic konfigurować, by mieć nowoczesny wygląd.
    return const MaterialApp(
      title: 'WinkChat',
      // Scaffold to podstawowy "szkielet" ekranu (miejsce na app bar, body,
      // przyciski). Na razie samo wyśrodkowane logo tekstowe.
      home: Scaffold(
        body: Center(
          child: Text('WinkChat'),
        ),
      ),
    );
  }
}
