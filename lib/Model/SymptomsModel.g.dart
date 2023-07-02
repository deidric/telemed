// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SymptomsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SymptomsModel _$SymptomsModelFromJson(Map<String, dynamic> json) =>
    SymptomsModel(
      id: json['id'] as int?,
      symptom: json['symptom'] as String?,
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$SymptomsModelToJson(SymptomsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symptom': instance.symptom,
      'isSelected': instance.isSelected,
    };
