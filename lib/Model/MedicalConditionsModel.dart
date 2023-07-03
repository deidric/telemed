import 'package:json_annotation/json_annotation.dart';

part 'MedicalConditionsModel.g.dart';

@JsonSerializable()
class MedicalConditionsModel {
  int? id;
  String? medicalCondition;

  MedicalConditionsModel({
    this.id,
    this.medicalCondition,
  });

  factory MedicalConditionsModel.fromJson(Map<String, dynamic> json) =>
      _$MedicalConditionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalConditionsModelToJson(this);
}

enum FieldNames {
  id,
  medicalCondition,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.id:
        return 'id';
      case FieldNames.medicalCondition:
        return 'medicalCondition';
    }
  }
}
