// lib/cubit/home_cubit.dart
import 'package:beauty_solution_seller_app/features/home_feature/data/location_data_model.dart';
import 'package:beauty_solution_seller_app/features/home_feature/data/working_times.dart';
import 'package:beauty_solution_seller_app/features/home_feature/repositories/home_repository.dart';
import 'package:beauty_solution_seller_app/resource/constants_manager.dart';
import 'package:beauty_solution_seller_app/services/files/files_picker_service.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/app_logs.dart';
import 'package:beauty_solution_seller_app/utils/ui_utils/ui_globals.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../../../resource/enums_manager.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());
  final salonNameController = TextEditingController();
  final nationalController = TextEditingController();
  final makeupArtistNameController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final idController = TextEditingController();
  final locationController = TextEditingController();
  final locationLatController = TextEditingController();
  final locationLongController = TextEditingController();
  final cityController = TextEditingController();
  final contractPercentageController = TextEditingController();

  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final ibanController = TextEditingController();
  final bankNameController = TextEditingController();
  //OfficialWorkingHours from time and to time ist 5 days from sunday to thursday
  final officialWorkingHoursFromTimeControllerList =
      List.generate(5, (index) => TextEditingController());
  final officialWorkingHoursToTimeControllerList =
      List.generate(5, (index) => TextEditingController());

  // all days
  final officialWorkingHoursFromTimeAllDyesController = TextEditingController();
  final officialWorkingHoursToTimeAllDyesController = TextEditingController();

  //Working hours on official holidays
  final workingHoursOnOfficialHolidaysFromTimeController =
      TextEditingController();
  final workingHoursOnOfficialHolidaysToTimeController =
      TextEditingController();
  //*مواعيد العمل في الأعياد و المناسبات
  final workingHoursOnHolidaysFromTimeController = TextEditingController();
  final workingHoursOnHolidaysToTimeController = TextEditingController();
  //*حسابات التواصل الإجتماعي
  final socialAccountLinkController = TextEditingController();
  //*الموقع الإلكتروني
  final websiteController = TextEditingController();
  //*رقم هاتف خدمة العملاء
  final customerServicePhoneNumberController = TextEditingController();
  //*البريد الإلكتروني لخدمة العملاء
  final customerServiceEmailController = TextEditingController();
  //*تم التسجيل بواسطة
  final registeredByPhoneController = TextEditingController();
  //*رقم جوال مسجل البائع
  final sellerRegisteredPhoneNumberController = TextEditingController();
  final sellerRegisteredNameController = TextEditingController();
  // تاريخ تسجيل البائع
  final sellerRegistrationDateController = TextEditingController();

  final GlobalKey<FormState> workingDaysFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> sellerDtaFormKey = GlobalKey<FormState>();
  final FilesPickerService _filesPickerService = FilesPickerService();
  List<WorkingTimes> workingTimes = [];
//*اعادةتحميل التطبيق علي حالته الاولي
  void restartApp(BuildContext context) {
    Phoenix.rebirth(context);
  }

  void restartAppWithDelay(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      // ignore: use_build_context_synchronously
      restartApp(context);
    });
  }

  //* toggle between salon and beauty station
  void toggleSalon() {
    emit(state.copyWith(isSalon: !state.isSalon));
  }

  //* toggle between send via email or Phone,
  void toggleSendViaEmail() {
    emit(state.copyWith(sendViaEmail: !state.sendViaEmail));
  }

  //* toggle between salon and beauty station

  //* pick licenseImage  file
  Future<void> pickLicenseImage() async {
    final file = await _filesPickerService.pickFile(
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        type: FileType.custom);
    if (file != null) {
      emit(state.copyWith(licenseImage: file.path));
    }
  }

  //* pick previousWorkFiles
  Future<void> pickPreviousWorkFiles() async {
    final files = await _filesPickerService.pickMultipleFiles(
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        type: FileType.custom);
    if (files.isNotEmpty) {
      emit(state.copyWith(previousWorkFiles: files));
    }
  }

  //* pick logoImage  file
  Future<void> pickLogoImage() async {
    final file = await _filesPickerService.pickFile(type: FileType.image);
    if (file != null) {
      emit(state.copyWith(logoImage: file.path));
    }
  }

  //* pick profileFiles
  Future<void> pickProfileFiles() async {
    final files = await _filesPickerService.pickMultipleFiles(
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        type: FileType.custom);
    if (files.isNotEmpty) {
      emit(state.copyWith(profileFiles: files));
    }
  }

  //* pick manusAndPricingFiles only excel file
  Future<void> pickManusAndPricingFile() async {
    final file = await _filesPickerService.pickFile(
        allowedExtensions: ['xlsx', 'pdf', 'xls'], type: FileType.custom);
    if (file != null) {
      emit(state.copyWith(manusAndPricingFile: file.path));
    }
  }

  //* pick makeupArtistPhoto
  Future<void> pickMakeupArtistPhoto() async {
    final file = await _filesPickerService.pickFile(type: FileType.image);
    if (file != null) {
      emit(state.copyWith(makeupArtistPhoto: file.path));
    }
  }

  setAllDays(bool bool) {
    if (bool) {
      for (var i = 0;
          i < officialWorkingHoursFromTimeControllerList.length;
          i++) {
        officialWorkingHoursFromTimeControllerList[i].clear();
        officialWorkingHoursToTimeControllerList[i].clear();
      }
    } else {
      officialWorkingHoursFromTimeAllDyesController.clear();
      officialWorkingHoursToTimeAllDyesController.clear();
    }
    emit(state.copyWith(allDays: bool));
  }

  void acceptSigningContract(bool? value) {
    emit(state.copyWith(acceptSigningContract: value ?? false));
  }

  bool addSelectedDays(BuildContext context) {
    workingTimes = [];

    if (workingHoursOnOfficialHolidaysFromTimeController.text.isEmpty ||
        workingHoursOnOfficialHolidaysToTimeController.text.isEmpty) {
      UIGlobal.showCustomTost(context,
          title: 'من فضلك ادخل مواعيد العمل في الأجازات الرسمية');
      return false;
    }
    if (workingHoursOnHolidaysFromTimeController.text.isEmpty ||
        workingHoursOnHolidaysToTimeController.text.isEmpty) {
      UIGlobal.showCustomTost(context,
          title: 'من فضلك ادخل مواعيد العمل في الأعياد و المناسبات');
      return false;
    }

    if (state.allDays) {
      if (officialWorkingHoursFromTimeAllDyesController.text.isEmpty ||
          officialWorkingHoursToTimeAllDyesController.text.isEmpty) {
        UIGlobal.showCustomTost(context,
            title: 'من فضلك ادخل مواعيد العمل في كل الأيام');
        return false;
      } else {
        for (int i = 0; i < 5; i++) {
          workingTimes.add(WorkingTimes(
            dayName: ConstantsManager.workingDays.keys.elementAt(i),
            fromTime: officialWorkingHoursFromTimeAllDyesController.text,
            toTime: officialWorkingHoursToTimeAllDyesController.text,
          ));
        }
        return true;
      }
    } else {
      for (int i = 0; i < 5; i++) {
        final fromTime = officialWorkingHoursFromTimeControllerList[i].text;
        final toTime = officialWorkingHoursToTimeControllerList[i].text;

        if (fromTime.isEmpty && toTime.isEmpty) {
          continue;
        } else if (fromTime.isEmpty || toTime.isEmpty) {
          UIGlobal.showCustomTost(context,
              title: 'من فضلك ادخل مواعيد العمل في الأيام الرسمية بشكل صحيح');
          return false;
        } else {
          workingTimes.add(WorkingTimes(
            dayName: ConstantsManager.workingDays.keys.elementAt(i),
            fromTime: fromTime,
            toTime: toTime,
          ));
        }
      }

      if (workingTimes.isNotEmpty) {
        return true;
      } else {
        UIGlobal.showCustomTost(context,
            title: 'من فضلك ادخل مواعيد العمل في الأيام الرسمية بشكل صحيح');
        return false;
      }
    }
  }

  Future<void> createSellerSalonAccount(context) async {
    AppLogs.debugLog('laaaaaat ${double.parse(locationLatController.text)}');
    AppLogs.debugLog('long ${double.parse(locationLongController.text)}');
    try {
      emit(state.copyWith(status: ApiStatus.loading));

      final response = await HomeRepository().createSellerSalonAccount(
        FormData.fromMap(
          {
            'LocationName': locationController.text,
            'city': cityController.text,
            // 'SellerMobile': sellerRegisteredPhoneNumberController.text,
            // 'CommercialRecordNumber': licenseNumberController.text,
            // 'CustomerServiceEmail': customerServiceEmailController.text,
            'SellerRegistrationDate': sellerRegistrationDateController.text,
            // if (ibanController.text.isNotEmpty) 'IBAN': "SA${ibanController.text}",
            // 'BankName': bankNameController.text,
            'SalonName': salonNameController.text,
            'mobileNumber': phoneNumberController.text,
            'latitude': locationLatController.text,
            'longitude': locationLongController.text,
            // 'holidayWorkingHours': '${workingHoursOnHolidaysFromTimeController.text} - ${workingHoursOnHolidaysToTimeController.text}',
            // 'festivalWorkingHours': '${workingHoursOnOfficialHolidaysFromTimeController.text} - ${workingHoursOnOfficialHolidaysToTimeController.text}',
            // 'customerServicePhone': customerServicePhoneNumberController.text,
            'registeredBy': sellerRegisteredNameController.text,
            // 'website': websiteController.text,
            'email': emailController.text,
            // 'socialMediaAccounts': socialAccountLinkController.text,
            "contractPrecentage": contractPercentageController.text.isNotEmpty
                ? double.tryParse(contractPercentageController.text)
                : 0.0,
            "isAgreeToContract": state.acceptSigningContract,
            "IsMail": state.sendViaEmail,

            // 'workingHours': [
            //   for (var i = 0; i < workingTimes.length; i++) {"day": workingTimes[i].dayName, "from": workingTimes[i].fromTime, "to": workingTimes[i].toTime}
            // ],
            // if (state.licenseImage != null) 'CommercialRecordImage': await MultipartFile.fromFile(state.licenseImage ?? ''),
            // if (state.profileFiles != null)
            //   'salonImages': [
            //     for (var i = 0; i < (state.profileFiles?.length ?? 0); i++) await MultipartFile.fromFile(state.profileFiles?[i] ?? ''),
            //   ],
            // if (state.profileFiles != null)
            //   'profileImages': [
            //     for (var i = 0; i < (state.profileFiles?.length ?? 0); i++) await MultipartFile.fromFile(state.profileFiles?[i] ?? ''),
            //   ],
            // if (state.manusAndPricingFile != null) 'ServicesAndPrices': await MultipartFile.fromFile(state.manusAndPricingFile ?? ''),
            // if (state.logoImage != null) 'logo': await MultipartFile.fromFile(state.logoImage ?? ''),
          },
        ),
      );

      if (response.status == ApiStatus.success) {
        emit(state.copyWith(status: ApiStatus.success));
        UIGlobal.showCustomTost(context, title: response.message);
        Future.delayed(
            const Duration(seconds: 2), () => restartApp(context));
      } else {
        emit(state.copyWith(
            status: ApiStatus.error, errorMessage: response.message));
        UIGlobal.showCustomTost(context, title: response.message);
      }
    } catch (e) {
      emit(state.copyWith(status: ApiStatus.error, errorMessage: e.toString()));
      UIGlobal.showCustomTost(context, title: e.toString());
      rethrow;
    }
  }
  //* createSellerMakeupArtistAccount

  Future<void> createSellerMakeupArtistAccount(context) async {
    AppLogs.debugLog('laaaaaat ${double.parse(locationLatController.text)}');
    try {
      emit(state.copyWith(status: ApiStatus.loading));

      final response = await HomeRepository().createSellerMakeupArtistAccount(
        FormData.fromMap(
          {
            'locationName': locationController.text,
            'city': cityController.text,
            // 'sellerMobile': sellerRegisteredPhoneNumberController.text,
            // 'commercialRecordNumber': licenseNumberController.text,
            // 'customerServiceEmail': customerServiceEmailController.text,
            'sellerRegistrationDate': sellerRegistrationDateController.text,
            // if (ibanController.text.isNotEmpty) 'iban': "SA${ibanController.text}",
            // 'bankName': bankNameController.text,
            'beauticianName': makeupArtistNameController.text,
            // 'licenseNumber': licenseNumberController.text,
            // 'nationalId': idController.text,
            'mobileNumber': phoneNumberController.text,
            'latitude': locationLatController.text,
            'longitude': locationLongController.text,
            // 'holidayWorkingHours': '${workingHoursOnHolidaysFromTimeController.text} - ${workingHoursOnHolidaysToTimeController.text}',
            // 'festivalWorkingHours': '${workingHoursOnOfficialHolidaysFromTimeController.text} - ${workingHoursOnOfficialHolidaysToTimeController.text}',
            // 'customerServicePhone': customerServicePhoneNumberController.text,
            // "nationality": nationalController.text,
            'registeredBy': sellerRegisteredNameController.text,
            // 'website': websiteController.text,
            'email': emailController.text,
            // 'socialMediaAccounts': socialAccountLinkController.text,
            "contractPrecentage": contractPercentageController.text.isNotEmpty
                ? double.tryParse(contractPercentageController.text)
                : 0.0,
            "isAgreeToContract": state.acceptSigningContract,
            "IsMail": state.sendViaEmail,

            // 'WorkingHours': [
            //   for (var i = 0; i < workingTimes.length; i++) {"day": workingTimes[i].dayName, "from": workingTimes[i].fromTime, "to": workingTimes[i].toTime}
            // ],
            // if (state.licenseImage != null) 'commercialRecordImage': await MultipartFile.fromFile(state.licenseImage ?? ''),
            // if (state.previousWorkFiles != null)
            //   'previousWorkImages': [
            //     for (var i = 0; i < (state.previousWorkFiles?.length ?? 0); i++) await MultipartFile.fromFile(state.previousWorkFiles?[i] ?? ''),
            //   ],
            // if (state.profileFiles != null)
            //   'profileImages': [
            //     for (var i = 0; i < (state.profileFiles?.length ?? 0); i++) await MultipartFile.fromFile(state.profileFiles?[i] ?? ''),
            //   ],
            // if (state.manusAndPricingFile != null) 'servicesAndPrices': await MultipartFile.fromFile(state.manusAndPricingFile ?? ''),
            // if (state.logoImage != null) 'logo': await MultipartFile.fromFile(state.logoImage ?? ''),
            // if (state.makeupArtistPhoto != null) 'profilePicture': await MultipartFile.fromFile(state.makeupArtistPhoto ?? ''),
            // if (state.licenseImage != null) 'licenseImage': await MultipartFile.fromFile(state.licenseImage ?? ''),
          },
        ),
      );

      if (response.status == ApiStatus.success) {
        emit(state.copyWith(status: ApiStatus.success));
        UIGlobal.showCustomTost(context, title: response.message);
        Future.delayed(const Duration(seconds: 2), () => restartApp(context));
      } else {
        emit(state.copyWith(
            status: ApiStatus.error, errorMessage: response.message));
        UIGlobal.showCustomTost(context, title: response.message);
      }
    } catch (e) {
      emit(state.copyWith(status: ApiStatus.error, errorMessage: e.toString()));
      UIGlobal.showCustomTost(context, title: e.toString());
      rethrow;
    }
  }

  //*  saudi arabia cities name list CitesModel({required this.id, required this.name}),

  List<CitesModel> cities = [
    CitesModel(id: 1, name: 'الرياض'),
    CitesModel(id: 2, name: 'جدة'),
    CitesModel(id: 3, name: 'مكة'),
    CitesModel(id: 4, name: 'المدينة المنورة'),
    CitesModel(id: 5, name: 'الدمام'),
    CitesModel(id: 6, name: 'الخبر'),
    CitesModel(id: 7, name: 'الظهران'),
    CitesModel(id: 8, name: 'أبها'),
    CitesModel(id: 9, name: 'تبوك'),
    CitesModel(id: 10, name: 'الطائف'),
    CitesModel(id: 11, name: 'الجبيل'),
    CitesModel(id: 12, name: 'حائل'),
    CitesModel(id: 13, name: 'نجران'),
    CitesModel(id: 14, name: 'ينبع'),
    CitesModel(id: 15, name: 'القصيم'),
    CitesModel(id: 16, name: 'خميس مشيط'),
    CitesModel(id: 17, name: 'الأحساء'),
    CitesModel(id: 18, name: 'الخفجي'),
    CitesModel(id: 19, name: 'جازان'),
    CitesModel(id: 20, name: 'سكاكا'),
  ];

  // create list of seller
  List<String> sellerType = [
    "مندوب ١",
    "مندوب ٢",
    "مندوب ٣",
    "مندوب ٤",
  ];
}
