// ignore_for_file: must_be_immutable

import 'package:beauty_solution_seller_app/resource/color_manager.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/extentions.dart';
import 'package:beauty_solution_seller_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Color? hintColor;
  final double? hintTextSize;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? disableBorderColor;
  final Color? fillColor;
  final String? errorText;
  final String? initialValue;
  final String? title;
  final Color? titleColor;
  final String? suffixText;
  final Function(String?)? onSaved;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final bool? enabled;
  final bool? availableArabic;
  final TextInputType? type;
  final TextEditingController? controller;
  final Color? cursorColor;
  final Color? textColor;
  final bool isNumber;
  final bool obscureText;
  final int? linesNumber;
  final EdgeInsetsGeometry? contentPadding;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefixWidget;
  final TextAlign? textAlign;
  final TextInputAction? textInputAction;
  final bool? isAutofocus;
  final List<TextInputFormatter>? inputFormatter;
  final FocusNode? focusNode;
  final Function(PointerDownEvent)? onTapOutside;
  final bool isRequired;
  final bool readOnly;
  final Function()? togglePasswordVisibility;
  final Widget? suffixWidget;
  final VoidCallback? onEditingComplete;
  final EdgeInsetsGeometry? padding;
  final bool? isWithoutLeftBorder;
  final String? counterText;

  const CustomTextField({
    super.key,
    this.errorText,
    this.hintColor,
    this.hintTextSize,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.fillColor,
    this.type,
    this.hintText,
    this.onSaved,
    this.enabled = true,
    this.validator,
    this.onChange,
    this.onTap,
    this.availableArabic = true,
    this.controller,
    this.isNumber = false,
    this.isRequired = true,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.linesNumber = 1,
    this.textAlign,
    this.cursorColor,
    this.contentPadding,
    this.textInputAction,
    this.isAutofocus,
    this.inputFormatter,
    this.textColor,
    this.title,
    this.titleColor,
    this.initialValue,
    this.focusNode,
    this.readOnly = false,
    this.onSubmitted,
    this.suffixText,
    this.onTapOutside,
    this.togglePasswordVisibility,
    this.suffixWidget,
    this.onEditingComplete,
    this.prefixWidget,
    this.padding,
    this.isWithoutLeftBorder = false,
    this.counterText,
    this.disableBorderColor,
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
                      fontSize: hintTextSize ?? 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (isRequired)
                    CustomText(
                      title: ' *',
                      textStyle: TextStyle(
                        color: ColorManager.otherRed2,
                        fontSize: hintTextSize ?? 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          ),
        //******* text field  ******* */
        TextFormField(
          focusNode: focusNode,
          autofocus: isAutofocus ?? false,
          textInputAction: textInputAction ?? TextInputAction.next,
          obscureText: obscureText,
          onTapOutside: onTapOutside ?? (event) => FocusScope.of(context).unfocus(),
          maxLines: linesNumber,
          enabled: enabled,
          textAlignVertical: TextAlignVertical.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly: readOnly,
          initialValue: initialValue,
          onEditingComplete: onEditingComplete,
          onSaved: onSaved,
          validator: isRequired
              ? (validator ??
                  (value) {
                    if (value == "" || value == null) {
                      return "${title ?? hintText} ${'required'.tr(context: context)}";
                    } else {
                      return null;
                    }
                  })
              : null,
          cursorColor: cursorColor ?? ColorManager.mainColor,
          keyboardType: type ?? TextInputType.text,
          onTap: onTap,
          onChanged: onChange,
          onFieldSubmitted: onSubmitted,
          controller: controller,
          style: TextStyle(
            color: titleColor ?? ColorManager.mainColor,
            fontSize: 14.sp,
          ),
          autocorrect: true,
          inputFormatters: inputFormatter ?? (isNumber ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly] : []),
          decoration: InputDecoration(
            counterText: counterText ?? ' ',
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
            // prefixIconColor: ColorManager.mainColor,
            suffix: suffixWidget,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffixIcon: suffixIcon ??
                (type == TextInputType.visiblePassword
                    ? GestureDetector(
                        onTap: togglePasswordVisibility,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(start: 8.w, end: 12.w),
                          child: Icon(
                            obscureText ? Icons.visibility_off : Icons.visibility,
                            color: obscureText ? ColorManager.mainColor50 : ColorManager.neutral950,
                            size: 26.r,
                          ),
                        ),
                      )
                    : null),
            suffixText: suffixText,
            suffixStyle: TextStyle(
              color: titleColor ?? ColorManager.mainColor,
              fontSize: 14.sp,
            ),

            filled: true,
            alignLabelWithHint: true,
            errorMaxLines: 3,

            isDense: true,
            hintStyle: TextStyle(
              color: hintColor ?? ColorManager.neutral400,
              fontSize: hintTextSize ?? 14.sp,
            ),
            contentPadding: contentPadding ?? EdgeInsets.only(left: 12.w, right: 12.w, top: 8.h, bottom: 10.h),
            hintText: hintText,
            fillColor: fillColor ?? Colors.transparent,
            border: OutlineInputBorder(
              // borderRadius: 8.borderRadius,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isWithoutLeftBorder! ? 0 : 8.r),
                bottomRight: Radius.circular(8.r),
                topLeft: Radius.circular(isWithoutLeftBorder! ? 0 : 8.r),
                topRight: Radius.circular(8.r),
              ),
              borderSide: BorderSide(color: enabledBorderColor ?? ColorManager.neutral400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isWithoutLeftBorder! ? 0 : 8.r),
                bottomRight: Radius.circular(8.r),
                topLeft: Radius.circular(isWithoutLeftBorder! ? 0 : 8.r),
                topRight: Radius.circular(8.r),
              ),
              borderSide: BorderSide(color: enabledBorderColor ?? ColorManager.neutral400),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isWithoutLeftBorder! ? 0 : 8.r),
                bottomRight: Radius.circular(8.r),
                topLeft: Radius.circular(isWithoutLeftBorder! ? 0 : 8.r),
                topRight: Radius.circular(8.r),
              ),
              borderSide: BorderSide(color: disableBorderColor ?? ColorManager.neutral400),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isWithoutLeftBorder! ? 0 : 8.r),
                bottomRight: Radius.circular(8.r),
                topLeft: Radius.circular(isWithoutLeftBorder! ? 0 : 8.r),
                topRight: Radius.circular(8.r),
              ),
              borderSide: const BorderSide(color: ColorManager.otherRed2, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isWithoutLeftBorder! ? 0 : 8.r),
                bottomRight: Radius.circular(8.r),
                topLeft: Radius.circular(isWithoutLeftBorder! ? 0 : 8.r),
                topRight: Radius.circular(8.r),
              ),
              borderSide: BorderSide(color: focusedBorderColor ?? ColorManager.mainColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isWithoutLeftBorder! ? 0 : 8.r),
                bottomRight: Radius.circular(8.r),
                topLeft: Radius.circular(isWithoutLeftBorder! ? 0 : 8.r),
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
