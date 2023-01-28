import '../public_packages.dart';
import 'components_barrel.dart';

Widget textLabel({
  required String text,
  double? fontSize, // Null
  Color? color,
  FontWeight? fontWeight,
  double? letterSpacing,
}) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: fontSize ?? 14.sp,
      color: color ?? Green,
      fontWeight: fontWeight ?? FontWeight.w500,
      letterSpacing: letterSpacing ?? 0,
    ),
    overflow: TextOverflow.ellipsis,
  );
}
