import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel {
  String? name;
  String? userTypeId;
  String? email;
  String? password;
  String? token;
  String? firstName;
  String? lastName;
  String? address;
  String? dob;
  String? bloodPressure;
  String? bloodType;
  String? gender;
  String? phone;

  UserModel({
    this.name,
    this.userTypeId,
    this.email,
    this.password,
    this.token,
    this.firstName,
    this.lastName,
    this.address,
    this.dob,
    this.bloodPressure,
    this.bloodType,
    this.gender,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

enum FieldNames {
  name,
  userTypeId,
  email,
  password,
  token,
  firstName,
  lastName,
  address,
  dob,
  bloodPressure,
  bloodType,
  gender,
  phone,
}

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
      case FieldNames.firstName:
        return 'firstName';
      case FieldNames.lastName:
        return 'lastName';
      case FieldNames.address:
        return 'address';
      case FieldNames.dob:
        return 'dob';
      case FieldNames.bloodPressure:
        return 'bloodPressure';
      case FieldNames.bloodType:
        return 'bloodType';
      case FieldNames.gender:
        return 'gender';
      case FieldNames.phone:
        return 'phone';
    }
  }
}
