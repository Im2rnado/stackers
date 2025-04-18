import 'package:flutter/material.dart';
import 'package:stackers/data/datasource/remote/dio/dio_client.dart';
import 'package:stackers/data/datasource/remote/exception/api_error_handler.dart';
import 'package:stackers/data/model/body/MessageBody.dart';
import 'package:stackers/data/model/response/base/api_response.dart';
import 'package:stackers/utill/app_constants.dart';

class ChatRepo {
  final DioClient dioClient;
  ChatRepo({@required this.dioClient});



  Future<ApiResponse> getChatList(String type, int offset) async {
    try {
      final response = await dioClient.get('${AppConstants.CHAT_INFO_URI}$type?limit=30&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getMessageList(String type, int id, offset) async {
    try {
      final response = await dioClient.get('${AppConstants.MESSAGES_URI}$type/$id?limit=30&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> sendMessage(MessageBody messageBody, String type) async {
    try {
      final response = await dioClient.post('${AppConstants.SEND_MESSAGE_URI}$type', data: messageBody.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}