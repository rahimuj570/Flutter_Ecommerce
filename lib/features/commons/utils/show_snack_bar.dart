import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  bool isError = false,
}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: isError ? Colors.white : Colors.black),
      ),
      backgroundColor: !isError ? AppColors.snackBarSuccessColor : Colors.red,
      elevation: 1,
    ),
  );
}
