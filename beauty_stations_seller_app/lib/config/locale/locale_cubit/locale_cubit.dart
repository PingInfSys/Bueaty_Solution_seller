import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: const Locale('ar', '')));

  Future<void> getSavedLanguage() async {
   // final langCode = HiveStorage.get(HiveKeys.languageCode) ?? AppStrings.arabicCode;
    //emit(ChangeLocaleState(locale: Locale(langCode)));
  }

  // Future<void> changeLanguage(String languageCode) async {
  //   final currentlangCode = state.locale.languageCode;
  //   if (currentlangCode == languageCode) {
  //     return;
  //   }
  //   await HiveStorage.set(HiveKeys.languageCode, languageCode);
  //   emit(ChangeLocaleState(locale: Locale(languageCode)));
  // }
}
