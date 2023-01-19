import 'package:country_code_picker/country_code_picker.dart';
import 'package:docare/public_packages.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';
import 'package:docare/components/components_barrel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isActive = false;

  Color gradientTop = Colors.transparent;

  Color gradientBottom = Colors.transparent;

  FocusNode foucsNode = FocusNode();

  String countryCode = '+964';

  String countryImage = 'iraq.svg';

  checkBackgroundColor() {
    if (isActive) {
      gradientTop = GradientTopGreen;
      gradientBottom = Colors.white.withOpacity(0.6);
    } else {
      gradientTop = Colors.transparent;
      gradientBottom = Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundGrey2,
      body: KeyboardVisibility(
        onChanged: (value) {
          if (value) {
          } else {
            isActive = false;
            checkBackgroundColor();
            setState(() {});
          }
        },
        child: SafeArea(
          child: SizedBox(
            // decoration: BoxDecoration(
            //   image: DecorationImage(image: SvgPicture.asset('assetName'))
            // ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    //alignment: Alignment.topCenter,
                    height: 300.h,
                    width: 450.w,
                    child: Image.asset(
                      getImage(
                          folderName: 'vectors', fileName: 'background.svg'),
                      height: 588.38.h,
                      width: 289.55.w,
                    ),
                  ),
                ),
                AnimatedContainer(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gradientTop, gradientBottom],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'DO',
                            style: GoogleFonts.ubuntu(
                                fontSize: 48.sp,
                                color: DarkGrey2,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: 'CARE',
                                style: GoogleFonts.poppins(
                                    fontSize: 48.sp, color: Green),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      Text(
                        'Welcome!',
                        style: GoogleFonts.poppins(
                          fontSize: 30.sp,
                          color: DarkGrey2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        'Type your number to sign-in or \n skip for now!',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: DarkGrey2,
                          //fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 70.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                        child: SizedBox(
                          width: 314.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 60.h,
                                decoration: BoxDecoration(
                                    color: BackgroundGrey1,
                                    borderRadius: BorderRadius.circular(6.r)),
                                child: CountryCodePicker(
                                  initialSelection: 'IQ',
                                  showCountryOnly: false,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  onChanged: (value) {
                                    checkBackgroundColor();
                                  },
                                  barrierColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  searchDecoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.search_rounded),
                                    filled: true,
                                    fillColor: isActive
                                        ? BackgroundGrey2
                                        : BackgroundGrey1,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 0.0, style: BorderStyle.none),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.0,
                                        style: BorderStyle.solid,
                                        color: Green,
                                      ),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    hintText: 'Search here...',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: DarkGrey2,
                                      //fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    //backgroundColor: MidGrey2,
                                    color: DarkGrey2,
                                    //fontWeight: FontWeight.w500,
                                  ),
                                  dialogSize: Size(400.w, 700.h),
                                ),
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Expanded(
                                child: textField(
                                    isActive: isActive,
                                    onSubmitted: (value) {
                                      isActive = false;
                                      checkBackgroundColor();
                                      setState(() {});
                                    },
                                    onTap: () {
                                      isActive = true;
                                      checkBackgroundColor();
                                      setState(() {});
                                    },
                                    hintText: 'Phone number'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 34.h,
                      ),
                      SizedBox(
                        width: 314.w,
                        child: primaryButton(
                          onPressed: () {},
                          label: 'LOGIN',
                          backgroundColor: Green,
                          size: Size(62.48.w, 60.h),
                        ),
                      ),
                      secondaryButton(label: 'Skip for now', onPressed: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
