import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicesInit {
  Future<void> init() async {
    ///** ****** ensure flutter Initialized ******** */
    WidgetsFlutterBinding.ensureInitialized();

    ///** ****** set Preferred Orientations to portrait only ******** */
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    //* ****** set ScreenUtil setup to fix text size in reals mode ******** */
    await ScreenUtil.ensureScreenSize();
  }
}
