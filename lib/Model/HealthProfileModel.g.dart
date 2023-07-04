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
      medications: json['medications'] as String?,
      allergicToDrugsComplaint: json['allergicToDrugsComplaint'] as String?,
      medicalConditionComplaint: json['medicalConditionComplaint'] as String?,
      familyMedicalConditionComplaint:
          json['familyMedicalConditionComplaint'] as String?,
      surgeryComplaint: json['surgeryComplaint'] as String?,
      symptomsModelList: (json['symptomsModelList'] as List<dynamic>?)
          ?.map((e) => SymptomsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      drugAllergiesModelList: (json['drugAllergiesModelList'] as List<dynamic>?)
          ?.map((e) => DrugAllergiesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      medicalConditionsModelList: (json['medicalConditionsModelList']
              as List<dynamic>?)
          ?.map(
              (e) => MedicalConditionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      surgeriesModelList: (json['surgeriesModelList'] as List<dynamic>?)
          ?.map((e) => SurgeriesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      famMedicalConditionsModelList: (json['famMedicalConditionsModelList']
              as List<dynamic>?)
          ?.map(
              (e) => MedicalConditionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HealthProfileModelToJson(HealthProfileModel instance) =>
    <String, dynamic>{
      'lengthOfFeeling': instance.lengthOfFeeling,
      'patientId': instance.patientId,
      'caderId': instance.caderId,
      'medications': instance.medications,
      'allergicToDrugsComplaint': instance.allergicToDrugsComplaint,
      'medicalConditionComplaint': instance.medicalConditionComplaint,
      'familyMedicalConditionComplaint':
          instance.familyMedicalConditionComplaint,
      'surgeryComplaint': instance.surgeryComplaint,
      'symptomsModelList': instance.symptomsModelList,
      'drugAllergiesModelList': instance.drugAllergiesModelList,
      'medicalConditionsModelList': instance.medicalConditionsModelList,
      'famMedicalConditionsModelList': instance.famMedicalConditionsModelList,
      'surgeriesModelList': instance.surgeriesModelList,
    };
