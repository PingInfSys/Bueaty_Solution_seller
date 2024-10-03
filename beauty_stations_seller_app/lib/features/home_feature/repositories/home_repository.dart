// lib/repository/home_repository.dart

import 'package:beauty_solution_seller_app/services/api/api_response.dart';
import 'package:beauty_solution_seller_app/services/api/dio_consumer.dart';
import 'package:beauty_solution_seller_app/services/api/end_points.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  //*************** post createSellerSalonAccount from api *****************/
  Future<ApiResponseModel> createSellerSalonAccount(FormData body) async {
    return DioConsumer().postRequest(
      EndPoints.createSellerSalonAccount,
      body: body,
    );
  }

  //*************** post createSellerMakeupArtistAccount from api *****************/
  Future<ApiResponseModel> createSellerMakeupArtistAccount(FormData body) async {
    return DioConsumer().postRequest(
      EndPoints.createSellerMakeupArtistAccount,
      body: body,
    );
  }
}
