import 'package:telemed/Model/UserModel.dart';

class TelemedApi {
    // Sign in and create account
  apiRouteLogin({required context, required UserModel userModel}) {}

  apiRouteCreateAccount({required context, required UserModel userModel}) {}

}

class TelemedApiRoutes {
    // Sign in and create account
  static const String apiRouteLogin = '/signIn';
  static const String apiRouteCreateAccount = '/createAccount';


}
