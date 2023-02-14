import 'package:docare/main.dart';
import 'package:docare/screens/user_screens/role_screen.dart';
import 'package:docare/shared_preferences/screens_state_manager.dart';

import 'screens_barrel.dart';

class AppRouter {
  // A static-dynamic function to get screens based on their id to be shown
  static dynamic getPage() {
    int pageID = ScreenStateManager.getPageID();

    switch (pageID) {
      case 0:
        return const OnboardingScreen();
      case 1:
        return const RoleScreen();
      case 2:
        return const LoginScreen();
      case 3:
        return const AllScreens();
    }
  }
}


/*

0 - OnboardingScreen
1 - RoleScreen
2 - LoginScreen
3 - AllScreen

*/