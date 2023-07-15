// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: json['id'] as int?,
      conversationId: json['conversationId'] as String?,
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
      toUserTypeId: json['toUserTypeId'] as int?,
      toUserFirstName: json['toUserFirstName'] as String?,
      toUserLastName: json['toUserLastName'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
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
      'toUserTypeId': instance.toUserTypeId,
      'toUserFirstName': instance.toUserFirstName,
      'toUserLastName': instance.toUserLastName,
    };
