// lib/states/home_state.dart
import 'package:beauty_solution_seller_app/resource/enums_manager.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(true) bool isSalon,
    @Default(true) bool sendViaEmail,
    @Default(true) bool allDays,
    @Default(false) bool acceptSigningContract,
    @Default(null) String? licenseImage,
    @Default(null) List<String>? previousWorkFiles,
    @Default(null) double? locationLat,
    @Default(null) double? locationLong,
    @Default(null) String? logoImage,
    @Default(null) List<String>? profileFiles,
    @Default(null) String? manusAndPricingFile,
    @Default(null) String? makeupArtistPhoto,
    @Default(ApiStatus.idle) ApiStatus status,
    String? errorMessage,
  }) = _HomeState;
}
