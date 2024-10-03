import 'package:beauty_solution_seller_app/features/home_feature/cubites/home_cubit/home_cubit.dart';
import 'package:beauty_solution_seller_app/features/home_feature/cubites/home_cubit/home_state.dart';
import 'package:beauty_solution_seller_app/resource/color_manager.dart';
import 'package:beauty_solution_seller_app/resource/constants_manager.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/extentions.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/helpers_functions.dart';
import 'package:beauty_solution_seller_app/widgets/custom_text.dart';
import 'package:beauty_solution_seller_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class WorkingDaysWidget extends StatelessWidget {
  const WorkingDaysWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return Form(
      key: homeCubit.workingDaysFormKey,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (_, state) {
          return Column(
            children: [
              //! ************* مواعيد العمل الرسمية ***********
              const CustomText(
                title: 'مواعيد العمل الرسمية',
                color: ColorManager.mainColor,
                fontWeight: FontWeight.w600,
                
              ),
              //*************** select all days *************** */
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                    child: Checkbox(
                      activeColor: ColorManager.mainColor,
                      value: state.allDays,
                      onChanged: (value) => homeCubit.setAllDays(value!),
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: DayTimeFromAndTo(
                      controllerFrom: homeCubit.officialWorkingHoursFromTimeAllDyesController,
                      controllerTo: homeCubit.officialWorkingHoursToTimeAllDyesController,
                      dayName: 'كل الأيام',
                      allDays: !state.allDays,
                    ),
                  )
                ],
              ).verticalPadding(30),

              //****************** days ************* */
              ListView.separated(
                separatorBuilder: (BuildContext context, int index) => 5.verticalSpace,
                itemCount: ConstantsManager.workingDays.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return DayTimeFromAndTo(
                    controllerFrom: homeCubit.officialWorkingHoursFromTimeControllerList[index],
                    controllerTo: homeCubit.officialWorkingHoursToTimeControllerList[index],
                    dayName: ConstantsManager.workingDays.keys.elementAt(index),
                    allDays: state.allDays,
                  );
                },
              ),
              20.verticalSpace,

              //! ************* مواعيد العمل في الأجازات الرسمية***********
              const CustomText(
                title: 'مواعيد العمل في الأجازات الرسمية',
                color: ColorManager.mainColor,
                fontWeight: FontWeight.w600,
              ),
              10.verticalSpace,
              DayTimeFromAndTo(
                controllerFrom: homeCubit.workingHoursOnOfficialHolidaysFromTimeController,
                controllerTo: homeCubit.workingHoursOnOfficialHolidaysToTimeController,
                dayName: 'الأجازات الرسمية',
                allDays: false,
              ),

              28.verticalSpace,
              //*! ************* مواعيد العمل في الأعياد و المناسبات***********
              const CustomText(
                title: 'مواعيد العمل في الأعياد و المناسبات',
                color: ColorManager.mainColor,
                fontWeight: FontWeight.w600,
              ),
              10.verticalSpace,
              DayTimeFromAndTo(
                controllerFrom: homeCubit.workingHoursOnHolidaysFromTimeController,
                controllerTo: homeCubit.workingHoursOnHolidaysToTimeController,
                dayName: 'الأعياد و المناسبات',
                allDays: false,
              ),
            ],
          );
        },
      ).verticalPadding(5),
    );
  }
}

class DayTimeFromAndTo extends StatelessWidget {
  final TextEditingController controllerFrom, controllerTo;
  final String dayName;
  final bool allDays;

  const DayTimeFromAndTo({super.key, required this.controllerFrom, required this.controllerTo, required this.dayName, required this.allDays});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!allDays)
          const CircleAvatar(
            backgroundColor: ColorManager.mainColor50,
            radius: 4,
          ),
        10.horizontalSpace,
        //*************** day name *************** */
        Expanded(
          flex: 1,
          child: Container(
            alignment: AlignmentDirectional.center,
            padding: 5.hPadding + 10.vPadding,
            decoration: BoxDecoration(
              borderRadius: const BorderRadiusDirectional.horizontal(
                start: Radius.circular(10),
              ),
              color: allDays ? ColorManager.neutral400.withOpacity(0.3) : ColorManager.neutral400,
            ),
            child: CustomText(
              title: dayName,
              color: allDays ? ColorManager.neutral400 : ColorManager.neutral900,
              fontWeight: FontWeight.w600,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        5.horizontalSpace,
        //*************** from *************** */
        Expanded(
          flex: 2,
          child: CustomTextField(
            onTap: () async {
              final time = await HelperFunctions.showPickerTime(context);
              if (time != null) {
                // 14:15:00
                controllerFrom.text = DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${time.hour}:${time.minute}:00"));
              }
            },
            controller: controllerFrom,
            hintText: 'من',
            //contentPadding: 10.vPadding,
            textAlign: TextAlign.center,
            counterText: '',
            enabled: !allDays,
            isRequired: false,
            readOnly: true,
            type: TextInputType.number,
            fillColor: Colors.transparent,
            hintColor: allDays ? ColorManager.neutral200 : const Color(0xFFD0D0D0),
          ).center(),
        ),
        CustomText(
          title: ':',
          color: allDays ? ColorManager.neutral200 : ColorManager.mainColor,
          fontWeight: FontWeight.w600,
          size: 20,
        ).horizontalPadding(5),
        //*************** to *************** */
        Expanded(
          flex: 2,
          child: CustomTextField(
            onTap: () async {
              final time = await HelperFunctions.showPickerTime(context);
              if (time != null) {
                controllerTo.text = DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${time.hour}:${time.minute}:00"));
              }
            },
            controller: controllerTo,
            hintText: 'إلى',
            //contentPadding: 10.vPadding,
            isRequired: false,
            counterText: '',
            readOnly: true,
            type: TextInputType.number,
            textAlign: TextAlign.center,
            enabled: !allDays,
            fillColor: Colors.transparent,
            hintColor: allDays ? ColorManager.neutral200 : const Color(0xFFD0D0D0),
          ).center(),
        ),
      ],
    );
  }
}
