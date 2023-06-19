import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class MiniPlatform extends StatelessWidget {
  const MiniPlatform(
      {super.key,
      required this.logo,
      this.logoColor,
      required this.platformName});

  final String logo;
  final Color? logoColor;
  final String platformName;

  @override
  Widget build(BuildContext context) {
    final boxShadow = BoxShadow(
      color: Theme.of(context).shadowColor,
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(1, 1),
    );
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [boxShadow]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).canvasColor,
            ),
            width: 40.sp,
            height: 40.sp,
            child: Center(
              child: Image.asset(
                logo,
                width: 25.sp,
                height: 20.sp,
                color: logoColor,
              ),
            ),
          ),
          Text(
            platformName,
            style: GoogleFonts.bebasNeue(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
