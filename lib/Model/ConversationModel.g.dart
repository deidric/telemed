// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ConversationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    ConversationModel(
      id: json['id'] as int?,
      fromUserId: json['fromUserId'] as int?,
      toUserId: json['toUserId'] as int?,
      message: json['message'] as String?,
      timeOfAppointment: json['timeOfAppointment'] as String?,
      sentDate: json['sentDate'] as String?,
      readDate: json['readDate'] as String?,
      attachments: json['attachments'] as String?,
      fromUserTypeId: json['fromUserTypeId'] as int?,
      fromUserFirstName: json['fromUserFirstName'] as String?,
      fromUserLastName: json['fromUserLastName'] as String?,
      fromUserDeviceKey: json['fromUserDeviceKey'] as String?,
      toUserTypeId: json['toUserTypeId'] as int?,
      toUserFirstName: json['toUserFirstName'] as String?,
      toUserLastName: json['toUserLastName'] as String?,
      toUserDeviceKey: json['toUserDeviceKey'] as String?,
    );

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fromUserId': instance.fromUserId,
      'toUserId': instance.toUserId,
      'message': instance.message,
      'timeOfAppointment': instance.timeOfAppointment,
      'sentDate': instance.sentDate,
      'readDate': instance.readDate,
      'attachments': instance.attachments,
      'fromUserTypeId': instance.fromUserTypeId,
      'fromUserFirstName': instance.fromUserFirstName,
      'fromUserLastName': instance.fromUserLastName,
      'fromUserDeviceKey': instance.fromUserDeviceKey,
      'toUserTypeId': instance.toUserTypeId,
      'toUserFirstName': instance.toUserFirstName,
      'toUserLastName': instance.toUserLastName,
      'toUserDeviceKey': instance.toUserDeviceKey,
    };
