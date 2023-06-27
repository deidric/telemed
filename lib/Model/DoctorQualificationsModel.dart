import 'package:json_annotation/json_annotation.dart';

part 'DoctorQualificationsModel.g.dart';

@JsonSerializable()
class DoctorQualificationsModel {
  int? id;
  String? qualification;

  DoctorQualificationsModel({
    this.id,
    this.qualification,
  });

  factory DoctorQualificationsModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorQualificationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorQualificationsModelToJson(this);
}

enum FieldNames {
  id,
  qualification,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.id:
        return 'id';
      case FieldNames.qualification:
        return 'qualification';
    }
  }
}
