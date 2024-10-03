import 'dart:io';

import 'package:beauty_solution_seller_app/resource/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelperFunctions {
  static bool isTablet = 1.sw > 600 ? true : false;
  dynamic definePlatform(var p1, var p2) => (Platform.isIOS || Platform.isAndroid || Platform.isFuchsia) ? p1 : p2;

  //* ******  show get First Letters **********
  static String getFirstLetters(String name) {
    if (name.isEmpty) return '';

    List<String> nameParts = name.split(' ');
    String initials = '';

    for (String part in nameParts) {
      if (part.isNotEmpty) {
        initials += part[0];
      }
    }

    return initials;
  }

  static Future<TimeOfDay?> showPickerTime(BuildContext context) async {
    try {
      TimeOfDay timeFrom = TimeOfDay.now();

      TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: timeFrom.replacing(hour: timeFrom.hourOfPeriod),
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                // change the border color
                primary: ColorManager.mainColor,
                onSurface: ColorManager.neutralWhite,
                surface: ColorManager.black,
              ),
              // button colors
              buttonTheme: const ButtonThemeData(
                colorScheme: ColorScheme.light(primary: ColorManager.neutral600),
              ),
            ),
            child: child!,
          );
        },
      );
      if (picked != null) {
        // DateTime date = DateTime.now();
        // String second = date.second.toString().padLeft(2, '0');
        // List timeSplit = picked.format(context).split(' ');
        // String formattedTime = timeSplit[0];
        // String time = '$formattedTime:$second';
        // debugPrint(time); //
        return picked;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //**************** */ Date Picker *********************/
  static Future<DateTime?> showDatePick(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              // change the border color
              primary: ColorManager.mainColor,
              // change the text color
              onSurface: ColorManager.mainColor,
            ),
            // button colors
            buttonTheme: const ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: ColorManager.mainColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      debugPrint("Selected date: ${picked.day}/${picked.month}/${picked.year}");
      return picked;
    } else {
      return null;
    }
  }
}
