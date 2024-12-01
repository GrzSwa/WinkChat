import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../domain/cubit/rapp_cubit.dart';

class RegulationsAndPrivacyPolicyView extends StatelessWidget {
  const RegulationsAndPrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueAccent,
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<RAPPCubit, RAPPState>(
              builder: (context, state) {
                if (state is RAPPLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RAPPLoaded) {
                  return Html(data: state.body.htmlBody);
                } else {
                  return const Center(child: Text("Brak danych"));
                }
              },
            ),
          ),
        ));
  }
}
