import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final Connectivity _connectivity = Connectivity();

  ConnectivityCubit() : super(ConnectivityStatus.connected) {
    _monitorNetworkStatus();
  }

  void _monitorNetworkStatus() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    _updateStatus(connectivityResult as ConnectivityResult);

    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _updateStatus(result);
    } as void Function(List<ConnectivityResult> event)?);
  }

  void _updateStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      emit(ConnectivityStatus.connected);
    } else {
      emit(ConnectivityStatus.disconnected);
    }
  }
}
