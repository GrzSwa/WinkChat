import 'package:flutter/material.dart';
import 'package:wink_chat/screens/screens.dart';

class RoutesConfig {
  static const String splashScreen = '/splash_screen';
  static const String introductionScreen = '/introduction_screen';
  static const String regulationsAndPrivacyPolicyScreen =
      '/regulations_and_privacy_policy_screen';
  static const String searchCallerScreen = '/search_caller_screen';
  static const String chatScreen = '/chat_screen';
  static const String settingsScreen = '/settings_screen';

  static const String initialRoute = splashScreen;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case introductionScreen:
        return MaterialPageRoute(builder: (_) => const IntroductionScreen());
      case searchCallerScreen:
        return MaterialPageRoute(builder: (_) => const SearchCallerScreen());
      case chatScreen:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SearchCallerScreen());
    }
  }
}
