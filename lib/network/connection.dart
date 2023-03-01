import 'package:connectivity_wrapper/connectivity_wrapper.dart';

Future<bool> checkConnection() async {
  if (await ConnectivityWrapper.instance.isConnected) {
    return true;
  } else {
    return false;
  }
}
