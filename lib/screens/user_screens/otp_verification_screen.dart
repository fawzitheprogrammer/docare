import 'dart:async';
import 'package:docare/main.dart';
import 'package:docare/navigation/navigator.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/screens/doctor_screens/doctor_information_screen.dart';
import 'package:docare/screens/user_screens/screens_barrel.dart';
import 'package:docare/screens/user_screens/user_information_screen.dart';
import 'package:docare/shared_preferences/shared_pref_barrel.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../components/components_barrel.dart';
import '../../state_management/providers_barrel.dart';

class OTPVerification extends StatefulWidget {
  final String verificationId;
  const OTPVerification({super.key, required this.verificationId});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  Timer? _timer;

  double _tickerLength = 60;

  bool codeNotRecived = false;

  bool clearText = false;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // as long as _tickerLength is greater than 0
        // _tickerLength will decrease by one repeatedlly
        if (_tickerLength > 0) {
          _tickerLength--;
          // the value of slider that increases on each second
          // decreased of user time
        } else {
          // when [_tickerLength] is equal to 0
          // this code gets executed to
          // cancel the timer not to loop
          // and then display timeout screen
          _timer!.cancel();

          codeNotRecived = true;
        }
      });
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    //Color errorBorder = backgroundGrey1;

    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'We sent you a verification code!!',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'A six digits code was sent to this number',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                phoneNumberOnBoarding!.substring(4).replaceAllMapped(
                    RegExp(r".{4}"), (match) => match.group(0)!),
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  getPage(context, const LoginScreen());
                },
                child: Text(
                  'Wrong number?',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 64.h,
              ),
              OtpTextField(
                onSubmit: (value) {
                  verifyOtp(context, value);
                  if (ap.errorBorder == Colors.redAccent) {
                    //debugPrint(ap.errorBorder.toString());
                    //clearText = true;
                  }
                  setState(() {});
                  clearText = false;
                },
                numberOfFields: 6,
                showFieldAsBox: true,
                borderRadius: BorderRadius.circular(6.r),
                fieldWidth: 54.13.w,
                textStyle: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
                focusedBorderColor: primaryGreen,
                enabledBorderColor: ap.errorBorder,
                cursorColor: primaryGreen,
                // filled: true,
                // fillColor:
                //     ap.codeIncorrect ? Colors.redAccent : Colors.transparent,
                clearText: clearText,
              ),
              SizedBox(
                height: 57.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Code not recived?',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  GestureDetector(
                    onTap: codeNotRecived
                        ? () {
                            ap.signInWithPhone(context, phoneNumberOnBoarding!);
                          }
                        : () {},
                    child: !codeNotRecived
                        ? Text(
                            'Try again in ${!codeNotRecived ? _tickerLength.toStringAsFixed(0) : ''}',
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              color: codeNotRecived
                                  ? primaryGreen
                                  : Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            'Resend code',
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              color: codeNotRecived
                                  ? primaryGreen
                                  : Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db

        ap.checkExistingUser().then(
          (value) async {
            if (Role.getRole() == true) {
              if (value == true) {
                // user exists in our app
                ap.getUserDataFromFirestore().then(
                      (value) => ap.saveUserDataToSP().then(
                            (value) => ap.setSignIn().then((value) {
                              ScreenStateManager.setPageOrderID(3);
                              ap.errorBorder = backgroundGrey1;
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AllScreens(),
                                ),
                                (route) => false,
                              );
                            }),
                          ),
                    );
              } else {
                ScreenStateManager.setPageOrderID(2);
                ap.errorBorder = backgroundGrey1;
                // new user
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserInfromationScreen(),
                  ),
                  (route) => false,
                );
              }
            } else {
              if (value == true) {
                // user exists in our app
                ap.getDoctorDataFromFirestore().then(
                      (value) => ap.saveDoctorDataToSP().then(
                            (value) => ap.setSignIn().then((value) {
                              ScreenStateManager.setPageOrderID(3);
                              ap.errorBorder = backgroundGrey1;
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AllScreens(),
                                ),
                                (route) => false,
                              );
                            }),
                          ),
                    );
              } else {
                ScreenStateManager.setPageOrderID(2);
                ap.errorBorder = backgroundGrey1;
                // new doctor
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DoctorInfromationScreen(),
                  ),
                  (route) => false,
                );
              }
            }
          },
        );
      },
    );
  }
}
