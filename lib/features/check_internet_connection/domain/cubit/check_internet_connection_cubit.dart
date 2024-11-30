import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:wink_chat/shared/enums/enums.dart';

part 'check_internet_connection_state.dart';

class CheckInternetConnectionCubit extends Cubit<CheckInternetConnectionState> {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>>
      _connectivityStreamSubscription;

  CheckInternetConnectionCubit(this._connectivity)
      : super(const CheckInternetConnectionInitial()) {
    _monitorInternetConnection();
  }

  void _monitorInternetConnection() {
    _connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult[0] == ConnectivityResult.wifi ||
          connectivityResult[0] == ConnectivityResult.mobile) {
        emit(const CheckInternetConnectionConnected());
      } else {
        emit(const CheckInternetConnectionDisconnected());
      }
    });
  }

  @override
  Future<void> close() {
    _connectivityStreamSubscription.cancel();
    return super.close();
  }
}
