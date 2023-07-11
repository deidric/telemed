import 'package:json_annotation/json_annotation.dart';

part 'AppointmentModel.g.dart';

@JsonSerializable()
class AppointmentModel {
  int? id;
  int? doctorId;
  int? patientId;
  int? caderId;
  String? dateOfAppointment;
  String? timeOfAppointment;
  String? complaint;
  int? pwdIdNumber;
  String? pwdIdExpirationDate;
  String? paymentReferenceNumber;
  String? firstName;
  String? lastName;

  AppointmentModel({
    this.id,
    this.doctorId,
    this.patientId,
    this.caderId,
    this.dateOfAppointment,
    this.timeOfAppointment,
    this.complaint,
    this.pwdIdNumber,
    this.pwdIdExpirationDate,
    this.paymentReferenceNumber,
    this.firstName,
    this.lastName,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}

enum FieldNames {
  id,
  doctorId,
  patientId,
  caderId,
  dateOfAppointment,
  timeOfAppointment,
  complaint,
  pwdIdNumber,
  pwdIdExpirationDate,
  paymentReferenceNumber,
  firstName,
  lastName,
}

extension FieldNamesExtension on FieldNames {
  String get name {
    switch (this) {
      case FieldNames.id:
        return 'id';
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
      case FieldNames.firstName:
        return 'firstName';
      case FieldNames.lastName:
        return 'lastName';
    }
  }
}
