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
  String? dateOfAppointment;
  String? timeOfAppointment;
  String? allergicToDrugsComplaint;
  String? medicalConditionComplaint;
  String? surgeryComplaint;
  int? pwdNumber;
  int? paymentReferenceNumber;
  List<SymptomsModel>? symptomsModel;
  List<DrugAllergiesModel>? drugAllergiesModel;
  List<MedicalConditionsModel>? medicalConditionsModel;
  List<SurgeriesModel>? surgeriesModel;

  HealthProfileModel({
    this.lengthOfFeeling,
    this.patientId,
    this.caderId,
    this.dateOfAppointment,
    this.timeOfAppointment,
    this.allergicToDrugsComplaint,
    this.medicalConditionComplaint,
    this.surgeryComplaint,
    this.pwdNumber,
    this.paymentReferenceNumber,
    this.symptomsModel,
    this.drugAllergiesModel,
    this.medicalConditionsModel,
    this.surgeriesModel
  });

  factory HealthProfileModel.fromJson(Map<String, dynamic> json) =>
      _$HealthProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$HealthProfileModelToJson(this);
}

enum FieldNames {
  lengthOfFeeling,
  patientId,
  caderId,
  dateOfAppointment,
  timeOfAppointment,
  allergicToDrugsComplaint,
  medicalConditionComplaint,
  surgeryComplaint,
  pwdNumber,
  paymentReferenceNumber,
  symptomsModel,
  drugAllergiesModel,
  medicalConditionsModel,
  surgeriesModel
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
      case FieldNames.dateOfAppointment:
        return 'dateOfAppointment';
      case FieldNames.timeOfAppointment:
        return 'timeOfAppointment';
      case FieldNames.allergicToDrugsComplaint:
        return 'allergicToDrugsComplaint';
      case FieldNames.medicalConditionComplaint:
        return 'medicalConditionComplaint';
      case FieldNames.surgeryComplaint:
        return 'surgeryComplaint';
      case FieldNames.pwdNumber:
        return 'pwdNumber';
      case FieldNames.paymentReferenceNumber:
        return 'paymentReferenceNumber';
      case FieldNames.symptomsModel:
        return 'symptomsModel';
      case FieldNames.drugAllergiesModel:
        return 'drugAllergiesModel';
      case FieldNames.medicalConditionsModel:
        return 'medicalConditionsModel';
      case FieldNames.surgeriesModel:
        return 'surgeriesModel';
    }
  }
}
