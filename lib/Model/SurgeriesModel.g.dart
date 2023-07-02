// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SurgeriesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurgeriesModel _$SurgeriesModelFromJson(Map<String, dynamic> json) =>
    SurgeriesModel(
      id: json['id'] as int?,
      surgeryName: json['surgeryName'] as String?,
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$SurgeriesModelToJson(SurgeriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surgeryName': instance.surgeryName,
      'isSelected': instance.isSelected,
    };
