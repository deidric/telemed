import 'package:telemed/Model/AppointmentModel.dart';
import 'package:telemed/Model/AttachmentsModel.dart';
import 'package:telemed/Model/MessageModel.dart';
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

  apiRouteCreateAppointment(
      {required context, required AppointmentModel appointmentModel}) {}

  apiRouteAppointmentByDate({required context}) {}

  apiRouteAppointment({required context}) {}

  apiRouteConversationsByUserId({required context}) {}

  apiRouteMessagesByConversationId({required context}) {}

  apiRoutecreateMessages(
      {required context, required MessageModel messageModel}) {}

  apiRouteCreateAttachment(
      {required context, required AttachmentsModel attachmentsModel, required String localFilePath}) {}
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

  // Create Appointment
  static const String apiRouteCreateAppointment = '/bookAppointment';

  // Get Appointment by date
  static const String apiRouteAppointmentByDate = '/appointmentByDate';

  // Get all appointments
  static const String apiRouteAppointment = '/appointment';

  // Get Conversation by userId
  static const String apiRouteConversationsByUserId = '/conversationsByUserId';

  // Get Conversation by userId
  static const String apiRouteMessagesByConversationId =
      '/messagesByConversationId';

  // Create Conversation by userId
  static const String apiRouteCreateMessages = '/createMessages';

  // Create Attachment by userId
  static const String apiRouteCreateAttachment = '/createAttachment';
}
