import 'package:json_annotation/json_annotation.dart';

part 'ConversationModel.g.dart';

@JsonSerializable()
class ConversationModel {
  int? id;
  int? conversationId;
  int? fromUserId;
  int? toUserId;
  String? message;
  String? timeOfAppointment;
  String? sentDate;
  String? readDate;
  String? attachments;
  String? fromUserFirstName;
  String? fromUserLastName;
  String? toUserFirstName;
  String? toUserLastName;

  ConversationModel({
    this.id,
    this.conversationId,
    this.fromUserId,
    this.toUserId,
    this.message,
    this.timeOfAppointment,
    this.sentDate,
    this.readDate,
    this.attachments,
    this.fromUserFirstName,
    this.fromUserLastName,
    this.toUserFirstName,
    this.toUserLastName,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
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
  attachments,
  fromUserFirstName,
  fromUserLastName,
  toUserFirstName,
  toUserLastName,
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
      case FieldNames.attachments:
        return 'attachments';
      case FieldNames.fromUserFirstName:
        return 'fromUserFirstName';
      case FieldNames.fromUserLastName:
        return 'fromUserLastName';
      case FieldNames.toUserFirstName:
        return 'toUserFirstName';
      case FieldNames.toUserLastName:
        return 'toUserLastName';
    }
  }
}
