// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String?,
      userTypeId: json['userTypeId'] as String?,
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
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'userTypeId': instance.userTypeId,
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
      'phone': instance.phone,
    };
