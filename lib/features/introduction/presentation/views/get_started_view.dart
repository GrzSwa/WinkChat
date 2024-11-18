import 'package:flutter/material.dart';
import 'package:wink_chat/features/introduction/presentation/widgets/avatars_grid_list.dart';
import 'package:wink_chat/features/introduction/presentation/widgets/info_box.dart';
import 'package:wink_chat/shared/widgets/buttons/primary_button.dart';

class GetStartedView extends StatelessWidget {
  final VoidCallback? onPressed;

  final List<String> avatars = [
    "assets/images/avatar_1_red.png",
    "assets/images/avatar_2.png",
    "assets/images/avatar_3.png",
    "assets/images/avatar_4_red.png"
  ];

  final String describe =
      "Et erat dolor eos takimata no accumsan facilisis eos elitr amet vel labore nonumy sed zzril dolore. Diam takimata dolore congue at nibh lorem eirmod stet facer dolore ipsum lorem sit. Ut labore ea et justo labore consequat sed duis diam sadipscing diam et.";

  GetStartedView({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: AvatarsGridList(avatars: avatars))),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.center,
                child: InfoBox(
                  header: const Text(
                    "Wprowadzenie",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  describe: describe,
                ),
              )),
          PrimaryButton(onPressed: onPressed, label: "Zaczynajmy!")
        ],
      ),
    );
  }
}
