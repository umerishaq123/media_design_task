import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final double width, height, radius, paddingTop;
  final Color bgColor, labelColor;
  final bool? isLoading;
  final double fSize;
  final Function()? onTap;

  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.width,
    required this.height,
    required this.radius,
    this.isLoading = false,
    required this.onTap,
    required this.paddingTop,
    required this.bgColor,
    required this.labelColor,
    this.fSize = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        left: 8.w,
        right: 8.w,
      ),
      child: ElevatedButton(
        onPressed: (isLoading ?? false) ? null : onTap,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            minimumSize: Size(width, height),
            backgroundColor: bgColor,
            foregroundColor: Colors.white),
        child: (isLoading ?? false)
            ? SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator.adaptive(
                  strokeCap: StrokeCap.round,
                  strokeWidth: 2.5,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.grey.shade700),
                ))
            : Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: labelColor,
                  fontSize: fSize == 0 ? 15.sp : fSize,
                ),
              ),
      ),
    );
  }
}
