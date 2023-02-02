import 'package:docare/screens/home_screen.dart';
import 'package:docare/screens/login_screen.dart';
import 'package:docare/screens/onboarding_screens.dart';
import 'package:docare/screens/screens_state_manager.dart';

class AppRouter {
  // A static-dynamic function to get screens based on their id to be shown
  static dynamic getPage() {
    int pageID = ScreenStateManager.getPageID() ?? 0;

    switch (pageID) {
      case 0:
        return const OnboardingScreen();
      case 1:
        return const LoginScreen();
      case 2:
        return const HomeScreen();
    }
  }
}
