import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_desgin_expert_task/utilis/colors.dart';

class OrderSettingsRowWidget extends StatelessWidget {
  final String title;
  final String detail;
  final bool ischngeColor;
  final bool islocation;

  const OrderSettingsRowWidget({
    super.key,
    required this.title,
    required this.detail,
    this.ischngeColor=false,
    this.islocation=false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic, // Align text baselines
      children: [
        SizedBox(
          width: 120, // Fixed width for all titles
          child: Text(
            title,
            style: GoogleFonts.publicSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(islocation)
              Text("Deliver to:",
               style: GoogleFonts.publicSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: greyColor,
                  
                ),
                  softWrap: true,),
              Text(
                detail,
                style: GoogleFonts.publicSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color:ischngeColor?blackColor: greyColor,
                  
                ),
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}