import 'package:beauty_solution_seller_app/resource/color_manager.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/extentions.dart';
import 'package:beauty_solution_seller_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadFileDottedBorder extends StatelessWidget {
  const UploadFileDottedBorder({
    super.key,
    required this.onTap,
    required this.isFileLoaded,
    this.title,
    required this.showIsRequired,
  });

  final void Function() onTap;
  final bool isFileLoaded;
  final String? title;
  final bool showIsRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //******* title  ******* */
        if (title != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                children: [
                  CustomText(
                    title: title ?? '',
                    textStyle: TextStyle(
                      color: ColorManager.mainColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (showIsRequired)
                    CustomText(
                      title: ' *',
                      textStyle: TextStyle(
                        color: ColorManager.otherRed2,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: ColorManager.mainColor,
                width: 1.w,
              ),
            ),
            child: SizedBox(
              width: 1.sw,
              child: Column(
                children: [
                  // *********** */  icon if File is Loaded *********** */
                  isFileLoaded
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 25.w,
                        )
                      // *********** */  icon if File is not Loaded *********** */
                      : Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 26.r,
                        ),
                  4.verticalSpace,
                  CustomText(
                      title: title ?? 'تحميل الملف',
                      textStyle: TextStyle(
                        color: ColorManager.mainColor,
                        fontSize: 14.sp,
                      ))
                ],
              ),
            ).verticalPadding(10),
          ),
        ),
        8.verticalSpace,
        if (showIsRequired)
          CustomText(
              title: 'الملف مطلوب',
              textStyle: TextStyle(
                color: ColorManager.otherRed2,
                fontSize: 12.sp,
              )),
        8.verticalSpace,
      ],
    ).onlyPadding(bPadding: 20);
  }
}
