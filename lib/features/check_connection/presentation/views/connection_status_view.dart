import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink_chat/config/routes/routes.dart';
import '../../domain/cubit/check_connection_cubit.dart';
import '../widgets/spinner_widget.dart';

class ConnectionStatusView extends StatelessWidget {
  const ConnectionStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool flag = true;
    return BlocConsumer<CheckConnectionCubit, CheckConnectionState>(
      listener: (context, state) {
        if (state is CheckConnectionConnected && flag) {
          Future.delayed(
            const Duration(seconds: 3),
            () => Navigator.pushReplacementNamed(
              context,
              RoutesConfig.introductionScreen,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CheckConnectionInitial ||
            state is CheckConnectionConnected) {
          return const SpinnerWidget();
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
