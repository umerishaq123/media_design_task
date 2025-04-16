import 'package:flutter/material.dart';

import 'package:media_desgin_expert_task/utilis/colors.dart'; // Ensure this defines primaryColor

class SnackbarUtils {
  static void showCustomSnackbar({
    required BuildContext context, // Required for ScaffoldMessenger
    required String title,
    required String message,
    Color backgroundColor = primaryColor,
    Color textColor = Colors.white,
    IconData icon = Icons.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  message,
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}