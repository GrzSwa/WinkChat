import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wink_chat/features/check_connection/check_connection.dart';
import 'package:wink_chat/shared/widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return BlocProvider<CheckConnectionCubit>(
      create: (context) => CheckConnectionCubit(Connectivity()),
      child: Scaffold(
        body: Container(
            width: _width,
            height: _height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xff793e41), Color(0xffde676c), Color(0xffff7676)],
              stops: [0, 0.6, 1],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            )),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: _width * 0.35,
                        child:
                            const AppLogoWidget(fullLogo: false, isDark: true),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConnectionStatusView(),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
