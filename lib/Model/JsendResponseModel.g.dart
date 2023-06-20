// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JsendResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsendResponseModel _$JsendResponseModelFromJson(Map<String, dynamic> json) =>
    JsendResponseModel(
      status: json['status'] as String,
      data: json['data'],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$JsendResponseModelToJson(JsendResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
