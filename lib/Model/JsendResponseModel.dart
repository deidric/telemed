import 'package:json_annotation/json_annotation.dart';

part 'JsendResponseModel.g.dart';
@JsonSerializable()
class JsendResponseModel {
  String status;
  dynamic data;
  String? message;

  JsendResponseModel(
      {required this.status, required this.data, required this.message});

  factory JsendResponseModel.fromJson(Map<String, dynamic> json) =>
      _$JsendResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$JsendResponseModelToJson(this);
}

enum FieldNames { status, data, message }

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.status:
        return 'status';
      case FieldNames.data:
        return 'data';
      case FieldNames.message:
        return 'message';
    }
  }
}
