// // ignore_for_file: use_build_context_synchronously

// import 'dart:async';

// import 'package:beauty_solution_seller_app/features/home_feature/data/location_data_model.dart';
// import 'package:beauty_solution_seller_app/resource/color_manager.dart';
// import 'package:beauty_solution_seller_app/widgets/custom_app_bar.dart';
// import 'package:beauty_solution_seller_app/widgets/custom_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geocoding/geocoding.dart';

// class PickLocation extends StatefulWidget {
//   const PickLocation({super.key});

//   @override
//   State<StatefulWidget> createState() => _PickLocationState();
// }

// class _PickLocationState extends State<PickLocation> {
//   late TextEditingController textEditingController = TextEditingController();
//   late PickerMapController controller = PickerMapController(
//     initMapWithUserPosition: const UserTrackingOption(),
//     //initPosition: GeoPoint(latitude: 24.7494, longitude: 46.9028),
//   );

//   @override
//   void initState() {
//     super.initState();
//     textEditingController.addListener(textOnChanged);
//   }

//   void textOnChanged() {
//     controller.setSearchableText(textEditingController.text);
//   }

//   @override
//   void dispose() {
//     textEditingController.removeListener(textOnChanged);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: 'اختر الموقع',
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: CustomPickerLocation(
//               controller: controller,
//               topWidgetPicker: Padding(
//                 padding: const EdgeInsets.only(
//                   top: 8,
//                   left: 8,
//                   right: 8,
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: textEditingController,
//                             onEditingComplete: () async {
//                               FocusScope.of(context).requestFocus(FocusNode());
//                             },
//                             cursorColor: Colors.black,
//                             decoration: InputDecoration(
//                               prefixIcon: const Icon(
//                                 Icons.search,
//                                 color: Colors.black,
//                               ),
//                               suffix: ValueListenableBuilder<TextEditingValue>(
//                                 valueListenable: textEditingController,
//                                 builder: (ctx, text, child) {
//                                   if (text.text.isNotEmpty) {
//                                     return child!;
//                                   }
//                                   return const SizedBox.shrink();
//                                 },
//                                 child: InkWell(
//                                   focusNode: FocusNode(),
//                                   onTap: () {
//                                     textEditingController.clear();
//                                     controller.setSearchableText("");
//                                     FocusScope.of(context).requestFocus(FocusNode());
//                                   },
//                                   child: const Icon(
//                                     Icons.close,
//                                     size: 16,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                               focusColor: Colors.black,
//                               filled: true,
//                               hintText: 'بحث',
//                               border: InputBorder.none,
//                               enabledBorder: InputBorder.none,
//                               fillColor: Colors.white,
//                               errorBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const TopSearchWidget()
//                   ],
//                 ),
//               ),
//               bottomWidgetPicker: Positioned(
//                 bottom: 12.h,
//                 right: 50.w,
//                 left: 50.w,
//                 child: CustomButton(
//                   onTap: () async {
//                     GeoPoint p = await controller.selectAdvancedPositionPicker();
//                     List<Placemark> locationPlacemarks = await placemarkFromCoordinates(p.latitude, p.longitude);
//                     LocationDataModel locationDataModel = LocationDataModel(
//                       "${locationPlacemarks.first.locality ?? locationPlacemarks.first.subLocality ?? locationPlacemarks.first.thoroughfare}, ${locationPlacemarks.first.administrativeArea}, ${locationPlacemarks.first.country}",
//                       p.latitude,
//                       p.longitude,
//                     );
//                     Navigator.pop(context, locationDataModel);
//                   },
//                   text: 'اختيار هذا الموقع',
//                 ),
//               ),
//               //showDefaultMarkerPickWidget: true,
//               pickerConfig: const CustomPickerLocationConfig(
//                 loadingWidget: Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.black,
//                   ),
//                 ),
//                 advancedMarkerPicker: MarkerIcon(
//                   iconWidget: Icon(
//                     Icons.location_on,
//                     color: Colors.red,
//                     size: 40,
//                   ),
//                 ),
//                 zoomOption: ZoomOption(
//                   initZoom: 10,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TopSearchWidget extends StatefulWidget {
//   const TopSearchWidget({super.key});

//   @override
//   State<StatefulWidget> createState() => _TopSearchWidgetState();
// }

// class _TopSearchWidgetState extends State<TopSearchWidget> {
//   late PickerMapController controller;
//   ValueNotifier<GeoPoint?> notifierGeoPoint = ValueNotifier(null);
//   ValueNotifier<bool> notifierAutoCompletion = ValueNotifier(false);

//   late StreamController<List<SearchInfo>> streamSuggestion = StreamController();
//   late Future<List<SearchInfo>> _futureSuggestionAddress;
//   String oldText = "";
//   Timer? _timerToStartSuggestionReq;
//   final Key streamKey = const Key("streamAddressSug");

//   @override
//   void initState() {
//     super.initState();
//     controller = CustomPickerLocation.of(context);
//     controller.searchableText.addListener(onSearchableTextChanged);
//   }

//   void onSearchableTextChanged() async {
//     final v = controller.searchableText.value;
//     if (v.length > 3 && oldText != v) {
//       oldText = v;
//       if (_timerToStartSuggestionReq != null && _timerToStartSuggestionReq!.isActive) {
//         _timerToStartSuggestionReq!.cancel();
//       }
//       _timerToStartSuggestionReq = Timer.periodic(const Duration(seconds: 3), (timer) async {
//         await suggestionProcessing(v);
//         timer.cancel();
//       });
//     }
//     if (v.isEmpty) {
//       await reInitStream();
//     }
//   }

//   Future reInitStream() async {
//     notifierAutoCompletion.value = false;
//     await streamSuggestion.close();
//     setState(() {
//       streamSuggestion = StreamController();
//     });
//   }

//   Future<void> suggestionProcessing(String addr) async {
//     notifierAutoCompletion.value = true;
//     _futureSuggestionAddress = addressSuggestion(
//       addr,
//       limitInformation: 5,
//     );
//     _futureSuggestionAddress.then((value) {
//       streamSuggestion.sink.add(value);
//     });
//   }

//   @override
//   void dispose() {
//     controller.searchableText.removeListener(onSearchableTextChanged);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: notifierAutoCompletion,
//       builder: (ctx, isVisible, child) {
//         return AnimatedContainer(
//           duration: const Duration(
//             milliseconds: 300,
//           ),
//           height: isVisible ? MediaQuery.of(context).size.height / 4 : 0,
//           child: Card(
//             color: ColorManager.neutral200,
//             child: child!,
//           ),
//         );
//       },
//       child: StreamBuilder<List<SearchInfo>>(
//         stream: streamSuggestion.stream,
//         key: streamKey,
//         builder: (ctx, snap) {
//           if (snap.hasData) {
//             return ListView.builder(
//               itemExtent: 50.0,
//               itemBuilder: (ctx, index) {
//                 return Container(
//                   color: Colors.white,
//                   child: ListTile(
//                     title: Text(
//                       snap.data![index].address.toString(),
//                       maxLines: 1,
//                       overflow: TextOverflow.fade,
//                     ),
//                     onTap: () async {
//                       /// go to location selected by address
//                       controller.goToLocation(
//                         snap.data![index].point!,
//                       );

//                       /// hide suggestion card
//                       notifierAutoCompletion.value = false;
//                       await reInitStream();
//                       FocusScope.of(context).requestFocus(
//                         FocusNode(),
//                       );
//                     },
//                   ),
//                 );
//               },
//               itemCount: snap.data!.length,
//             );
//           }
//           if (snap.connectionState == ConnectionState.waiting) {
//             return const Card(
//               child: Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.black,
//                 ),
//               ),
//             );
//           }
//           return const Card(
//             child: Center(
//               child: CircularProgressIndicator(
//                 color: Colors.black,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:beauty_solution_seller_app/features/home_feature/data/location_data_model.dart';
import 'package:beauty_solution_seller_app/resource/color_manager.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/app_logs.dart';
import 'package:beauty_solution_seller_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({super.key});

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'اختر الموقع',
        ),
        body: OpenStreetMapSearchAndPick(
          zoomInIcon: Icons.add,
          zoomOutIcon: Icons.remove,
          buttonTextStyle: const TextStyle(fontSize: 18, fontStyle: FontStyle.normal, color: ColorManager.neutralWhite),
          buttonColor: ColorManager.mainColor50,
          buttonText: 'Set Current Location',
          onPicked: (pickedData) {
            AppLogs.debugLog(pickedData.latLong.latitude.toString());
            AppLogs.debugLog(pickedData.latLong.longitude.toString());
            AppLogs.debugLog(pickedData.address.toString());
            AppLogs.debugLog(pickedData.addressName);

            LocationDataModel locationDataModel = LocationDataModel(
              pickedData.addressName,
              pickedData.latLong.latitude,
              pickedData.latLong.longitude,
            );
            Navigator.pop(context, locationDataModel);
          },
        ));
  }
}
