import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:docare/public_packages.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkConnection();
    // TODO: implement initState
    super.initState();
  }

  checkConnection() async {
    if (await ConnectivityWrapper.instance.isConnected) {
      debugPrint('connected');
    } else {
      debugPrint('No network');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 180.h,
              width: 180.w,
              child: const RiveAnimation.asset('assets/rive/logo_docare.riv'),
            ),
          ],
        ),
      ),
    );
  }
}
