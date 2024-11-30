import 'package:flutter/material.dart';
import 'package:wink_chat/config/routes/routes.dart';

class InitApp extends StatelessWidget {
  const InitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wink Chat',
      initialRoute: RoutesConfig.initialRoute,
      onGenerateRoute: RoutesConfig.generateRoute,
    );
  }
}
