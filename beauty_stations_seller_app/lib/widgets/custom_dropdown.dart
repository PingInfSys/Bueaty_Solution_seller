import 'package:beauty_solution_seller_app/resource/color_manager.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/extentions.dart';
import 'package:beauty_solution_seller_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final String titleText;
  final String initialValue;
  final ValueChanged<dynamic>? onChanged;
  final Object? selectedValue;
  final List<DropdownMenuItem<Object>>? items;
  final double? width;
  final bool isActive;
  final bool isRequiredFlag;
  final bool isShadow;
  final bool showClearIcon;
  final dynamic onClearFun;
  final String? Function(Object?)? validatorFun;
  final EdgeInsetsGeometry? contentPadding;

  final Color? hintColor;
  final double? hintsize;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? fillColor;
  final String? errorText;
  final String? title;
  final Color? titleColor;
  final IconData? prefixIcon;
  final double? borderRadius;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final TextAlign? textAlign;

  final Widget? suffixWidget;

  const CustomDropdown({
    super.key,
    this.hintText = "",
    this.titleText = "",
    this.onChanged,
    this.selectedValue,
    required this.items,
    this.initialValue = "",
    this.width,
    this.onClearFun,
    this.isActive = true,
    this.isRequiredFlag = true,
    this.showClearIcon = false,
    this.isShadow = true,
    this.contentPadding,
    this.validatorFun,
    this.hintColor,
    this.hintsize,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.fillColor,
    this.errorText,
    this.title,
    this.titleColor,
    this.borderRadius,
    this.textAlign,
    this.suffixWidget,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixIcon,
  });

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
                      color: titleColor ?? ColorManager.mainColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (isRequiredFlag)
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
        //******* text field  ******* */
        DropdownButtonFormField(
          dropdownColor: ColorManager.neutral200,
          borderRadius: 8.borderRadius,
          menuMaxHeight: 0.5.sh,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          isExpanded: true,
          iconEnabledColor: ColorManager.mainColor,
          elevation: 0,
          iconDisabledColor: ColorManager.mainColor,
          alignment: AlignmentDirectional.centerStart,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: ColorManager.mainColor,
            size: 26,
          ),
          disabledHint: Text(
            'loading'.tr(context: context),
            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            overflow: TextOverflow.ellipsis,
          ),
          value: selectedValue,
          onChanged: onChanged,
          items: items,
          validator: isRequiredFlag
              ? (validatorFun ??
                  (value) {
                    if (value == "" || value == null) {
                      return "${title ?? hintText} مطلوب";
                    } else {
                      return null;
                    }
                  })
              : null,
          style: TextStyle(
            color: ColorManager.neutral950,
            fontSize: 14.sp,
          ),
          hint: Text(
            hintText,
            style: TextStyle(
              color: hintColor ?? ColorManager.neutral600,
              fontSize: hintsize ?? 14.sp,
            ),
          ),
          decoration: InputDecoration(
            counterText: ' ',
            errorText: errorText,
            errorStyle: TextStyle(
              color: ColorManager.otherRed2,
              fontSize: 12.sp,
            ),
            prefixIcon: prefixWidget ??
                (prefixIcon != null
                    ? Padding(
                        padding: EdgeInsetsDirectional.only(start: 12.w, end: 8.w),
                        child: Icon(
                          prefixIcon,
                          size: 26.r,
                        ),
                      )
                    : null),
            suffix: suffixWidget,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            filled: true,
            alignLabelWithHint: true,
            errorMaxLines: 1,
            suffixStyle: const TextStyle(
              color: ColorManager.neutral600,
              fontSize: 14,
            ),
            isDense: true,
            hintStyle: TextStyle(
              color: hintColor ?? ColorManager.neutral400,
              fontSize: 14.sp,
            ),
            contentPadding: contentPadding ?? EdgeInsets.only(left: 12.w, right: 12.w, top: 8.h, bottom: 10.h),
            hintText: hintText,
            fillColor: fillColor ?? Colors.transparent,
            border: OutlineInputBorder(
              // borderRadius: 8.borderRadius,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
              borderSide: BorderSide(color: enabledBorderColor ?? ColorManager.neutral400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
              borderSide: BorderSide(color: enabledBorderColor ?? ColorManager.neutral400),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
              borderSide: const BorderSide(color: ColorManager.neutral400),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
              borderSide: const BorderSide(color: ColorManager.otherRed2, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
              borderSide: BorderSide(color: focusedBorderColor ?? ColorManager.mainColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
              borderSide: const BorderSide(color: ColorManager.otherRed2, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
