import 'package:json_annotation/json_annotation.dart';

part 'AttachmentsModel.g.dart';

@JsonSerializable()
class AttachmentsModel {
  int? id;
  int? conversationId;
  int? fromUserId;
  int? toUserId;
  String? message;
  String? timeOfAppointment;
  String? sentDate;
  String? readDate;
  String? filePathOnServer;
  int? fromUserTypeId;
  String? fromUserFirstName;
  String? fromUserLastName;
  String? fromUserDeviceKey;
  int? toUserTypeId;
  String? toUserFirstName;
  String? toUserLastName;
  String? toUserDeviceKey;

  AttachmentsModel({
    this.id,
    this.conversationId,
    this.fromUserId,
    this.toUserId,
    this.message,
    this.timeOfAppointment,
    this.sentDate,
    this.readDate,
    this.filePathOnServer,
    this.fromUserTypeId,
    this.fromUserFirstName,
    this.fromUserLastName,
    this.fromUserDeviceKey,
    this.toUserTypeId,
    this.toUserFirstName,
    this.toUserLastName,
    this.toUserDeviceKey,
  });

  factory AttachmentsModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentsModelToJson(this);
}

enum FieldNames {
  id,
  conversationId,
  fromUserId,
  toUserId,
  message,
  timeOfAppointment,
  sentDate,
  readDate,
  filePathOnServer,
  fromUserTypeId,
  fromUserFirstName,
  fromUserLastName,
  fromUserDeviceKey,
  toUserTypeId,
  toUserFirstName,
  toUserLastName,
  toUserDeviceKey,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.id:
        return 'id';
      case FieldNames.conversationId:
        return 'conversationId';
      case FieldNames.fromUserId:
        return 'fromUserId';
      case FieldNames.toUserId:
        return 'toUserId';
      case FieldNames.message:
        return 'message';
      case FieldNames.timeOfAppointment:
        return 'timeOfAppointment';
      case FieldNames.sentDate:
        return 'sentDate';
      case FieldNames.readDate:
        return 'readDate';
      case FieldNames.filePathOnServer:
        return 'filePathOnServer';
      case FieldNames.fromUserTypeId:
        return 'fromUserTypeId';
      case FieldNames.fromUserFirstName:
        return 'fromUserFirstName';
      case FieldNames.fromUserLastName:
        return 'fromUserLastName';
      case FieldNames.fromUserDeviceKey:
        return 'fromUserDeviceKey';
      case FieldNames.toUserTypeId:
        return 'toUserTypeId';
      case FieldNames.toUserFirstName:
        return 'toUserFirstName';
      case FieldNames.toUserLastName:
        return 'toUserLastName';
      case FieldNames.toUserDeviceKey:
        return 'toUserDeviceKey';
    }
  }
}
