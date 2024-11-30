import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  final bool? isDark;
  final bool? fullLogo;
  const AppLogoWidget({Key? key, this.isDark = false, this.fullLogo = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String assetPath = fullLogo!
        ? (isDark! ? "assets/logo/logo_dark.png" : "assets/logo/logo_light.png")
        : (isDark!
            ? "assets/logo/msg_bubble_dark.png"
            : "assets/logo/msg_bubble_light.png");

    return Image.asset(assetPath);
  }
}
