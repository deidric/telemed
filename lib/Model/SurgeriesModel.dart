import 'package:json_annotation/json_annotation.dart';

part 'SurgeriesModel.g.dart';

@JsonSerializable()
class SurgeriesModel {
  int? id;
  String? surgeryName;
  bool? isSelected;

  SurgeriesModel({
    this.id,
    this.surgeryName,
    this.isSelected,
  });

  factory SurgeriesModel.fromJson(Map<String, dynamic> json) =>
      _$SurgeriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurgeriesModelToJson(this);
}

enum FieldNames {
  id,
  surgeryName,
  isSelected,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.id:
        return 'id';
      case FieldNames.surgeryName:
        return 'surgeryName';
      case FieldNames.isSelected:
        return 'isSelected';
    }
  }
}
