import 'package:dev_quiz/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NextButtonWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color fontColor;
  final Color borderColor;
  final Color overlayColor;
  final VoidCallback onTap;

  const NextButtonWidget(
      {Key? key,
      required this.label,
      required this.backgroundColor,
      required this.fontColor,
      required this.borderColor,
      required this.overlayColor,
      required this.onTap})
      : super(key: key);

  NextButtonWidget.green({required String label, required VoidCallback onTap})
      : this.backgroundColor = AppColors.darkGreen,
        this.overlayColor = AppColors.green,
        this.fontColor = AppColors.white,
        this.borderColor = AppColors.darkGreen,
        this.label = label,
        this.onTap = onTap;

  NextButtonWidget.purple({required String label, required VoidCallback onTap})
      : this.backgroundColor = AppColors.purple,
        this.overlayColor = AppColors.grey,
        this.fontColor = AppColors.white,
        this.borderColor = AppColors.purple,
        this.label = label,
        this.onTap = onTap;

  NextButtonWidget.white({required String label, required VoidCallback onTap})
      : this.backgroundColor = AppColors.white,
        this.overlayColor = AppColors.lightGrey,
        this.fontColor = AppColors.grey,
        this.borderColor = AppColors.border,
        this.label = label,
        this.onTap = onTap;

  NextButtonWidget.transparent(
      {required String label, required VoidCallback onTap})
      : this.backgroundColor = Colors.transparent,
        this.overlayColor = AppColors.lightGreen,
        this.fontColor = AppColors.grey,
        this.borderColor = Colors.transparent,
        this.label = label,
        this.onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        fixedSize: MaterialStateProperty.all(Size.fromHeight(48)),
        side: MaterialStateProperty.all(
          BorderSide(color: borderColor),
        ),
        overlayColor: MaterialStateProperty.all(overlayColor),
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: GoogleFonts.notoSans(
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: fontColor,
        ),
      ),
    );
  }
}
