import 'package:telemed/Model/AppointmentModel.dart';
import 'package:telemed/Model/HealthProfileModel.dart';
import 'package:telemed/Model/UserModel.dart';

class TelemedApi {
  // Sign in and create account
  apiRouteLogin({required context, required UserModel userModel}) {}

  apiRouteCreateAccount({required context, required UserModel userModel}) {}

  apiRouteCaders({required context}) {}

  apiRouteDoctorsByCaderId({required context}) {}

  apiRouteDoctorQualifications({required context}) {}

  apiRouteDoctorSpecialities({required context}) {}

  apiRouteSymptoms({required context}) {}

  apiRouteMedicalConditions({required context}) {}

  apiRouteDrugAllergies({required context}) {}

  apiRouteSurgeries({required context}) {}

  apiRouteCreateHealthProfile(
      {required context, required HealthProfileModel healthProfileModel}) {}

  apiRouteCreateAppointment({required context, required AppointmentModel appointmentModel}) {}
}

class TelemedApiRoutes {
  // Sign in and create account
  static const String apiRouteLogin = '/signIn';
  static const String apiRouteCreateAccount = '/createAccount';

  // Caders
  static const String apiRouteCaders = '/caders';

  // Doctor qualifications
  static const String apiRouteDoctorQualifications = '/doctorQualifications';

  // Doctor specialities
  static const String apiRouteDoctorSpecialities = '/doctorSpecialities';

  // Doctor by cader
  static const String apiRouteDoctorsByCaderId = '/doctorsByCaderId';

  // Patient Symptoms
  static const String apiRouteSymptoms = '/symptoms';

  // Medical conditions
  static const String apiRouteMedicalConditions = '/medicalConditions';

  // Drug allergies
  static const String apiRouteDrugAllergies = '/drugAllergies';

  // Surgeries
  static const String apiRouteSurgeries = '/surgeries';

  // Create health profile
  static const String apiRouteCreateHealthProfile = '/createHealthProfile';

  // Create Appointment
  static const String apiRouteCreateAppointment = '/bookAppointment';
}
