import 'package:flutter/material.dart';
import 'package:wink_chat/features/introduction_stepper/presentation/widgets/two_images_widget.dart';

class UsernameView extends StatelessWidget {
  const UsernameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xff161616),
        child: const Column(
          children: [
            Expanded(
              flex: 2,
              child: TwoImagesWidget(),
            ),
            Text(
              "Sed delenit minim sadipscing elitr aliquyam ipsum dignissim justo adipiscing sit aliquip amet eirmod sed ipsum. Labore diam sadipscing elit. Sea zzril dolor. Stet vulputate clita ut congue magna eirmod diam esse diam ipsum invidunt duo ipsum dolore rebum. Dolor clita amet rebum dolor.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Expanded(flex: 1, child: TextField())
          ],
        ),
      ),
    );
  }
}
