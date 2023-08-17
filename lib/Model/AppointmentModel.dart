import 'package:json_annotation/json_annotation.dart';
import 'package:telemed/Model/DrugAllergiesModel.dart';
import 'package:telemed/Model/MedicalConditionsModel.dart';
import 'package:telemed/Model/SurgeriesModel.dart';
import 'package:telemed/Model/SymptomsModel.dart';

part 'AppointmentModel.g.dart';

@JsonSerializable()
class AppointmentModel {
  int? id;

  // Health profile
  String? lengthOfFeeling;
  String? medications;
  String? allergicToDrugsComplaint;
  String? medicalConditionComplaint;
  String? familyMedicalConditionComplaint;
  String? surgeryComplaint;
  List<SymptomsModel>? symptomsModelList;
  List<DrugAllergiesModel>? drugAllergiesModelList;
  List<MedicalConditionsModel>? medicalConditionsModelList;
  List<MedicalConditionsModel>? famMedicalConditionsModelList;
  List<SurgeriesModel>? surgeriesModelList;

  // Appointments
  int? doctorId;
  int? patientId;
  int? caderId;
  String? dateOfAppointment;
  String? timeOfAppointment;
  String? complaint;
  int? pwdIdNumber;
  String? pwdIdExpirationDate;
  String? paymentReferenceNumber;
  String? doctorUserFirstName;
  String? doctorUserLastName;
  String? patientUserFirstName;
  String? patientUserLastName;

  AppointmentModel({
    this.id,
    // Health profile
    this.lengthOfFeeling,
    this.medications,
    this.allergicToDrugsComplaint,
    this.medicalConditionComplaint,
    this.familyMedicalConditionComplaint,
    this.surgeryComplaint,
    this.symptomsModelList,
    this.drugAllergiesModelList,
    this.medicalConditionsModelList,
    this.famMedicalConditionsModelList,
    this.surgeriesModelList,
    // Appointments
    this.doctorId,
    this.patientId,
    this.caderId,
    this.dateOfAppointment,
    this.timeOfAppointment,
    this.complaint,
    this.pwdIdNumber,
    this.pwdIdExpirationDate,
    this.paymentReferenceNumber,
    this.doctorUserFirstName,
    this.doctorUserLastName,
    this.patientUserFirstName,
    this.patientUserLastName,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}

enum FieldNames {
  id,
  // Health profile
  lengthOfFeeling,
  medications,
  allergicToDrugsComplaint,
  medicalConditionComplaint,
  familyMedicalConditionComplaint,
  surgeryComplaint,
  symptomsModelList,
  drugAllergiesModelList,
  medicalConditionsModelList,
  famMedicalConditionsModelList,
  surgeriesModelList,
  // Appointments
  doctorId,
  patientId,
  caderId,
  dateOfAppointment,
  timeOfAppointment,
  complaint,
  pwdIdNumber,
  pwdIdExpirationDate,
  paymentReferenceNumber,
  doctorUserFirstName,
  doctorUserLastName,
  patientUserFirstName,
  patientUserLastName,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.id:
        return 'id';
      // Health profile
      case FieldNames.lengthOfFeeling:
        return 'lengthOfFeeling';
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
      case FieldNames.symptomsModelList:
        return 'symptomsModelList';
      case FieldNames.drugAllergiesModelList:
        return 'drugAllergiesModelList';
      case FieldNames.medicalConditionsModelList:
        return 'medicalConditionsModelList';
      case FieldNames.famMedicalConditionsModelList:
        return 'famMedicalConditionsModelList';
      case FieldNames.surgeriesModelList:
        return 'surgeriesModelList';

      // Appointments
      case FieldNames.doctorId:
        return 'doctorId';
      case FieldNames.patientId:
        return 'patientId';
      case FieldNames.caderId:
        return 'caderId';
      case FieldNames.dateOfAppointment:
        return 'dateOfAppointment';
      case FieldNames.timeOfAppointment:
        return 'timeOfAppointment';
      case FieldNames.complaint:
        return 'complaint';
      case FieldNames.pwdIdNumber:
        return 'pwdIdNumber';
      case FieldNames.pwdIdExpirationDate:
        return 'pwdIdExpirationDate';
      case FieldNames.paymentReferenceNumber:
        return 'paymentReferenceNumber';
      case FieldNames.doctorUserFirstName:
        return 'firstName';
      case FieldNames.doctorUserLastName:
        return 'lastName';
      case FieldNames.patientUserFirstName:
        return 'firstName';
      case FieldNames.patientUserLastName:
        return 'lastName';
    }
  }
}
