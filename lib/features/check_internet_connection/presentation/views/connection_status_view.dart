import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink_chat/config/routes/routes_config.dart';
import 'package:wink_chat/features/check_internet_connection/presentation/widgets/widgets.dart';
import 'package:wink_chat/shared/widgets/widgets.dart';

import '../../domain/cubit/check_internet_connection_cubit.dart';

class ConnectionStatusView extends StatelessWidget {
  const ConnectionStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInternetConnectionCubit,
        CheckInternetConnectionState>(
      builder: (context, state) {
        if (state is CheckInternetConnectionInitial) {
          return const SpinnerWidget();
        } else if (state is CheckInternetConnectionConnected) {
          return SecondaryButtonWidget(
            text: "Rozpocznij",
            onPressed: () => Navigator.pushReplacementNamed(
              context,
              RoutesConfig.introductionScreen,
            ),
          );
        } else if (state is CheckInternetConnectionDisconnected) {
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
