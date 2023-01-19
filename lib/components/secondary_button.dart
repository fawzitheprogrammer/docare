import 'package:docare/components/components_barrel.dart';
import 'package:docare/public_packages.dart';

Widget secondaryButton({
  required String label,
  Function()? onPressed
}) {
  return TextButton(
    onPressed:onPressed,
    child: Text(
       label,
      style: GoogleFonts.poppins(
        fontSize: 14.sp,
        color: MidGrey2,
        //fontWeight: FontWeight.w500,
      ),
    ),
  );
}
