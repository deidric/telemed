import 'package:json_annotation/json_annotation.dart';

part 'ConversationModel.g.dart';

@JsonSerializable()
class ConversationModel {
  int? id;
  int? fromUserId;
  int? toUserId;
  String? message;
  String? timeOfAppointment;
  String? sentDate;
  String? readDate;
  String? attachments;
  int? fromUserTypeId;
  String? fromUserFirstName;
  String? fromUserLastName;
  String? fromUserDeviceKey;
  int? toUserTypeId;
  String? toUserFirstName;
  String? toUserLastName;
  String? toUserDeviceKey;

  ConversationModel({
    this.id,
    this.fromUserId,
    this.toUserId,
    this.message,
    this.timeOfAppointment,
    this.sentDate,
    this.readDate,
    this.attachments,
    this.fromUserTypeId,
    this.fromUserFirstName,
    this.fromUserLastName,
    this.fromUserDeviceKey,
    this.toUserTypeId,
    this.toUserFirstName,
    this.toUserLastName,
    this.toUserDeviceKey,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}

enum FieldNames {
  id,
  fromUserId,
  toUserId,
  message,
  timeOfAppointment,
  sentDate,
  readDate,
  attachments,
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
      case FieldNames.attachments:
        return 'attachments';
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
