import 'package:beauty_solution_seller_app/config/locale/locale_setup.dart';
import 'package:beauty_solution_seller_app/config/theme/app_theme.dart';
import 'package:beauty_solution_seller_app/features/home_feature/views/home_view.dart';
import 'package:beauty_solution_seller_app/resource/app_keys.dart';
import 'package:beauty_solution_seller_app/resource/strings_manager.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/app_logs.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeautyStationApp extends StatefulWidget {
  const BeautyStationApp({super.key});

  @override
  BeautyStationAppState createState() => BeautyStationAppState();
}

class BeautyStationAppState extends State<BeautyStationApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      // designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        AppLogs.infoLog(
            "ScreenUtil ============>screenWidth ${ScreenUtil().screenWidth},screenHeight ${ScreenUtil().screenHeight} ,pixelRatio ${ScreenUtil().pixelRatio} ,statusBarHeight ${ScreenUtil().statusBarHeight} ,bottomBarHeight ${ScreenUtil().bottomBarHeight} ,textScaleFactor ${ScreenUtil().textScaleFactor} ");

        return AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: AppKeys.navigatorKey,
            title: AppStrings.appName,
            home: const HomeView(),
            theme: AppTheme().appLightTheme(),
            locale: const Locale('ar'),
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
              Locale.fromSubtags(
                languageCode: 'ar',
                countryCode: 'SA',
              ), // Generic Simplified Chinese 'zh_Hans'
              // Generic traditional Chinese 'zh_Hant'
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              CountryLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocale != null &&
                    deviceLocale.languageCode == locale.languageCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
          ),
        );
      },
    );
  }
}
