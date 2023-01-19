import 'package:docare/components/components_barrel.dart';
import 'package:flutter/material.dart';

import '../public_packages.dart';

Widget textField({
  Function()? onTap,
  Function(String)? onSubmitted,
  required bool isActive,
  String? hintText,
  required BuildContext context
}) {
  return TextField(
    onTap: onTap,
    onSubmitted: onSubmitted,
    style: GoogleFonts.poppins(
      fontSize: 14.sp,
      color: DarkGrey2,
      //fontWeight: FontWeight.w500,
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: isActive ? BackgroundGrey2 : Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
      border: OutlineInputBorder(
        borderSide: const BorderSide(width: 0.0, style: BorderStyle.none),
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
      hintText: hintText,
      hintStyle: GoogleFonts.poppins(
        fontSize: 14.sp,
        color: DarkGrey2,
        //fontWeight: FontWeight.w500,
      ),
    ),
    keyboardType: TextInputType.number,
  );
}
