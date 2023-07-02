import 'package:json_annotation/json_annotation.dart';

part 'MedicalConditionsModel.g.dart';

@JsonSerializable()
class MedicalConditionsModel {
  int? id;
  String? medicalCondition;
  bool? isSelected;

  MedicalConditionsModel({
    this.id,
    this.medicalCondition,
    this.isSelected,
  });

  factory MedicalConditionsModel.fromJson(Map<String, dynamic> json) =>
      _$MedicalConditionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalConditionsModelToJson(this);
}

enum FieldNames {
  id,
  medicalCondition,
  isSelected,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.id:
        return 'id';
      case FieldNames.medicalCondition:
        return 'medicalCondition';
      case FieldNames.isSelected:
        return 'isSelected';
    }
  }
}
