// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppointmentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      id: json['id'] as int?,
      doctorId: json['doctorId'] as int?,
      patientId: json['patientId'] as int?,
      caderId: json['caderId'] as int?,
      dateOfAppointment: json['dateOfAppointment'] as String?,
      timeOfAppointment: json['timeOfAppointment'] as String?,
      complaint: json['complaint'] as String?,
      pwdIdNumber: json['pwdIdNumber'] as int?,
      pwdIdExpirationDate: json['pwdIdExpirationDate'] as String?,
      paymentReferenceNumber: json['paymentReferenceNumber'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'patientId': instance.patientId,
      'caderId': instance.caderId,
      'dateOfAppointment': instance.dateOfAppointment,
      'timeOfAppointment': instance.timeOfAppointment,
      'complaint': instance.complaint,
      'pwdIdNumber': instance.pwdIdNumber,
      'pwdIdExpirationDate': instance.pwdIdExpirationDate,
      'paymentReferenceNumber': instance.paymentReferenceNumber,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
