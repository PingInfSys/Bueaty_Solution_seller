import 'package:beauty_solution_seller_app/resource/color_manager.dart';
import 'package:beauty_solution_seller_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadioButton extends StatelessWidget {
  final bool value;
  final void Function() onChanged;
  final String title;
  const CustomRadioButton({super.key, required this.value, required this.title, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onChanged,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: value ? ColorManager.mainColor : ColorManager.neutral400.withOpacity(0.5),
            child: CircleAvatar(
              radius: 9,
              backgroundColor: ColorManager.neutralWhite,
              child: CircleAvatar(
                radius: 7,
                backgroundColor: value ? ColorManager.mainColor : ColorManager.neutral200,
              ),
            ),
          ),
        ),
        8.horizontalSpace,
        CustomText(
            title: title,
            textStyle: TextStyle(
              color: ColorManager.mainColor,
              fontSize: 14.sp,
            )),
      ],
    );
  }
}
