// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppointmentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      id: json['id'] as int?,
      lengthOfFeeling: json['lengthOfFeeling'] as String?,
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
      famMedicalConditionsModelList: (json['famMedicalConditionsModelList']
              as List<dynamic>?)
          ?.map(
              (e) => MedicalConditionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      surgeriesModelList: (json['surgeriesModelList'] as List<dynamic>?)
          ?.map((e) => SurgeriesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      doctorId: json['doctorId'] as int?,
      patientId: json['patientId'] as int?,
      caderId: json['caderId'] as int?,
      dateOfAppointment: json['dateOfAppointment'] as String?,
      timeOfAppointment: json['timeOfAppointment'] as String?,
      complaint: json['complaint'] as String?,
      pwdIdNumber: json['pwdIdNumber'] as int?,
      pwdIdExpirationDate: json['pwdIdExpirationDate'] as String?,
      paymentReferenceNumber: json['paymentReferenceNumber'] as String?,
      doctorUserFirstName: json['doctorUserFirstName'] as String?,
      doctorUserLastName: json['doctorUserLastName'] as String?,
      patientUserFirstName: json['patientUserFirstName'] as String?,
      patientUserLastName: json['patientUserLastName'] as String?,
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lengthOfFeeling': instance.lengthOfFeeling,
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
      'doctorId': instance.doctorId,
      'patientId': instance.patientId,
      'caderId': instance.caderId,
      'dateOfAppointment': instance.dateOfAppointment,
      'timeOfAppointment': instance.timeOfAppointment,
      'complaint': instance.complaint,
      'pwdIdNumber': instance.pwdIdNumber,
      'pwdIdExpirationDate': instance.pwdIdExpirationDate,
      'paymentReferenceNumber': instance.paymentReferenceNumber,
      'doctorUserFirstName': instance.doctorUserFirstName,
      'doctorUserLastName': instance.doctorUserLastName,
      'patientUserFirstName': instance.patientUserFirstName,
      'patientUserLastName': instance.patientUserLastName,
    };
