import 'package:docare/screens/doctor_screens/appointment_screen.dart';
import 'package:docare/screens/doctor_screens/doctor_profile_screen.dart';
import 'package:docare/screens/user_screens/screen_tobe_shown.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/shared_preferences/shared_pref_barrel.dart';
import 'package:docare/theme/theme_style.dart';
import 'package:docare/components/components_barrel.dart';
import 'package:docare/state_management/providers_barrel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/user_screens/screens_barrel.dart';
import 'state_management/doctor_info_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: primaryGreen, systemNavigationBarColor: primaryGreen),
  );

  await ScreenStateManager.init();
  await Role.init();

  runApp(MyApp());
}

//
// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavBar(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorScreenInfoProvider(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          final provider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            themeMode: provider.themeMode,
            debugShowCheckedModeBanner: false,
            theme: MyTheme.lightTheme,
            darkTheme: MyTheme.darkTheme,
            home: AppRouter.getPage(),
          );
        },
        designSize: const Size(393, 851),
        minTextAdapt: true,
      ),
    );
  }
}

class AllScreens extends StatelessWidget {
  const AllScreens({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex =
        Provider.of<BottomNavBar>(context, listen: true).currentIndex;
    final provider = Provider.of<BottomNavBar>(context, listen: false);

    return Scaffold(
      body: PageView(
        //: currentIndex,
        controller: provider.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: Role.getRole()
            ? const [
                HomeScreen(),
                AppointmentScreen(),
                FavScreen(),
                ProfileScreen(),
              ]
            : const [DoctorAppointmentScreen(), DoctorProfileScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          provider.bottomNavIndex(value);
          provider.animateToPage(provider.pageController);
        },
        currentIndex: currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: primaryGreen,
        unselectedItemColor: midGrey2,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12.sp,
          color: Theme.of(context).colorScheme.onPrimary,
          //fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12.sp,
          color: Theme.of(context).colorScheme.onPrimary,
          //fontWeight: FontWeight.w600,
        ),
        type: BottomNavigationBarType.fixed,
        items: Role.getRole()
            ? [
                navBarItem(
                  label: 'Home',
                  activeIconName: 'home.svg',
                  inActiveIconName: 'home_filled.svg',
                ),
                navBarItem(
                    label: 'Booking',
                    activeIconName: 'calendar.svg',
                    inActiveIconName: 'calendar_filled.svg'),
                navBarItem(
                    label: 'Favourite',
                    activeIconName: 'heart.svg',
                    inActiveIconName: 'heart_filled.svg'),
                navBarItem(
                  label: 'Profile',
                  activeIconName: 'user_outlined.svg',
                  inActiveIconName: 'user_filled.svg',
                ),
              ]
            : [
                navBarItem(
                  label: 'Appointments',
                  activeIconName: 'calendar.svg',
                  inActiveIconName: 'calendar_filled.svg',
                ),
                navBarItem(
                  label: 'Profile',
                  activeIconName: 'user_outlined.svg',
                  inActiveIconName: 'user_filled.svg',
                ),
              ],
      ),
    );
  }

  navBarItem({
    required String label,
    required String activeIconName,
    required String inActiveIconName,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Padding(
        padding: EdgeInsets.all(3.0.w),
        child: SvgPicture.asset(
          getImage(folderName: 'icons', fileName: activeIconName),
          width: 24,
          height: 24,
          color: midGrey2.withAlpha(80),
        ),
      ),
      activeIcon: Padding(
        padding: EdgeInsets.all(3.0.w),
        child: SvgPicture.asset(
          getImage(folderName: 'icons', fileName: inActiveIconName),
          width: 24,
          height: 24,
          color: primaryGreen,
        ),
      ),
    );
  }
}
