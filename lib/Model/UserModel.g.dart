// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int?,
      userTypeId: json['userTypeId'] as int?,
      cadersId: json['cadersId'] as int?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      token: json['token'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      address: json['address'] as String?,
      dob: json['dob'] as String?,
      bloodPressure: json['bloodPressure'] as String?,
      bloodType: json['bloodType'] as String?,
      gender: json['gender'] as String?,
      qualificationId: json['qualificationId'] as int?,
      specialityId: json['specialityId'] as int?,
      phone: json['phone'] as String?,
      videoConsultationFee: json['videoConsultationFee'] as String?,
      medicalSchoolOfGraduation: json['medicalSchoolOfGraduation'] as String?,
      boardCertified: json['boardCertified'] as int?,
      pdeaRegistrationNumber: json['pdeaRegistrationNumber'] as String?,
      currentMedicalLicenseNumber:
          json['currentMedicalLicenseNumber'] as String?,
      currentMedicalLicenseNumberDateIssued:
          json['currentMedicalLicenseNumberDateIssued'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'userTypeId': instance.userTypeId,
      'cadersId': instance.cadersId,
      'email': instance.email,
      'password': instance.password,
      'token': instance.token,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'dob': instance.dob,
      'bloodPressure': instance.bloodPressure,
      'bloodType': instance.bloodType,
      'gender': instance.gender,
      'qualificationId': instance.qualificationId,
      'specialityId': instance.specialityId,
      'phone': instance.phone,
      'videoConsultationFee': instance.videoConsultationFee,
      'medicalSchoolOfGraduation': instance.medicalSchoolOfGraduation,
      'boardCertified': instance.boardCertified,
      'pdeaRegistrationNumber': instance.pdeaRegistrationNumber,
      'currentMedicalLicenseNumber': instance.currentMedicalLicenseNumber,
      'currentMedicalLicenseNumberDateIssued':
          instance.currentMedicalLicenseNumberDateIssued,
    };
