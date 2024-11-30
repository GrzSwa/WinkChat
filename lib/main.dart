import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wink_chat/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const InitApp());
}
