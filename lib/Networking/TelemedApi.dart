import 'package:telemed/Model/CaderModel.dart';
import 'package:telemed/Model/UserModel.dart';

class TelemedApi {
  // Sign in and create account
  apiRouteLogin({required context, required UserModel userModel}) {}

  apiRouteCreateAccount({required context, required UserModel userModel}) {}

  apiRouteCaders({required context}) {}

  apiRouteDoctorsByCaderId({required context}) {}

  apiRouteDoctorQualifications({required context}) {}

  apiRouteDoctorSpecialities({required context}) {}
}

class TelemedApiRoutes {
  // Sign in and create account
  static const String apiRouteLogin = '/signIn';
  static const String apiRouteCreateAccount = '/createAccount';
  static const String apiRouteCaders = '/caders';
  static const String apiRouteDoctorQualifications = '/doctorQualifications';
  static const String apiRouteDoctorSpecialities = '/doctorSpecialities';
  static const String apiRouteDoctorsByCaderId = '/doctorsByCaderId';
}
