import 'package:flutter/material.dart';
import 'package:wink_chat/screen/introduction_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter Demo', home: IntroductionScreen());
  }
}
