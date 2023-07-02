import 'package:json_annotation/json_annotation.dart';

part 'SymptomsModel.g.dart';

@JsonSerializable()
class SymptomsModel {
  int? id;
  String? symptom;
  bool? isSelected;

  SymptomsModel({
    this.id,
    this.symptom,
    required this.isSelected,
  });

  factory SymptomsModel.fromJson(Map<String, dynamic> json) =>
      _$SymptomsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SymptomsModelToJson(this);
}

enum FieldNames {
  id,
  symptom,
  isSelected,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.id:
        return 'id';
      case FieldNames.symptom:
        return 'symptom';
      case FieldNames.isSelected:
        return 'isSelected';
    }
  }
}
