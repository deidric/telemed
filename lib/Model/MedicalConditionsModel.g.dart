// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MedicalConditionsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalConditionsModel _$MedicalConditionsModelFromJson(
        Map<String, dynamic> json) =>
    MedicalConditionsModel(
      id: json['id'] as int?,
      medicalCondition: json['medicalCondition'] as String?,
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$MedicalConditionsModelToJson(
        MedicalConditionsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'medicalCondition': instance.medicalCondition,
      'isSelected': instance.isSelected,
    };
