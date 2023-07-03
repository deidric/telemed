// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HealthProfileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthProfileModel _$HealthProfileModelFromJson(Map<String, dynamic> json) =>
    HealthProfileModel(
      id: json['id'] as int?,
      cader: json['cader'] as String?,
      caderDescription: json['caderDescription'] as String?,
    );

Map<String, dynamic> _$HealthProfileModelToJson(HealthProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cader': instance.cader,
      'caderDescription': instance.caderDescription,
    };
