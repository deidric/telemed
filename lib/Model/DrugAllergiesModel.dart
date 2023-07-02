import 'package:json_annotation/json_annotation.dart';

part 'DrugAllergiesModel.g.dart';

@JsonSerializable()
class DrugAllergiesModel {
  int? id;
  String? drugName;
  bool? isSelected;

  DrugAllergiesModel({
    this.id,
    this.drugName,
    this.isSelected,
  });

  factory DrugAllergiesModel.fromJson(Map<String, dynamic> json) =>
      _$DrugAllergiesModelFromJson(json);

  Map<String, dynamic> toJson() => _$DrugAllergiesModelToJson(this);
}

enum FieldNames {
  id,
  drugName,
  isSelected,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.id:
        return 'id';
      case FieldNames.drugName:
        return 'drugName';
      case FieldNames.isSelected:
        return 'isSelected';
    }
  }
}
