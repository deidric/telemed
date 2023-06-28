import 'package:json_annotation/json_annotation.dart';

part 'DoctorSpecialitiesModel.g.dart';

@JsonSerializable()
class DoctorSpecialitiesModel {
  int? id;
  String? speciality;

  DoctorSpecialitiesModel({
    this.id,
    this.speciality,
  });

  factory DoctorSpecialitiesModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorSpecialitiesModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorSpecialitiesModelToJson(this);
}

enum FieldNames {
  id,
  speciality,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.id:
        return 'id';
      case FieldNames.speciality:
        return 'speciality';
    }
  }
}
