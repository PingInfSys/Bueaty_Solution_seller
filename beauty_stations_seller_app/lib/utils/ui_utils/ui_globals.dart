// ignore_for_file: deprecated_member_use

import 'package:beauty_solution_seller_app/resource/color_manager.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/extentions.dart';
import 'package:beauty_solution_seller_app/widgets/custom_button.dart';
import 'package:beauty_solution_seller_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIGlobal {
//**************** */ showBottomSheetNoService *********************/
  static Future<void> showBottomSheet(context, {Widget? child, double? hight}) async {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: ColorManager.neutralWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(8.r))),
      builder: (BuildContext context) {
        return Container(
          width: 1.sw,
          height: hight,
          color: ColorManager.neutralWhite,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
            child: child,
          ),
        );
      },
    );
  }

//**************** */ showBottomSheetNoService *********************/
  static Future<void> showCustomTost(context, {String title = ''}) async {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: ColorManager.neutralWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          width: 1.sw,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
            child: CustomText(
              title: title,
              color: ColorManager.neutral900,
            ).allPadding(15),
          ),
        );
      },
    );
  }

//**************** */ showAlertDialog *********************/
  static Future<void> showAlertDialog({
    required BuildContext context,
    String? title,
    void Function()? onTapBtnOne,
    void Function()? onTapBtnTow,
    String? textOne,
    String? textTwo,
    List<Widget>? actions,
    String? content,
  }) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.start,
          backgroundColor: ColorManager.neutralWhite,
          insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* ************ */ Title *********************/
              CustomText(
                title: title ?? '',
                color: ColorManager.neutral600,
                size: 20,
                fontWeight: FontWeight.w600,
              ),
              //* ************ */ Content *********************/
              CustomText(
                title: content,
                color: ColorManager.neutral950,
                size: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ).horizontalPadding(30).verticalPadding(30),
          actions: actions ??
              [
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* ************ */ Button One *********************/
                      CustomButton(
                        text: textOne ?? '',
                        onTap: onTapBtnOne ?? () => Navigator.pop(context),
                        btnWidth: 133.w,
                        btnTextFontWeight: FontWeight.w700,
                      ),
                      20.horizontalSpace,
                      //* ************ */ Button Tow *********************/
                      CustomButton(
                        text: textTwo ?? '',
                        onTap: onTapBtnTow ?? () => Navigator.pop(context),
                        btnWidth: 133.w,
                        btnTextFontWeight: FontWeight.w700,
                      ),
                    ],
                  ).horizontalPadding(30).onlyPadding(bPadding: 20),
                ),
              ],
        );
      },
    );
  }
}
