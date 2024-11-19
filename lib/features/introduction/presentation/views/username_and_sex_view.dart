import 'package:flutter/material.dart';
import 'package:wink_chat/features/introduction/presentation/widgets/info_box.dart';
import 'package:wink_chat/features/introduction/presentation/widgets/info_box_header.dart';
import 'package:wink_chat/shared/widgets/buttons/primary_button.dart';
import 'package:wink_chat/shared/widgets/buttons/secondary_button.dart';

class UsernameAndSexView extends StatelessWidget {
  final Map<String, VoidCallback>? actions;
  final String describe =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla mattis, odio ut molestie laoreet, orci lorem bibendum quam, ut facilisis leo lectus eu purus. Nulla placerat mi dignissim nisi porttitor,";
  const UsernameAndSexView({Key? key, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Column(children: [
            InfoBox(
                header: const InfoBoxHeader(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                  label: "Ustaw swoją nazwę",
                ),
                describe: describe),
            const SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                labelText: 'Twoja nazwa',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 30.0,
                ),
              ),
            ),
          ])),
          Column(
            children: [
              PrimaryButton(onPressed: actions?["accept"], label: "Zatwierdź"),
              const SizedBox(height: 10),
              SecondaryButton(onPressed: actions?["decline"], label: "Anuluj"),
            ],
          )
        ],
      ),
    );
  }
}
