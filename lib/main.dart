import 'package:docare/public_packages.dart';
import 'package:docare/theme/theme_style.dart';
import 'package:docare/components/components_barrel.dart';
import 'package:docare/screens/screens_barrel.dart';
import 'package:docare/state_management/providers_barrel.dart';
import 'state_management/bottom_narbar_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Green, systemNavigationBarColor: Green),
  );
  runApp(MyApp());
}
//
class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  bool darkMode = false;

  // getBool() async {
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
      ],
      child: ScreenUtilInit(
        builder: (context, child) {
          final provider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            themeMode: provider.themeMode,
            debugShowCheckedModeBanner: false,
            theme: MyTheme.lightTheme,
            darkTheme: MyTheme.darkTheme,
            home: const OnboardingScreen(),
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
        children: const [
          HomeScreen(),
          AppointmentScreen(),
          FavScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          provider.bottomNavIndex(value);
          provider.animateToPage(provider.pageController);
        },
        currentIndex: currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Green,
        unselectedItemColor: MidGrey2,
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
        items: [
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
          color: MidGrey2.withAlpha(80),
        ),
      ),
      activeIcon: Padding(
        padding: EdgeInsets.all(3.0.w),
        child: SvgPicture.asset(
          getImage(folderName: 'icons', fileName: inActiveIconName),
          width: 24,
          height: 24,
          color: Green,
        ),
      ),
    );
  }
}
