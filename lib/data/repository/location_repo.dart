import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stackers/data/datasource/remote/dio/dio_client.dart';
import 'package:stackers/data/datasource/remote/exception/api_error_handler.dart';
import 'package:stackers/data/model/response/address_model.dart';
import 'package:stackers/data/model/response/base/api_response.dart';
import 'package:stackers/utill/app_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocationRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({this.dioClient, this.sharedPreferences});

  Future<ApiResponse> getAllAddress() async {
    try {
      final response = await dioClient.get(AppConstants.ADDRESS_LIST_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getDeliveryRestrictedCountryList() async {
    try {
      final response = await dioClient.get(AppConstants.DELIVERY_RESTRICTED_COUNTY_LIST);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDeliveryRestrictedZipList() async {
    try {
      final response = await dioClient.get(AppConstants.DELIVERY_RESTRICTED_ZIP_LIST);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDeliveryRestrictedZipBySearch(String zipcode) async {
    try {
      final response = await dioClient.get('${AppConstants.DELIVERY_RESTRICTED_ZIP_LIST}?search=$zipcode');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDeliveryRestrictedCountryBySearch(String country) async {
    try {
      final response = await dioClient.get('${AppConstants.DELIVERY_RESTRICTED_COUNTY_LIST}?search=$country');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> removeAddressByID(int id) async {
    try {
      final response = await dioClient.post('${AppConstants.REMOVE_ADDRESS_URI}$id', data: {"_method": "delete"});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> addAddress(AddressModel addressModel) async {
    print('====Add Address==>${addressModel.toJson()}');
    try {
      Response response = await dioClient.post(
        AppConstants.ADD_ADDRESS_URI,
        data: addressModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateAddress(AddressModel addressModel, int addressId) async {
    try {
      Response response = await dioClient.post(
        '${AppConstants.UPDATE_ADDRESS_URI}$addressId',
        data: addressModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  List<String> getAllAddressType({BuildContext context}) {
    return [
      'Home',
      'Workplace',
      'Other',
    ];
  }

  Future<ApiResponse> getAddressFromGeocode(LatLng latLng) async {
    try {
      Response response = await dioClient.get('${AppConstants.GEOCODE_URI}?lat=${latLng.latitude}&lng=${latLng.longitude}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> searchLocation(String text) async {
    try {
      Response response = await dioClient.get('${AppConstants.SEARCH_LOCATION_URI}?search_text=$text');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getPlaceDetails(String placeID) async {
    try {
      Response response = await dioClient.get('${AppConstants.PLACE_DETAILS_URI}?placeid=$placeID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDistanceInMeter(LatLng originLatLng, LatLng destinationLatLng) async {
    try {
      Response response = await dioClient.get('${AppConstants.DISTANCE_MATRIX_URI}'
          '?origin_lat=${originLatLng.latitude}&origin_lng=${originLatLng.longitude}'
          '&destination_lat=${destinationLatLng.latitude}&destination_lng=${destinationLatLng.longitude}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
