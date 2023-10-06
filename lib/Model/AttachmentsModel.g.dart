// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AttachmentsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentsModel _$AttachmentsModelFromJson(Map<String, dynamic> json) =>
    AttachmentsModel(
      id: json['id'] as int?,
      conversationId: json['conversationId'] as int?,
      fromUserId: json['fromUserId'] as int?,
      toUserId: json['toUserId'] as int?,
      message: json['message'] as String?,
      timeOfAppointment: json['timeOfAppointment'] as String?,
      sentDate: json['sentDate'] as String?,
      readDate: json['readDate'] as String?,
      filePathOnServer: json['filePathOnServer'] as String?,
      fromUserTypeId: json['fromUserTypeId'] as int?,
      fromUserFirstName: json['fromUserFirstName'] as String?,
      fromUserLastName: json['fromUserLastName'] as String?,
      fromUserDeviceKey: json['fromUserDeviceKey'] as String?,
      toUserTypeId: json['toUserTypeId'] as int?,
      toUserFirstName: json['toUserFirstName'] as String?,
      toUserLastName: json['toUserLastName'] as String?,
      toUserDeviceKey: json['toUserDeviceKey'] as String?,
    );

Map<String, dynamic> _$AttachmentsModelToJson(AttachmentsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'fromUserId': instance.fromUserId,
      'toUserId': instance.toUserId,
      'message': instance.message,
      'timeOfAppointment': instance.timeOfAppointment,
      'sentDate': instance.sentDate,
      'readDate': instance.readDate,
      'filePathOnServer': instance.filePathOnServer,
      'fromUserTypeId': instance.fromUserTypeId,
      'fromUserFirstName': instance.fromUserFirstName,
      'fromUserLastName': instance.fromUserLastName,
      'fromUserDeviceKey': instance.fromUserDeviceKey,
      'toUserTypeId': instance.toUserTypeId,
      'toUserFirstName': instance.toUserFirstName,
      'toUserLastName': instance.toUserLastName,
      'toUserDeviceKey': instance.toUserDeviceKey,
    };
