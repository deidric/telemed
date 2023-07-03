// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HealthProfileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthProfileModel _$HealthProfileModelFromJson(Map<String, dynamic> json) =>
    HealthProfileModel(
      lengthOfFeeling: json['lengthOfFeeling'] as String?,
      patientId: json['patientId'] as int?,
      caderId: json['caderId'] as int?,
      dateOfAppointment: json['dateOfAppointment'] as String?,
      timeOfAppointment: json['timeOfAppointment'] as String?,
      allergicToDrugsComplaint: json['allergicToDrugsComplaint'] as String?,
      medicalConditionComplaint: json['medicalConditionComplaint'] as String?,
      surgeryComplaint: json['surgeryComplaint'] as String?,
      pwdNumber: json['pwdNumber'] as int?,
      paymentReferenceNumber: json['paymentReferenceNumber'] as int?,
      symptomsModel: (json['symptomsModel'] as List<dynamic>?)
          ?.map((e) => SymptomsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      drugAllergiesModel: (json['drugAllergiesModel'] as List<dynamic>?)
          ?.map((e) => DrugAllergiesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      medicalConditionsModel: (json['medicalConditionsModel'] as List<dynamic>?)
          ?.map(
              (e) => MedicalConditionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      surgeriesModel: (json['surgeriesModel'] as List<dynamic>?)
          ?.map((e) => SurgeriesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HealthProfileModelToJson(HealthProfileModel instance) =>
    <String, dynamic>{
      'lengthOfFeeling': instance.lengthOfFeeling,
      'patientId': instance.patientId,
      'caderId': instance.caderId,
      'dateOfAppointment': instance.dateOfAppointment,
      'timeOfAppointment': instance.timeOfAppointment,
      'allergicToDrugsComplaint': instance.allergicToDrugsComplaint,
      'medicalConditionComplaint': instance.medicalConditionComplaint,
      'surgeryComplaint': instance.surgeryComplaint,
      'pwdNumber': instance.pwdNumber,
      'paymentReferenceNumber': instance.paymentReferenceNumber,
      'symptomsModel': instance.symptomsModel,
      'drugAllergiesModel': instance.drugAllergiesModel,
      'medicalConditionsModel': instance.medicalConditionsModel,
      'surgeriesModel': instance.surgeriesModel,
    };
