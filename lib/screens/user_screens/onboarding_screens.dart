import 'package:docare/components/components_barrel.dart';
import 'package:docare/navigation/navigator.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/screens/user_screens/role_screen.dart';
import 'package:docare/shared_preferences/screens_state_manager.dart';

//import '../components/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Page index
  int selectedIndex = 0;

  // a control that controls page transition
  PageController pageController = PageController();

  //
  List<String> keys = [];
  List<String> values = [];

  @override
  Widget build(BuildContext context) {
    // One method to set [pageOrderId] and open another screen
    appRouting() {
      ScreenStateManager.setPageOrderID(1);
      getPage(context, const RoleScreen());
    }

    onboardingInfo.forEach(((key, value) {
      keys.add(key);
      values.add(value);
    }));

    final pageID = ScreenStateManager.getPageID();
    print(pageID);

    return Scaffold(
      backgroundColor: primaryGreen,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 450.75.h,
              //width: 350.75.w,
              child: PageView.builder(
                itemCount: vectorsPath.length,
                controller: pageController,
                onPageChanged: (value) {
                  selectedIndex = value;
                  //debugPrint(selectedIndex.toString());
                  setState(() {});
                },
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => buildOnScreenTextAndImage(
                  vectorsPath[index],
                  keys[index],
                  values[index],
                ),
              ),
            ),
            SizedBox(
              height: 90.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: CircleAvatar(
                    // if(index==selectdIndex){RETURN }ELSE{}
                    backgroundColor: index == selectedIndex
                        ? Colors.white
                        : primaryGreen40Percent,
                    radius: 5.r,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 98.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(
                          Size(154.98.w, 55.h),
                        ),
                      ),
                      onPressed: () {
                        appRouting();
                      },
                      child: Text(
                        'Skip',
                        style: GoogleFonts.poppins(
                            fontSize: 15.sp, color: Colors.white),
                      ),
                    ),
                  ),
                  primaryButton(
                    onPressed: () {
                      if (selectedIndex < vectorsPath.length - 1) {
                        selectedIndex++;
                        pageController.animateToPage(selectedIndex,
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeInOut);
                      } else {
                        appRouting();
                      }
                      setState(() {});
                    },
                    label: 'NEXT',
                    backgroundColor: primaryGreen70Percent,
                    size: Size(154.98.w, 55.h),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildOnScreenTextAndImage(
    String vectorPath,
    String header,
    String body,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          vectorPath,
          width: 350.75.w,
          height: 299.49.h,
        ),
        Text(
          header,
          style: GoogleFonts.poppins(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
          body,
          style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
