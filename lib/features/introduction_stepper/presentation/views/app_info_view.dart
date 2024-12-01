import 'package:flutter/material.dart';
import 'package:wink_chat/shared/widgets/widgets.dart';

class AppInfoView extends StatelessWidget {
  const AppInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff161616),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: AppLogoWidget(isDark: true)),
          Text(
            "Sed delenit minim sadipscing elitr aliquyam ipsum dignissim justo adipiscing sit aliquip amet eirmod sed ipsum. Labore diam sadipscing elit. Sea zzril dolor. Stet vulputate clita ut congue magna eirmod diam esse diam ipsum invidunt duo ipsum dolore rebum. Dolor clita amet rebum dolor.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }
}
