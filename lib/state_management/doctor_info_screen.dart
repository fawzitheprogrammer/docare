import 'package:docare/public_packages.dart';

class DoctorScreenInfoProvider extends ChangeNotifier {
  // num _activeTimeBox = 0;

  // num get activeTimeBox => _activeTimeBox;

  // void updateActiveTimeBox(number) {
  //   _activeTimeBox = number;
  //   notifyListeners();
  // }

  // int _activeCard = 0;

  // int get activeCard => _activeCard;

  // set setActiveCard(value) {
  //   _activeCard = value;
  //   notifyListeners();
  // }

  final ScrollController _timeCardScrollController = ScrollController();

  ScrollController get timeCardScrollController => _timeCardScrollController;

  goToTimeCard(int index) {
    _timeCardScrollController.animateTo(index * 56,
        curve: Curves.decelerate, duration: const Duration(milliseconds: 500));
    notifyListeners();
  }

  final ScrollController _dateCardscrollController = ScrollController();

  ScrollController get dateCardScrollController => _dateCardscrollController;

  goToDateCard(int index) {
    _dateCardscrollController.animateTo(index * 56,
        curve: Curves.decelerate, duration: const Duration(milliseconds: 500));
    notifyListeners();
  }
}
