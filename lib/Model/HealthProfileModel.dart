import 'package:json_annotation/json_annotation.dart';
import 'package:telemed/Model/DrugAllergiesModel.dart';
import 'package:telemed/Model/MedicalConditionsModel.dart';
import 'package:telemed/Model/SurgeriesModel.dart';
import 'package:telemed/Model/SymptomsModel.dart';

part 'HealthProfileModel.g.dart';

@JsonSerializable()
class HealthProfileModel {
  String? lengthOfFeeling;
  int? patientId;
  int? caderId;
  String? medications;
  String? allergicToDrugsComplaint;
  String? medicalConditionComplaint;
  String? familyMedicalConditionComplaint;
  String? surgeryComplaint;
  int? pwdNumber;
  int? paymentReferenceNumber;
  List<SymptomsModel>? symptomsModelList;
  List<DrugAllergiesModel>? drugAllergiesModelList;
  List<MedicalConditionsModel>? medicalConditionsModelList;
  List<MedicalConditionsModel>? familyMedicalConditionsModelList;
  List<SurgeriesModel>? surgeriesModelList;

  HealthProfileModel({
    this.lengthOfFeeling,
    this.patientId,
    this.caderId,
    this.medications,
    this.allergicToDrugsComplaint,
    this.medicalConditionComplaint,
    this.familyMedicalConditionComplaint,
    this.surgeryComplaint,
    this.pwdNumber,
    this.paymentReferenceNumber,
    this.symptomsModelList,
    this.drugAllergiesModelList,
    this.medicalConditionsModelList,
    this.surgeriesModelList,
    this.familyMedicalConditionsModelList,
  });

  factory HealthProfileModel.fromJson(Map<String, dynamic> json) =>
      _$HealthProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$HealthProfileModelToJson(this);
}

enum FieldNames {
  lengthOfFeeling,
  patientId,
  caderId,
  medications,
  allergicToDrugsComplaint,
  medicalConditionComplaint,
  familyMedicalConditionComplaint,
  surgeryComplaint,
  pwdNumber,
  paymentReferenceNumber,
  symptomsModelList,
  drugAllergiesModelList,
  medicalConditionsModelList,
  surgeriesModelList,
  familyMedicalConditionsModelList,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.lengthOfFeeling:
        return 'lengthOfFeeling';
      case FieldNames.patientId:
        return 'patientId';
      case FieldNames.caderId:
        return 'caderId';
      case FieldNames.medications:
        return 'medications';
      case FieldNames.allergicToDrugsComplaint:
        return 'allergicToDrugsComplaint';
      case FieldNames.medicalConditionComplaint:
        return 'medicalConditionComplaint';
      case FieldNames.familyMedicalConditionComplaint:
        return 'familyMedicalConditionComplaint';
      case FieldNames.surgeryComplaint:
        return 'surgeryComplaint';
      case FieldNames.pwdNumber:
        return 'pwdNumber';
      case FieldNames.paymentReferenceNumber:
        return 'paymentReferenceNumber';
      case FieldNames.symptomsModelList:
        return 'symptomsModelList';
      case FieldNames.drugAllergiesModelList:
        return 'drugAllergiesModelList';
      case FieldNames.medicalConditionsModelList:
        return 'medicalConditionsModelList';
      case FieldNames.surgeriesModelList:
        return 'surgeriesModelList';
      case FieldNames.familyMedicalConditionsModelList:
        return 'familyMedicalConditionsModelList';
    }
  }
}
