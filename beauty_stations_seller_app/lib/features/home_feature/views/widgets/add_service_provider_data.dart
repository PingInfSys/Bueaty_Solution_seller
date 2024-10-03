import 'package:beauty_solution_seller_app/features/home_feature/cubites/home_cubit/home_cubit.dart';
import 'package:beauty_solution_seller_app/features/home_feature/cubites/home_cubit/home_state.dart';
import 'package:beauty_solution_seller_app/features/home_feature/data/location_data_model.dart';
import 'package:beauty_solution_seller_app/resource/color_manager.dart';
import 'package:beauty_solution_seller_app/resource/enums_manager.dart';
import 'package:beauty_solution_seller_app/services/maps_services/pick_location.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/app_logs.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/app_validate.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/extentions.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/helpers_functions.dart';
import 'package:beauty_solution_seller_app/widgets/custom_button.dart';
import 'package:beauty_solution_seller_app/widgets/custom_checkbox_button.dart';
import 'package:beauty_solution_seller_app/widgets/custom_dropdown.dart';
import 'package:beauty_solution_seller_app/widgets/custom_radio_button.dart';
import 'package:beauty_solution_seller_app/widgets/custom_text.dart';
import 'package:beauty_solution_seller_app/widgets/custom_text_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddServiceProviderData extends StatefulWidget {
  final bool isSalon;

  const AddServiceProviderData({super.key, required this.isSalon});

  @override
  State<AddServiceProviderData> createState() => _AddServiceProviderDataState();
}

class _AddServiceProviderDataState extends State<AddServiceProviderData> {
  late final HomeCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<HomeCubit>(context);
    cubit.contractPercentageController.addListener(_onPercentageChange);
  }

  void _onPercentageChange() {
    setState(() {}); // Trigger rebuild when text changes
  }

  @override
  void dispose() {
    cubit.contractPercentageController.removeListener(_onPercentageChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, bool>(
      selector: (state) => state.acceptSigningContract,
      builder: (context, acceptSigningContract) {
        return Form(
          key: cubit.sellerDtaFormKey,
          child: Column(
            children: [
              20.verticalSpace,
              //******** اسم الصالون ******* */
              CustomTextField(
                title: widget.isSalon ? "اسم الصالون" : 'اسم خبيرة التجميل',
                hintText: widget.isSalon ? "اسم الصالون" : 'اسم خبيرة التجميل',
                controller: widget.isSalon ? cubit.salonNameController : cubit.makeupArtistNameController,
                isRequired: true,
              ),
              //******** رقم السجل التجاري / الترخيص******* */
              // CustomTextField(
              //   title: "رقم السجل التجاري / الترخيص",
              //   hintText: "7000000000",
              //   controller: cubit.licenseNumberController,
              //   isNumber: true,
              //   type: TextInputType.number,
              //   isRequired: acceptSigningContract,
              //   textInputAction: TextInputAction.done,
              //   validator: (text) => AppValidate.licenseNumberValidate(text, context),
              // ),
              // //* ******* acceptSigningContract checkbox ****** */
              Column(
                children: [
                  CustomCheckbox(
                    title: 'أوافق على امضاء العقد',
                    hint: ' (في حالة الموافقة تصبح كل البيانات مطلوبة) ',
                    value: acceptSigningContract,
                    onChanged: (value) {
                      cubit.acceptSigningContract(value);
                    },
                  ),
                  20.verticalSpace,
                  //* ******* contractPercentageController ****** */
                  if (acceptSigningContract)
                    CustomTextField(
                      title: 'نسبة العمولة',
                      hintText: 'مثال: 50%',
                      controller: cubit.contractPercentageController,
                      isNumber: true,
                      type: TextInputType.number,
                      validator: (text) => AppValidate.contractPercentageValidate(text, context),
                    ),
                ],
              ).verticalPadding(20),
              // if (!widget.isSalon) ...[
              //   //* *******رقم الهوية / الإقامة****** */
              //   CustomTextField(
              //     title: "رقم الهوية / الإقامة",
              //     hintText: "1xxxxxxxxxxxxxx",
              //     controller: cubit.idController,
              //     isNumber: true,
              //     isRequired: acceptSigningContract,
              //     type: TextInputType.number,
              //     validator: (text) => AppValidate.idNumberValidate(text, context),
              //   ),
              //   //********************* الجنسية ******************* */
              //   GestureDetector(
              //     onTap: () async {
              //       showNationalDialog(context: context);
              //     },
              //     child: CustomTextField(
              //       enabled: false,
              //       title: 'الجنسية',
              //       hintText: 'الجنسية',
              //       controller: cubit.nationalController,
              //       isRequired: acceptSigningContract,
              //       suffixIcon: Icon(
              //         Icons.arrow_drop_down,
              //         color: ColorManager.mainColor,
              //         size: 25.r,
              //       ).horizontalPadding(8),
              //     ),
              //   ),

              //   //* ******* صورة شخصية***** */

              //   BlocSelector<HomeCubit, HomeState, String?>(
              //     selector: (state) => state.makeupArtistPhoto,
              //     builder: (context, makeupArtistPhoto) {
              //       return UploadFileDottedBorder(
              //         onTap: () async {
              //           await cubit.pickMakeupArtistPhoto();
              //         },
              //         isFileLoaded: makeupArtistPhoto != null,
              //         title: 'صورة شخصية',
              //         showIsRequired: acceptSigningContract && makeupArtistPhoto == null,
              //       );
              //     },
              //   ),
              // ],
              //******** صورة السجل التجاري******* */
              // BlocSelector<HomeCubit, HomeState, String?>(
              //   selector: (state) => state.licenseImage,
              //   builder: (context, licenseImage) {
              //     return UploadFileDottedBorder(
              //       onTap: () async {
              //         await cubit.pickLicenseImage();
              //       },
              //       isFileLoaded: licenseImage != null,
              //       title: ' صورة السجل التجاري/ الترخيص',
              //       showIsRequired: acceptSigningContract && licenseImage == null,
              //     );
              //   },
              // ),
              //* *******صور الصالون و أعمال سابقة******* */
              // BlocSelector<HomeCubit, HomeState, List<String>?>(
              //   selector: (state) => state.previousWorkFiles,
              //   builder: (context, previousWorkFiles) {
              //     return UploadFileDottedBorder(
              //       onTap: () async {
              //         await cubit.pickPreviousWorkFiles();
              //       },
              //       isFileLoaded: previousWorkFiles != null,
              //       title: widget.isSalon ? 'صور الصالون و أعمال سابقة' : 'صور الأعمال السابقة',
              //       showIsRequired: acceptSigningContract && previousWorkFiles == null,
              //     );
              //   },
              // ),
              //******** البروفايل ******* */
              // BlocSelector<HomeCubit, HomeState, List<String>?>(
              //   selector: (state) => state.profileFiles,
              //   builder: (context, profileFiles) {
              //     return UploadFileDottedBorder(
              //       onTap: () async {
              //         await cubit.pickProfileFiles();
              //       },
              //       isFileLoaded: profileFiles != null,
              //       title: ' صور البروفايل',
              //       showIsRequired: acceptSigningContract && profileFiles == null,
              //     );
              //   },
              // ),
              //********************* الموقع ******************* */
              GestureDetector(
                onTap: () async {
                  final LocationDataModel? locationDataModel = await Navigator.push(context, MaterialPageRoute(builder: (context) => const PickLocation()));
                  if (locationDataModel != null) {
                    cubit.locationController.text = locationDataModel.address ?? '';
                    cubit.locationLatController.text = locationDataModel.latitude.toString();
                    cubit.locationLongController.text = locationDataModel.longitude.toString();
                  }
                },
                child: CustomTextField(
                  enabled: false,
                  title: "الموقع",
                  hintText: "اضغط لتحديد موقعك",
                  controller: cubit.locationController,
                  textInputAction: TextInputAction.done,
                  suffixIcon: Icon(
                    Icons.location_on,
                    color: ColorManager.mainColor,
                    size: 25.r,
                  ).horizontalPadding(8),
                ),
              ),
              //********************* city ******************* */
              CustomDropdown(
                items: cubit.cities
                    .map(
                      (city) => DropdownMenuItem(
                        value: city,
                        child: CustomText(
                          title: city.name,
                        ),
                      ),
                    )
                    .toList(),
                title: 'المدينة',
                hintText: 'اختر المدينة',
                onChanged: (value) {
                  cubit.cityController.text = value.id.toString();
                  AppLogs.infoLog(cubit.cityController.text, 'city');
                },
              ),
              //***************** رقم الجوال ************************ */
              CustomTextField(
                title: "رقم الجوال",
                hintText: "05XXXXXXXX",
                controller: cubit.phoneNumberController,
                isNumber: true,
                type: TextInputType.number,
                validator: (text) => AppValidate.phoneValidate(text, context),
              ),
              //***** البريد الإلكتروني ******* */
              CustomTextField(
                title: "البريد الإلكتروني",
                hintText: "البريد الإلكتروني",
                controller: cubit.emailController,
                type: TextInputType.emailAddress,
                isRequired: false,
                validator: (text) => AppValidate.emailValidate(text, context),
              ),
              //***** رقم الأيبان / الحساب******* */
              // CustomTextField(
              //   title: "رقم الأيبان / الحساب",
              //   hintText: "12xxxxxxxxxxxxxxxxx",
              //   suffixText: 'SA',
              //   controller: cubit.ibanController,
              //   isNumber: true,
              //   type: TextInputType.number,
              //   isRequired: acceptSigningContract,
              //   validator: (text) => AppValidate.ibanValidate(text, context),
              // ),
              //***** اسم البنك****** */
              // CustomTextField(
              //   title: "اسم البنك",
              //   hintText: "اسم البنك",
              //   controller: cubit.bankNameController,
              //   isRequired: acceptSigningContract,
              // ),

              //******** اللوجو ****** */
              // BlocSelector<HomeCubit, HomeState, String?>(
              //   selector: (state) => state.logoImage,
              //   builder: (context, logoImage) {
              //     return UploadFileDottedBorder(
              //       onTap: () async {
              //         await cubit.pickLogoImage();
              //       },
              //       isFileLoaded: logoImage != null,
              //       title: "اللوجو",
              //       showIsRequired: acceptSigningContract && logoImage == null,
              //     );
              //   },
              // ),
              // //* ******* البروفايل ****** */
              // BlocSelector<HomeCubit, HomeState, List<String>?>(
              //   selector: (state) => state.profileFiles,
              //   builder: (context, profileFiles) {
              //     return UploadFileDottedBorder(
              //       onTap: () async {
              //         await cubit.pickProfileFiles();
              //       },
              //       isFileLoaded: profileFiles != null,
              //       title: 'البروفايل',
              //       showIsRequired: profileFiles == null,
              //     );
              //   },
              // ),
              //***** مواعيد العمل الرسمية ***** */
              // const WorkingDaysWidget(),
              // 20.verticalSpace,
              //* ******* إرفاق قائمة الخدمات و الأسعار ****** */
              // BlocSelector<HomeCubit, HomeState, String?>(
              //   selector: (state) => state.manusAndPricingFile,
              //   builder: (context, manusAndPricingFile) {
              //     return UploadFileDottedBorder(
              //       onTap: () async {
              //         await cubit.pickManusAndPricingFile();
              //       },
              //       isFileLoaded: manusAndPricingFile != null,
              //       title: 'إرفاق قائمة الخدمات و الأسعار',
              //       showIsRequired: acceptSigningContract && manusAndPricingFile == null,
              //     );
              //   },
              // ),
              //***** حسابات التواصل الإجتماعي ***** */
              // CustomTextField(
              //   title: 'حسابات التواصل الإجتماعي',
              //   hintText: 'حسابات التواصل الإجتماعي',
              //   controller: cubit.socialAccountLinkController,
              //   type: TextInputType.url,
              //   isRequired: acceptSigningContract,
              // ),

              //***** الموقع الإلكتروني ***** */
              // CustomTextField(
              //   title: 'الموقع الإلكتروني',
              //   hintText: 'الموقع الإلكتروني',
              //   controller: cubit.websiteController,
              //   type: TextInputType.url,
              //   isRequired: acceptSigningContract,
              // ),
              //***************** رقم هاتف خدمة العملاء ************************ */
              // CustomTextField(
              //   title: 'رقم هاتف خدمة العملاء',
              //   hintText: "05xxxxxxx",
              //   controller: cubit.customerServicePhoneNumberController,
              //   isNumber: true,
              //   isRequired: acceptSigningContract,
              //   type: TextInputType.number,
              //   validator: (text) => AppValidate.phoneValidate(text, context),
              // ),
              //*****  البريد الإلكتروني الخاص بخدمة العملاء******* */
              // CustomTextField(
              //   title: 'البريد الإلكتروني الخاص بخدمة العملاء',
              //   hintText: 'البريد الإلكتروني',
              //   controller: cubit.customerServiceEmailController,
              //   type: TextInputType.emailAddress,
              //   isRequired: acceptSigningContract,
              //   validator: (text) => AppValidate.emailValidate(text, context),
              // ),
              //*****  تم التسجيل بواسطة ****** */
              CustomDropdown(
                items: cubit.sellerType
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: CustomText(
                          title: type,
                        ),
                      ),
                    )
                    .toList(),
                title: 'تم التسجيل بواسطة',
                hintText: 'اختر المندوب',
                isRequiredFlag: acceptSigningContract,
                onChanged: (value) {
                  cubit.sellerRegisteredNameController.text = value;
                  AppLogs.infoLog(cubit.sellerRegisteredNameController.text, 'sellerRegisteredNameController');
                },
              ),
              //* ******* رقم جوال مسجل البائع****** */
              // CustomTextField(
              //   title: 'رقم جوال مسجل البائع',
              //   hintText: "05xxxxxxx",
              //   controller: cubit.sellerRegisteredPhoneNumberController,
              //   isNumber: true,
              //   isRequired: acceptSigningContract,
              //   type: TextInputType.number,
              //   validator: (text) => AppValidate.phoneValidate(text, context),
              // ),
              //* ******* تاريخ تسجيل البائع****** */
              GestureDetector(
                onTap: () async {
                  final date = await HelperFunctions.showDatePick(context);
                  if (date != null) {
                    cubit.sellerRegistrationDateController.text = DateFormat.yMd().format(date);
                  }
                },
                child: CustomTextField(
                  title: 'تاريخ تسجيل البائع',
                  hintText: 'تاريخ تسجيل البائع',
                  controller: cubit.sellerRegistrationDateController,
                  enabled: false,
                  isRequired: acceptSigningContract,
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: ColorManager.mainColor,
                    size: 25.r,
                  ).horizontalPadding(8),
                ),
              ),
              20.verticalSpace,
              //******** اختيار طريقة الإرسال ******* */
              if (acceptSigningContract)
                BlocSelector<HomeCubit, HomeState, bool>(
                  selector: (state) => state.sendViaEmail,
                  builder: (_, sendViaEmail) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomRadioButton(
                          onChanged: () {
                            if (sendViaEmail) return;
                            cubit.toggleSendViaEmail();
                          },
                          title: "ارسال العقد عن طريق البريد",
                          value: sendViaEmail,
                        ),
                        20.verticalSpace,
                        CustomRadioButton(
                          onChanged: () {
                            if (!sendViaEmail) return;
                            cubit.toggleSendViaEmail();
                          },
                          title: "ارسال العقد عن طريق الهاتف",
                          value: !sendViaEmail,
                        ),
                      ],
                    );
                  },
                ).horizontalPadding(10),
              20.verticalSpace,
              BlocSelector<HomeCubit, HomeState, bool>(
                selector: (state) => state.acceptSigningContract,
                builder: (context, acceptSigningContract) {
                  return BlocSelector<HomeCubit, HomeState, bool>(
                    selector: (state) => state.status == ApiStatus.loading,
                    builder: (context, loading) {
                      return CustomButton(
                        text: 'إنشاء حساب بائع',
                        loading: loading,
                        onTap: () async {
                          if (cubit.sellerDtaFormKey.currentState!.validate()) {
                            if (widget.isSalon) {
                              await cubit.createSellerSalonAccount(context);
                            } else {
                              await cubit.createSellerMakeupArtistAccount(context);
                            }
                          }
                          // if (acceptSigningContract) {
                          //   final bool ispick = cubit.addSelectedDays(context);
                          //   if (!ispick) {
                          //     return;
                          //   }
                          //   for (var i = 0; i < cubit.workingTimes.length; i++) {
                          //     AppLogs.infoLog(cubit.workingTimes[i].dayName ?? '', 'day');
                          //     AppLogs.infoLog(cubit.workingTimes[i].fromTime ?? '', 'from');
                          //     AppLogs.infoLog(cubit.workingTimes[i].toTime ?? '', 'to');
                          //   }
                          // }

                          // if (cubit.sellerDtaFormKey.currentState!.validate()
                          //&& cubit.workingDaysFormKey.currentState!.validate()
                          // ) {
                          //! check if salon
                          // if (widget.isSalon) {
                          //   await cubit.createSellerSalonAccount(context);
                          // if (acceptSigningContract) {
                          //   if (cubit.state.previousWorkFiles == null || cubit.state.manusAndPricingFile == null || cubit.state.profileFiles == null || cubit.state.logoImage == null || cubit.state.licenseImage == null) {
                          //     UIGlobal.showCustomTost(context, title: 'الرجاء إرفاق صور الصالون و أعمال سابقة و قائمة الخدمات و الأسعار');
                          //   } else {

                          //   }
                          // } else {
                          //   AppLogs.infoLog('createSellerSalonAccount', 'createSellerSalonAccount');
                          //   await cubit.createSellerSalonAccount(context);
                          // }
                          // } else {
                          //   await cubit.createSellerMakeupArtistAccount(context);
                          // if (acceptSigningContract) {
                          // if (cubit.state.previousWorkFiles == null || cubit.state.manusAndPricingFile == null || cubit.state.profileFiles == null || cubit.state.logoImage == null || cubit.state.licenseImage == null) {
                          //   UIGlobal.showCustomTost(context, title: 'الرجاء إرفاق صور الأعمال السابقة و قائمة الخدمات و الأسعار');
                          //   return;
                          // }
                          //   await cubit.createSellerMakeupArtistAccount(context);
                          // } else {
                          //   await cubit.createSellerMakeupArtistAccount(context);
                          // }
                          // }
                          // }
                        },
                      );
                    },
                  );
                },
              ),
              50.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}

//* ******* bottom sheet to pick city  ***** */

//* ******* الجنسية  ***** */
void showNationalDialog({required BuildContext context}) {
  showCountryPicker(
    context: context,
    favorite: ['SA'],
    useSafeArea: true,
    countryListTheme: CountryListThemeData(
      flagSize: 25,

      backgroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 16, color: ColorManager.mainColor),
      bottomSheetHeight: 0.8.sh,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),

      //Optional. Styles the search field.
      inputDecoration: InputDecoration(
        labelText: 'بحث',
        hintText: 'بحث',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFF8C98A8).withOpacity(0.2),
          ),
        ),
      ),
    ),
    onSelect: (Country country) {
      final HomeCubit cubit = context.read<HomeCubit>();
      cubit.nationalController.text = "${country.nameLocalized ?? ''} ${country.flagEmoji}";
      AppLogs.infoLog(cubit.nationalController.text, 'national');
    },
  );
}
