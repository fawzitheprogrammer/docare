import 'package:docare/no_network.dart';
import 'package:docare/push_notification/push_notidication.dart';
import 'package:docare/screens/doctor_screens/appointment_screen.dart';
import 'package:docare/screens/doctor_screens/doctor_profile_screen.dart';
import 'package:docare/screens/user_screens/screen_tobe_shown.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/screens/user_screens/user_information_screen.dart';
import 'package:docare/shared_preferences/shared_pref_barrel.dart';
import 'package:docare/state_management/appointment_provider.dart';
import 'package:docare/state_management/network.dart';
import 'package:docare/theme/theme_style.dart';
import 'package:docare/components/components_barrel.dart';
import 'package:docare/state_management/providers_barrel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rive/rive.dart';
import 'screens/user_screens/screens_barrel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: primaryGreen, systemNavigationBarColor: primaryGreen),
  );

  await ScreenStateManager.init();
  await Role.init();
  requestPermission();
  loadFCM();
  listenFCM();

  runApp(MyApp());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //bool isConnected = true;

  List<Widget> noNet = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    Future.delayed(const Duration(seconds: 5))
        .then((value) => checkConnection().then((value) {
              print(value);
              if (value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppRouter.getPage(),
                  ),
                );
              } else {
                Future.delayed(const Duration(seconds: 5));
                noNet = [
                  SvgPicture.asset(
                    getImage(
                      folderName: 'icons',
                      fileName: 'wifi.svg',
                    ),
                    width: 82.w,
                    color: primaryGreen,
                  ),
                  textLabel(
                    text: 'No internet connection',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20.sp,
                  ),
                  textLabel(
                    text: 'Try these steps to get back online',
                    fontSize: 18.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const InstructionBullet(
                        content: 'Check your modem and router',
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      const InstructionBullet(
                        content: 'Check you mobile data',
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      const InstructionBullet(content: 'Connect to WIFI'),

                      //Spacer(),
                      SizedBox(height: 38.h),
                      primaryButton(
                        onPressed: () {
                          load();
                        },
                        label: 'Reload',
                        backgroundColor: primaryGreen,
                        size: Size(120.w, 50.h),
                      )
                    ],
                  )
                ];
                setState(() {});
              }
            }));
  }

  Future<bool> checkConnection() async {
    bool isConnected = true;

    //
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      isConnected = true;
      //print(isConnected);
      //notifyListeners();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isConnected = true;
      //print(isConnected);
      //notifyListeners();
    } else {
      isConnected = false;
      //print(isConnected);
      //notifyListeners();
    }

    return isConnected;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RefreshIndicator(
          onRefresh: checkConnection,
          color: primaryGreen,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: noNet.isEmpty
                ? [
                    const Spacer(),
                    SizedBox(
                      height: 180.h,
                      width: 180.w,
                      child: const RiveAnimation.asset(
                          'assets/rive/logo_docare.riv'),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 44.h),
                      child: SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: CircularProgressIndicator(
                          color: primaryGreen,
                        ),
                      ),
                    ),
                    // : Container()
                  ]
                : noNet,
          ),
        ),
      ),
    );
  }
}

class InstructionBullet extends StatelessWidget {
  const InstructionBullet({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Spacer(),
        SizedBox(
          width: 60.w,
        ),
        CircleAvatar(
          backgroundColor: primaryGreen,
          radius: 10.r,
          child: SvgPicture.asset(
            getImage(
              folderName: 'icons',
              fileName: 'check.svg',
            ),
            width: 10.w,
            color: backgroundGrey1,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        textLabel(
          text: content,
          fontSize: 16.sp,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        const Spacer(),
      ],
    );
  }
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
        ChangeNotifierProvider(
          create: (context) => AppointmentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Network(),
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
    final netwotk = Provider.of<Network>(context, listen: false);

    netwotk.checkConnection();
    //print(netwotk.isConnected);

    return netwotk.isConnected
        ? Scaffold(
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
                  :  const [DoctorAppointmentScreen(), DoctorProfileScreen()],
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
          )
        : const NoNetwork();
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
