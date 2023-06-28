import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel {
  int? id;
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
  int? qualificationId;
  int? specialityId;
  String? phone;
  String? medicalSchoolOfGraduation;
  bool? boardCertified;
  String? pdeaRegistrationNumber;
  String? currentMedicalLicenseNumber;
  String? currentMedicalLicenseNumberDateIssued;

  UserModel({
    this.id,
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
    this.qualificationId,
    this.specialityId,
    this.phone,
    this.medicalSchoolOfGraduation,
    this.boardCertified,
    this.pdeaRegistrationNumber,
    this.currentMedicalLicenseNumber,
    this.currentMedicalLicenseNumberDateIssued,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

enum FieldNames {
  id,
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
  qualificationId,
  specialityId,
  phone,
  medicalSchoolOfGraduation,
  boardCertified,
  pdeaRegistrationNumber,
  currentMedicalLicenseNumber,
  currentMedicalLicenseNumberDateIssued,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.id:
        return 'id';
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
      case FieldNames.qualificationId:
        return 'qualificationId';
      case FieldNames.specialityId:
        return 'specialityId';
      case FieldNames.phone:
        return 'phone';
      case FieldNames.medicalSchoolOfGraduation:
        return 'medicalSchoolOfGraduation';
      case FieldNames.boardCertified:
        return 'boardCertified';
      case FieldNames.pdeaRegistrationNumber:
        return 'pdeaRegistrationNumber';
      case FieldNames.currentMedicalLicenseNumber:
        return 'currentMedicalLicenseNumber';
      case FieldNames.currentMedicalLicenseNumberDateIssued:
        return 'currentMedicalLicenseNumberDateIssued';
    }
  }
}
