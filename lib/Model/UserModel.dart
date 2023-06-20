import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel {
  String? name;
  String? userTypeId;
  String? email;
  String? password;
  String? token;

  UserModel({
    this.name,
    this.userTypeId,
    this.email,
    this.password,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

enum FieldNames { name, userTypeId, email, password, token }

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.name:
        return 'name';
      case FieldNames.userTypeId:
        return 'userTypeId';
      case FieldNames.email:
        return 'email';
      case FieldNames.password:
        return 'password';
      case FieldNames.token:
        return 'token';
    }
  }
}
