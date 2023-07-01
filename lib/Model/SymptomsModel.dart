import 'package:json_annotation/json_annotation.dart';

part 'SymptomsModel.g.dart';

@JsonSerializable()
class SymptomsModel {
  int? id;
  String? symptom;

  SymptomsModel({
    this.id,
    this.symptom,
  });

  factory SymptomsModel.fromJson(Map<String, dynamic> json) =>
      _$SymptomsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SymptomsModelToJson(this);
}

enum FieldNames {
  id,
  symptom,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.id:
        return 'id';
      case FieldNames.symptom:
        return 'symptom';
    }
  }
}
