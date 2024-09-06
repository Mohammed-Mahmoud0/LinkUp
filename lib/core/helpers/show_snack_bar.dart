import 'package:flutter/material.dart';
import 'package:link_up/core/theming/colors.dart';

void showSnackBar(BuildContext context, String message,
    {Color backgroundColor = ColorsManager.dark}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: ColorsManager.offWhite,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
