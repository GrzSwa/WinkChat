import 'package:flutter/material.dart';
import 'package:winkchat/app/theme/app_theme.dart';
import 'package:winkchat/app/theme/app_typography.dart';

/// Application entry point — loads the WinkChat widget tree.
void main() {
  runApp(const WinkChatApp());
}

/// The root of the WinkChat app.
///
/// Configures [MaterialApp] (title, navigation, theme). At this stage,
/// it renders only a placeholder screen; the actual screens (onboarding, list
/// of nearby users, chat) will be created in subsequent phases of the
/// learning plan.
class WinkChatApp extends StatelessWidget {
  /// Creates the application root.
  const WinkChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WinkChat',
      theme: AppTheme.dark,
      home: const Scaffold(
        body: Center(
          child: Text('WinkChat', style: AppTypography.displayLarge),
        ),
      ),
    );
  }
}
