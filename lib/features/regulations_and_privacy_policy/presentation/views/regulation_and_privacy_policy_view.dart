import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink_chat/features/regulations_and_privacy_policy/data/provider/regulations_and_privacy_policy_provider.dart';
import 'package:wink_chat/features/regulations_and_privacy_policy/data/repository/regulations_and_privacy_policy_repository.dart';
import 'package:wink_chat/features/regulations_and_privacy_policy/domain/cubit/regulations_and_privacy_policy_cubit.dart';
import 'package:wink_chat/shared/widgets/buttons/primary_button.dart';
import 'package:wink_chat/shared/widgets/buttons/secondary_button.dart';

class RegulationAndPrivacyPolicyView extends StatelessWidget {
  final Map<String, VoidCallback>? actions;

  const RegulationAndPrivacyPolicyView({Key? key, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: Column(
        children: [
          const Text(
            "Regulamin i polityka prywatności",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: BlocProvider(
              create: (context) => RegulationsAndPrivacyPolicyCubit(
                RegulationsAndPrivacyPolicyRepository(
                    RegulationsAndPrivacyPolicyProvider()),
              )..getParagraphs(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: BlocBuilder<RegulationsAndPrivacyPolicyCubit,
                      RegulationsAndPrivacyPolicyState>(
                    builder: (context, state) {
                      if (state is RegulationsAndPrivacyPolicyLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is RegulationsAndPrivacyPolicyError) {
                        return const Text("Wystąpił błąd");
                      } else if (state is RegulationsAndPrivacyPolicyLoaded) {
                        return ListView.builder(
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                state.data[index].title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.redAccent),
                              ),
                              subtitle: Text(state.data[index].describe),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("Brak danych"),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              PrimaryButton(onPressed: actions?["accept"], label: "Akceptuje"),
              const SizedBox(height: 10),
              SecondaryButton(onPressed: actions?["decline"], label: "Anuluj"),
            ],
          )
        ],
      ),
    );
  }
}
