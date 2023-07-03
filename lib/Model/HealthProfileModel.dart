import 'package:json_annotation/json_annotation.dart';

part 'HealthProfileModel.g.dart';

@JsonSerializable()
class HealthProfileModel {
  int? id;
  String? cader;
  String? caderDescription;

  HealthProfileModel({
    this.id,
    this.cader,
    this.caderDescription,
  });

  factory HealthProfileModel.fromJson(Map<String, dynamic> json) =>
      _$HealthProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$HealthProfileModelToJson(this);
}

enum FieldNames {
  id,
  cader,
  caderDescription,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.id:
        return 'id';
      case FieldNames.cader:
        return 'cader';
      case FieldNames.caderDescription:
        return 'caderDescription';
    }
  }
}
