import 'package:docare/components/text.dart';
import 'package:docare/public_packages.dart';
import '../components/components_barrel.dart';
import '../state_management/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(12.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 68.r,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: textLabel(
                    text: 'FG',
                    fontSize: 28.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                textLabel(
                  text: 'Fawzi Gharib',
                  fontSize: 28.sp,
                  color: Green,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 6.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textLabel(
                      text: '07518070601',
                      fontSize: 18.sp,
                      color: Theme.of(context).colorScheme.onPrimary,
                      //fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    GestureDetector(
                      child: SvgPicture.asset(
                        getImage(
                          folderName: 'icons',
                          fileName: 'edit.svg',
                        ),
                        color: Green,
                        width: 18.w,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 14.h,
                ),
                ProfileCard(
                  value: provider.isDarkMode,
                  onChanged: ((value) {
                    final providerTheme =
                        Provider.of<ThemeProvider>(context, listen: false);
                    providerTheme.toggleTheme(value);
                  }),
                  provider: provider,
                  label: 'Dark Mode',
                  icon: 'moon.svg',
                  hasSwitch: true,
                ),
                ProfileCard(
                  provider: provider,
                  label: 'Notification',
                  icon: 'bell.svg',
                  hasSwitch: true,
                ),
                //
                ProfileCard(
                  provider: provider,
                  label: 'Sign out',
                  icon: 'sign-out-alt.svg',
                  hasSwitch: false,
                ),
              ],
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
            color: Green,
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
          Spacer(),
          hasSwitch ?? false
              ? Switch.adaptive(
                  value: value ?? false,
                  onChanged: onChanged,
                  thumbColor: MaterialStatePropertyAll(Green),
                  inactiveThumbColor: MidGrey2,
                  inactiveTrackColor: Colors.black12,
                  splashRadius: 20.r,
                )
              : Container()
        ],
      ),
    );
  }
}
