import 'package:docare/main.dart';
import 'package:docare/public_packages.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../components/components_barrel.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  @override
  Widget build(BuildContext context) {
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
                  color: Green,
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
                '0751 807 0601',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 64.h,
              ),
              OtpTextField(
                onSubmit: (value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllScreens()));
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
                focusedBorderColor: Green,
                //borderColor: Theme.of(context).colorScheme.onPrimary,
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
                  Text(
                    'Try again in 59s',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
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
}
