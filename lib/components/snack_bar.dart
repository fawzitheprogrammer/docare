import 'package:docare/components/components_barrel.dart';
import 'package:docare/public_packages.dart';
import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String? content,
  required Color? bgColor,
  required Color? textColor,
  void Function()? onPressed,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 7),
      action: SnackBarAction(
        textColor: backgroundGrey1,
        onPressed: onPressed ?? () {},
        label: 'Try again',
      ),
      content: Row(
        children: [
          SvgPicture.asset(
            getImage(folderName: 'icons', fileName: 'wifi.svg'),
            color: backgroundGrey1,
            width: 22.w,
          ),
          SizedBox(
            width: 8.w,
          ),
          Flexible(
            child: textLabel(text: content ?? '', color: textColor ?? midGrey1),
          )
        ],
      ),
      backgroundColor: midGrey2,
    ),
  );
}
