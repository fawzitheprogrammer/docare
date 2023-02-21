// ignore: unnecessary_import
import 'package:docare/components/text.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/screens/user_screens/role_screen.dart';
import 'package:docare/screens/user_screens/screens_barrel.dart';
import 'package:docare/shared_preferences/shared_pref_barrel.dart';
import 'package:docare/state_management/appointment_provider.dart';
import '../../components/components_barrel.dart';
import '../../state_management/providers_barrel.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final bottomNavProvider = Provider.of<BottomNavBar>(context, listen: false);

    AppointmentProvider.getToken();
    print(AppointmentProvider.deviceToken);

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(12.0.w),
            child: FutureBuilder(
              future: Role.getRole()
                  ? ap.getUserDataFromFirestore()
                  : ap.getDoctorDataFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: primaryGreen,
                  ));
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 68.r,
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        backgroundImage: NetworkImage(Role.getRole()
                            ? ap.userModel.profilePic
                            : ap.doctorModel.profilePic),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      textLabel(
                        text: Role.getRole()
                            ? ap.userModel.name
                            : ap.doctorModel.name,
                        fontSize: 28.sp,
                        color: primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 6.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textLabel(
                            text: Role.getRole()
                                ? ap.userModel.phoneNumber
                                : ap.doctorModel.phoneNumber,
                            fontSize: 18.sp,
                            color: Theme.of(context).colorScheme.onPrimary,
                            //fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          // GestureDetector(
                          //   child: SvgPicture.asset(
                          //     getImage(
                          //       folderName: 'icons',
                          //       fileName: 'edit.svg',
                          //     ),
                          //     color: Green,
                          //     width: 18.w,
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      ProfileCard(
                        value: themeProvider.isDarkMode,
                        onChanged: ((value) {
                          final providerTheme = Provider.of<ThemeProvider>(
                              context,
                              listen: false);
                          providerTheme.toggleTheme(value);
                        }),
                        provider: themeProvider,
                        label: 'Dark Mode',
                        icon: 'moon.svg',
                        hasSwitch: true,
                      ),
                      ProfileCard(
                        provider: themeProvider,
                        label: 'Notification',
                        icon: 'bell.svg',
                        hasSwitch: true,
                      ),
                      //
                      GestureDetector(
                        onTap: () {
                          ap.userSignOut().then((value) {
                            bottomNavProvider.bottomNavIndex(0);
                            ScreenStateManager.setPageOrderID(1);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RoleScreen(),
                              ),
                              (route) => false,
                            );
                          });
                        },
                        child: ProfileCard(
                          provider: themeProvider,
                          label: 'Sign out',
                          icon: 'sign-out-alt.svg',
                          hasSwitch: false,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    this.value,
    this.onChanged,
    required this.provider,
    required this.label,
    required this.icon,
    this.hasSwitch,
  }) : super(key: key);

  final ThemeProvider provider;
  final String label;
  final String icon;
  final bool? hasSwitch;
  final Function(bool)? onChanged;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 12.0.w,
        vertical: 8.h,
      ),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      height: 80.h,
      width: 353.w,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24.0.w,
          ),
          SvgPicture.asset(
            getImage(
              folderName: 'icons',
              fileName: icon,
            ),
            color: primaryGreen,
          ),
          SizedBox(
            width: 8.0.w,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    //[, Theme.of(context).colorScheme.primaryContainer],
                    color: Theme.of(context).colorScheme.onPrimary,
                    //fontWeight: FontWeight.w600
                    //fontWeight: FontWeight.w500,
                  ),
                ),
                // Text(
                //   'Cardiologist',
                //   style: GoogleFonts.poppins(
                //     fontSize: 14.sp,
                //     color: DarkGrey2,
                //     //fontWeight: FontWeight.w500,
                //   ),
                // ),
              ],
            ),
          ),
          const Spacer(),
          hasSwitch ?? false
              ? Switch.adaptive(
                  value: value ?? false,
                  onChanged: onChanged,
                  thumbColor: MaterialStatePropertyAll(primaryGreen),
                  inactiveThumbColor: midGrey2,
                  inactiveTrackColor: Colors.black12,
                  splashRadius: 20.r,
                )
              : Container()
        ],
      ),
    );
  }
}
