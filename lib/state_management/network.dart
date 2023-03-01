import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:docare/public_packages.dart';

bool im = true;

class Network extends ChangeNotifier {
  bool isConnected = true;

  Future<void> checkConnection() async {
    if (await ConnectivityWrapper.instance.isConnected) {
      isConnected = true;
      notifyListeners();
    } else {
      isConnected = false;
      notifyListeners();
    }
  }
}





void me() {

  bool sleepy = true;

  //if (im == sleepy) sleep(); 

  if (im != sleepy) code();

}

























code() {}
