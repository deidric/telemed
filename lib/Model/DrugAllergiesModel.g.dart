// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DrugAllergiesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrugAllergiesModel _$DrugAllergiesModelFromJson(Map<String, dynamic> json) =>
    DrugAllergiesModel(
      id: json['id'] as int?,
      drugName: json['drugName'] as String?,
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$DrugAllergiesModelToJson(DrugAllergiesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'drugName': instance.drugName,
      'isSelected': instance.isSelected,
    };
