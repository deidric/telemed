import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel {
  int? id;
  String? name;
  int? userTypeId;
  int? cadersId;
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
    this.id,
    this.name,
    this.userTypeId,
    this.cadersId,
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
  id,
  name,
  userTypeId,
  cadersId,
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
      case FieldNames.id:
        return 'id';
      case FieldNames.name:
        return 'name';
      case FieldNames.userTypeId:
        return 'userTypeId';
      case FieldNames.cadersId:
        return 'cadersId';
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
