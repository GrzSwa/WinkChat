part of 'check_connection_cubit.dart';

sealed class CheckConnectionState extends Equatable {
  final InternetConnectionStatusEnum internetConnectionStatus;
  const CheckConnectionState(this.internetConnectionStatus);

  @override
  List<Object> get props => [internetConnectionStatus];
}

final class CheckConnectionInitial extends CheckConnectionState {
  const CheckConnectionInitial() : super(InternetConnectionStatusEnum.initail);
}

final class CheckConnectionConnected extends CheckConnectionState {
  const CheckConnectionConnected()
      : super(InternetConnectionStatusEnum.connected);
}

final class CheckConnectionDisconnected extends CheckConnectionState {
  const CheckConnectionDisconnected()
      : super(InternetConnectionStatusEnum.disconnected);
}
