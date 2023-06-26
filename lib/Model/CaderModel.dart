import 'package:json_annotation/json_annotation.dart';

part 'CaderModel.g.dart';

@JsonSerializable()
class CaderModel {
  int? id;
  String? cader;
  String? caderDescription;

  CaderModel({
    this.id,
    this.cader,
    this.caderDescription,
  });

  factory CaderModel.fromJson(Map<String, dynamic> json) =>
      _$CaderModelFromJson(json);

  Map<String, dynamic> toJson() => _$CaderModelToJson(this);
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
