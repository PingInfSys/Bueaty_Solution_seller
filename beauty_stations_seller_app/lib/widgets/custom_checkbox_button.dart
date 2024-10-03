import 'package:beauty_solution_seller_app/resource/color_manager.dart';
import 'package:beauty_solution_seller_app/resource/strings_manager.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String title;
  final String? hint;
  final double? width, height;
  final Color? color;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.width,
    this.height,
    this.color,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.transparent,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        selectedColor: Colors.transparent,
        selectedTileColor: Colors.transparent,
        minVerticalPadding: 0,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        titleAlignment: ListTileTitleAlignment.top,
        selected: true,
        leading: SizedBox(
          height: height ?? 20.r,
          width: width ?? 20.r,
          child: GestureDetector(
            onTap: () {
              onChanged(!value);
            },
            child: value
                ? Container(
                    decoration: BoxDecoration(
                      color: ColorManager.neutral700,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.check,
                      color: ColorManager.neutralWhite,
                      size: 16.r,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: ColorManager.neutral700, width: 2.w),
                    ),
                  ),
          ),
        ),
        // rich text
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: TextStyle(
                  color: ColorManager.neutral900,
                  fontFamily: AppStrings.fontFamily,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: hint,
                style: TextStyle(
                  color: ColorManager.otherRed2,
                  fontFamily: AppStrings.fontFamily,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ).horizontalPadding(10),
    );
  }
}
