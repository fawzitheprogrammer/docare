// import 'package:docare/components/components_barrel.dart';
// import 'package:docare/public_packages.dart';

// class OnBoardingStateController extends ChangeNotifier {
  
//   static int selectedIndex = 0;

//   static PageController controller = PageController();

//   // static Color? pageIndicatorColor;

//   void onPageChanged(int index) {
//     selectedIndex = index;
//     notifyListeners();
//   }

//   animateToPage() {
//     if (selectedIndex < vectorsPath.length - 1) {
//       selectedIndex++;
//       controller.animateToPage(selectedIndex,
//           duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
//       notifyListeners();
//     }
//   }

//   Color changeIndicatorColor(int index) {
//     Color pageIndicatorColor =
//         index == selectedIndex ? Colors.white : Green40Percent;
//     notifyListeners();
//     return pageIndicatorColor;
//   }
// }
