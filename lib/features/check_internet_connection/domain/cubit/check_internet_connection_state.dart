part of 'check_internet_connection_cubit.dart';

sealed class CheckInternetConnectionState extends Equatable {
  final InternetConnectionStatusEnum internetConnectionStatus;
  const CheckInternetConnectionState(this.internetConnectionStatus);

  @override
  List<Object> get props => [internetConnectionStatus];
}

final class CheckInternetConnectionInitial
    extends CheckInternetConnectionState {
  const CheckInternetConnectionInitial()
      : super(InternetConnectionStatusEnum.initail);
}

final class CheckInternetConnectionConnected
    extends CheckInternetConnectionState {
  const CheckInternetConnectionConnected()
      : super(InternetConnectionStatusEnum.connected);
}

final class CheckInternetConnectionDisconnected
    extends CheckInternetConnectionState {
  const CheckInternetConnectionDisconnected()
      : super(InternetConnectionStatusEnum.disconnected);
}
