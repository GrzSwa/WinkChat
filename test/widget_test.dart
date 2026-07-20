import 'package:flutter_test/flutter_test.dart';
import 'package:winkchat/main.dart';

void main() {
  testWidgets('renderuje ekran-zaślepkę WinkChat', (tester) async {
    // Budujemy aplikację w środowisku testowym...
    await tester.pumpWidget(const WinkChatApp());

    // ...i sprawdzamy, że napis "WinkChat" jest na ekranie dokładnie raz.
    expect(find.text('WinkChat'), findsOneWidget);
  });
}
