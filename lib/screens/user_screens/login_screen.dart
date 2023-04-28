import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:docare/main.dart';
import 'package:docare/navigation/navigator.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/screens/user_screens/role_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';
import 'package:docare/components/components_barrel.dart';
import '../../shared_preferences/shared_pref_barrel.dart';
import '../../state_management/providers_barrel.dart';

String? phoneNumberOnBoarding;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Check if textfield is active
  bool isActive = false;

  // Individual gradient color for the shader
  Color gradientTop = Colors.transparent;
  Color gradientBottom = Colors.transparent;

  final RegExp phoneNumberRegex = RegExp(
      r'^\+964(0?751|0?750|0?782|0?783|0?784|0?79[0-9]|0?77[0-9])[0-9]{7}$');

  /// +9647518070601
  // 7510000000
  String countryCode = '+964';

  final TextEditingController phoneNumber = TextEditingController();

  String errorMessage = '';

  bool isLoading = false;

  checkBackgroundColor() {
    if (isActive) {
      gradientTop = gradientTopGreen;
      gradientBottom = Colors.white.withOpacity(0.6);
    } else {
      gradientTop = Colors.transparent;
      gradientBottom = Colors.transparent;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getUser();
  }

  @override
  Widget build(BuildContext context) {
    //final ap = Provider.of<AuthProvider>(context, listen: false);
    //debugPrint(phoneNumber.text);

    //debugPrint(Role.getRole().toString());

    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: KeyboardVisibility(
        onChanged: (value) {
          if (value) {
            // If keyboard is active, do nothing
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
                !isActive
                    ? Padding(
                        padding: EdgeInsets.all(16.0.w),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: primaryButton(
                            onPressed: () =>
                                getPage(context, const RoleScreen()),
                            label: Role.getRole()
                                ? 'I\'m a doctor'
                                : 'I\'m a patient',
                            backgroundColor: primaryGreen,
                            size: Size(60.w, 30.h),
                          ),
                        ),
                      )
                    : Container(),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'DO',
                            style: GoogleFonts.ubuntu(
                                fontSize: 48.sp,
                                color: isActive
                                    ? darkGrey2
                                    : Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: 'CARE',
                                style: GoogleFonts.poppins(
                                    fontSize: 48.sp, color: primaryGreen),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                        Text(
                          'Welcome!',
                          style: GoogleFonts.poppins(
                            fontSize: 30.sp,
                            color: Theme.of(context).colorScheme.onPrimary,
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
                            color: Theme.of(context).colorScheme.onPrimary,
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: CountryCodePicker(
                                    initialSelection: 'IQ',
                                    showCountryOnly: false,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    onChanged: (value) {
                                      checkBackgroundColor();
                                    },
                                    barrierColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    searchDecoration: InputDecoration(
                                      prefixIcon: Icon(Icons.search_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                      filled: true,
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 0.0,
                                            style: BorderStyle.none),
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                          color: primaryGreen,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                      ),
                                      hintText: 'Search here...',
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        //fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      //backgroundColor: MidGrey2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      //fontWeight: FontWeight.w500,
                                    ),
                                    dialogSize: Size(400.w, 700.h),
                                    dialogTextStyle: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      //fontWeight: FontWeight.w500,
                                    ),
                                    dialogBackgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Expanded(
                                  child: textField(
                                    controller: phoneNumber,
                                    context: context,
                                    isActive: isActive,
                                    onSubmitted: (value) {
                                      if (phoneNumberRegex.hasMatch(
                                        countryCode +
                                            phoneNumber.text
                                                .replaceAll(' ', '')
                                                .trim(),
                                      )) {
                                        sendOtpCode();
                                        isActive = false;
                                        checkBackgroundColor();
                                        isLoading = true;
                                        setState(() {});
                                      } else {
                                        errorMessage =
                                            '*Phone number is not in a correct format';
                                      }
                                    },
                                    onTap: () {
                                      isActive = true;
                                      checkBackgroundColor();
                                      setState(() {});
                                    },
                                    hintText: 'Phone number',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        errorMessage.isNotEmpty
                            ? SizedBox(
                                height: 34.h,
                              )
                            : Container(),
                        errorMessage.isEmpty
                            ? Container()
                            : Text(
                                errorMessage,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: Colors.red,
                                  //fontWeight: FontWeight.w500,
                                ),
                              ),
                        SizedBox(
                          height: 34.h,
                        ),
                        SizedBox(
                          width: 314.w,
                          child: primaryButton(
                            onPressed: () async {
                              if (phoneNumberRegex.hasMatch(
                                countryCode +
                                    phoneNumber.text.replaceAll(' ', '').trim(),
                              )) {
                                sendOtpCode();
                                isActive = false;
                                checkBackgroundColor();
                                isLoading = true;
                                setState(() {});
                              } else {
                                errorMessage =
                                    '*Phone number is not in a correct format';
                              }
                            },
                            isLoading: isLoading,
                            label: 'LOGIN',
                            backgroundColor: primaryGreen,
                            size: Size(62.48.w, 60.h),
                          ),
                        ),
                        // secondaryButton(
                        //     label: 'Skip for now',
                        //     onPressed: () {
                        //       getPage(context, const AllScreens());
                        //     }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendOtpCode() {
    print('The Value : ${Role.getRole()}');
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNum = phoneNumber.text.trim();
    //+9647518070601
    phoneNumberOnBoarding = '$countryCode$phoneNum';
    //print(phoneNumberOnBoarding);
    ap.checkExistingPhone(phoneNumberOnBoarding!).then((value) {
      if (value) {
        errorMessage = 'This phone number is already registered.';
        isLoading = false;
        setState(() {});
      } else {
        ap.signInWithPhone(context, "+$countryCode$phoneNum");
      }
    });
  }
}
