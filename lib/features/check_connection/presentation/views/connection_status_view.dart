import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink_chat/config/routes/routes.dart';
import 'package:wink_chat/features/check_connection/presentation/widgets/widgets.dart';
import 'package:wink_chat/shared/widgets/widgets.dart';

import '../../domain/cubit/cubit.dart';

class ConnectionStatusView extends StatelessWidget {
  const ConnectionStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckConnectionCubit, CheckConnectionState>(
      builder: (context, state) {
        if (state is CheckConnectionInitial) {
          return const SpinnerWidget();
        } else if (state is CheckConnectionConnected) {
          return SecondaryButtonWidget(
            text: "Rozpocznij",
            onPressed: () => Navigator.pushReplacementNamed(
              context,
              RoutesConfig.introductionScreen,
            ),
          );
        } else if (state is CheckConnectionDisconnected) {
          return const Text(
            "Brak połączenia",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              letterSpacing: 4,
              fontSize: 16,
            ),
          );
        } else {
          return const Text(
            "Problem z siecią",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              letterSpacing: 4,
              fontSize: 16,
            ),
          );
        }
      },
    );
  }
}
