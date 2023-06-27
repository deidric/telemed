import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:telemed/Model/CaderModel.dart';
import 'package:telemed/Model/DoctorQualificationsModel.dart';
import 'package:telemed/Model/JsendResponseModel.dart';
import 'package:telemed/Model/UserModel.dart';
import 'package:telemed/Networking/APIJsend.dart';
import 'package:telemed/Networking/APIManager.dart';
import 'package:telemed/Networking/TelemedApi.dart';
import 'package:telemed/UI/Home/HomePage.dart';
import 'package:telemed/UI/SignInSignUp/SignInPage.dart';
import 'package:telemed/Utils/DialogUtils.dart';
import 'package:telemed/settings.dart';
import 'dart:convert' as convert;

class TelemedDataProvider
    with ChangeNotifier, DiagnosticableTreeMixin
    implements TelemedApi {
  bool _isDark = false;

  bool get isDark => _isDark;

  void setDarkMode(isDark) {
    _isDark = isDark;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  // User model - Never allow it to become null
  UserModel _selectedUserModel = UserModel();

  UserModel get selectedUserModel => _selectedUserModel;

  UserModel? _selectedDoctorModel = UserModel();

  UserModel? get selectedDoctorModel => _selectedDoctorModel;

  UserModel? _selectedPatientModel = UserModel();

  UserModel? get selectedPatientModel => _selectedDoctorModel;

  //

  // Cader model
  CaderModel? _selectedCaderModel = CaderModel();

  CaderModel? get selectedCaderModel => _selectedCaderModel;

  // DoctorQualificationsModel
  DoctorQualificationsModel? _selectedDoctorQualificationsModel =
      DoctorQualificationsModel();

  DoctorQualificationsModel? get selectedDoctorQualificationsModel =>
      _selectedDoctorQualificationsModel;

  void setSelectedDataNull(model, typeOfUserModel) {
    if (model is CaderModel) {
      _selectedCaderModel = null;
    }
    if (model is UserModel && typeOfUserModel == TelemedSettings.doctorId) {
      _selectedDoctorModel = null;
    }
    if (model is UserModel && typeOfUserModel == TelemedSettings.patientId) {
      _selectedPatientModel = null;
    }
    if (model is DoctorQualificationsModel) {
      _selectedDoctorQualificationsModel = null;
    }
    notifyListeners();
  }

  void setSelectedData({required model, typeOfUserModel}) {
    if (model is CaderModel) {
      _selectedCaderModel = model;
    }
    if (model is UserModel && typeOfUserModel == TelemedSettings.doctorId) {
      _selectedDoctorModel = model;
    }
    if (model is UserModel && typeOfUserModel == TelemedSettings.patientId) {
      _selectedPatientModel = model;
    }
    if (model is DoctorQualificationsModel) {
      _selectedDoctorQualificationsModel = model;
    }
    notifyListeners();
  }

  List<CaderModel> _caderModelList = [];
  List<CaderModel> _filteredCaderModelList = [];

  List<CaderModel> get caderModelList => _caderModelList;

  List<CaderModel> get filteredCaderModelList => _filteredCaderModelList;

  List<UserModel> _userModelList = [];
  List<UserModel> _filteredUserModelList = [];

  List<UserModel> get userModelList => _userModelList;

  List<UserModel> get filteredUserModelList => _filteredUserModelList;

  List<DoctorQualificationsModel> _doctorQualificationsModelList = [];
  List<DoctorQualificationsModel> _filteredDoctorQualificationsModelList = [];

  List<DoctorQualificationsModel> get doctorQualificationsModelList =>
      _doctorQualificationsModelList;

  List<DoctorQualificationsModel> get filteredDoctorQualificationsModelList =>
      _filteredDoctorQualificationsModelList;

  void setData({required modelList}) {
    if (modelList is List<CaderModel>) {
      _caderModelList = modelList;
      _filteredCaderModelList = modelList;
    }

    if (modelList is List<UserModel>) {
      _userModelList = modelList;
      _filteredUserModelList = modelList;
    }

    if (modelList is List<DoctorQualificationsModel>) {
      _doctorQualificationsModelList = modelList;
      _filteredDoctorQualificationsModelList = modelList;
    }
    notifyListeners();
  }

  void updateFilteredData({required modelList}) {
    if (modelList is List<CaderModel>) {
      _filteredCaderModelList = modelList;
    }
    if (modelList is List<UserModel>) {
      _filteredUserModelList = modelList;
    }
    if (modelList is List<DoctorQualificationsModel>) {
      _filteredDoctorQualificationsModelList = modelList;
    }
    notifyListeners();
  }

  _apiRead(
      {required context,
      required token,
      required apiRoute,
      Map<String, dynamic>? param}) async {
    setLoading(true);
    APIJsend apiJsend = await APIManager()
        .getAPI(token: token, apiRoute: apiRoute, param: param);
    setLoading(false);
    notifyListeners();
    if (apiJsend.apiStatus == APIstatus.success) {
      JsendResponseModel jsendResponseModel =
          JsendResponseModel.fromJson(apiJsend.data);
      if (jsendResponseModel.status == TelemedJsendStatus.success) {
        _readFromResponseAndAddToModel(
            apiRoute: apiRoute, jsendResponseModel: jsendResponseModel);
      } else {
        if (jsendResponseModel.data['message'] ==
            TelemedSettings.CONTANT_UNAUTHENTICATED) {
          String title = TelemedStrings.unauthenticatedAccessTitle;
          String message = TelemedStrings.unauthenticatedAccessMessage;
          DialogUtils.displayDialogOKCallBackAuthDialog(
              context, title, message);
        } else {
          _readFromResponseAndEmptyToModel(
            apiRoute: apiRoute,
          );
          DialogUtils.displayDialogOKCallBack(
              context,
              TelemedStrings.fail.toUpperCase(),
              jsendResponseModel.data['message']);
        }
      }
    } else {
      DialogUtils.displayDialogOKCallBack(
          context, TelemedStrings.fail.toUpperCase(), apiJsend.message);
    }
  }

  _readFromResponseAndEmptyToModel({required apiRoute}) {
    List list = [];
    switch (apiRoute) {
      case TelemedApiRoutes.apiRouteCaders:
        list = List<CaderModel>.from([]);
        break;
      case TelemedApiRoutes.apiRouteDoctorQualifications:
        list = List<DoctorQualificationsModel>.from([]);
        break;
    }
    setData(modelList: list);
  }

  _readFromResponseAndAddToModel(
      {required apiRoute, required JsendResponseModel jsendResponseModel}) {
    List list = [];
    switch (apiRoute) {
      case TelemedApiRoutes.apiRouteCaders:
        list = List<CaderModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          CaderModel model = CaderModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        break;
      case TelemedApiRoutes.apiRouteDoctorsByCaderId:
        list = List<UserModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          UserModel model = UserModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        break;
      case TelemedApiRoutes.apiRouteDoctorQualifications:
        list = List<DoctorQualificationsModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          DoctorQualificationsModel model =
              DoctorQualificationsModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        break;
    }
    setData(modelList: list);
  }

  _apiCreateOrUpdate(
      {required context, token, required apiRoute, required model}) async {
    setLoading(true);
    APIJsend apiJsend = await APIManager().postAPI(
        token: token, apiRoute: apiRoute, param: convert.jsonEncode(model));

    setLoading(false);
    if (apiJsend.apiStatus == APIstatus.success) {
      JsendResponseModel jsendResponseModel =
          JsendResponseModel.fromJson(apiJsend.data);
      if (jsendResponseModel.status == TelemedJsendStatus.success) {
        if (apiRoute == TelemedApiRoutes.apiRouteLogin) {
          _selectedUserModel = UserModel.fromJson(jsendResponseModel.data);
          RouteSettings settings =
              const RouteSettings(name: HomePage.route, arguments: '');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  settings: settings, builder: (context) => const HomePage()),
              (route) => false);
        } else if (apiRoute == TelemedApiRoutes.apiRouteCreateAccount) {
          // this.setUserData(UserModel.fromJson(jsendResponseModel.data));
          RouteSettings settings =
              const RouteSettings(name: SignInPage.route, arguments: '');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  settings: settings, builder: (context) => const SignInPage()),
              (route) => false);
        } else {
          Navigator.pop(context, true);
        }
      } else {
        if (jsendResponseModel.data['message'] ==
            TelemedSettings.CONTANT_UNAUTHENTICATED) {
          String title = TelemedStrings.unauthenticatedAccessTitle;
          String message = TelemedStrings.unauthenticatedAccessMessage;
          DialogUtils.displayDialogOKCallBackAuthDialog(
              context, title, message);
        } else {
          DialogUtils.displayDialogOKCallBack(
              context,
              TelemedStrings.fail.toUpperCase(),
              jsendResponseModel.data['message']);
        }
      }
    } else {
      await DialogUtils.displayDialogOKCallBack(
          context, TelemedStrings.fail.toUpperCase(), apiJsend.message);
    }
  }

  _apiDelete(
      {required context,
      required token,
      required apiRoute,
      Map<String, dynamic>? param}) async {
    setLoading(true);
    APIJsend apiJsend = await APIManager()
        .deleteAPI(token: token, apiRoute: apiRoute, param: param);
    setLoading(false);
    if (apiJsend.apiStatus == APIstatus.success) {
      JsendResponseModel jsendResponseModel =
          JsendResponseModel.fromJson(apiJsend.data);
      if (jsendResponseModel.status == TelemedJsendStatus.success) {
        DialogUtils.displayDialogOKCallBack(
          context,
          TelemedStrings.success.toUpperCase(),
          TelemedStrings.deleteSuccessful.toUpperCase(),
        );
      } else {
        if (jsendResponseModel.data['message'] ==
            TelemedSettings.CONTANT_UNAUTHENTICATED) {
          String title = TelemedStrings.unauthenticatedAccessTitle;
          String message = TelemedStrings.unauthenticatedAccessMessage;
          DialogUtils.displayDialogOKCallBackAuthDialog(
              context, title, message);
        } else {
          DialogUtils.displayDialogOKCallBack(
              context,
              TelemedStrings.fail.toUpperCase(),
              jsendResponseModel.data['message']);
        }
      }
    } else {
      DialogUtils.displayDialogOKCallBack(
          context, TelemedStrings.fail.toUpperCase(), apiJsend.message);
    }
  }

  @override
  apiRouteCreateAccount({required context, required userModel}) async {
    await _apiCreateOrUpdate(
        context: context,
        apiRoute: TelemedApiRoutes.apiRouteCreateAccount,
        model: userModel);
  }

  @override
  apiRouteLogin({required context, required userModel}) async {
    await _apiCreateOrUpdate(
        context: context,
        apiRoute: TelemedApiRoutes.apiRouteLogin,
        model: userModel);
  }

  @override
  apiRouteCaders({required context}) async {
    await _apiRead(
      context: context,
      token: selectedUserModel.token,
      apiRoute: TelemedApiRoutes.apiRouteCaders,
    );
  }

  @override
  apiRouteDoctorsByCaderId({required context}) async {
    Map<String, dynamic> param = {
      'caderId': selectedCaderModel!.id.toString(),
    };
    await _apiRead(
        context: context,
        token: selectedUserModel.token,
        apiRoute: TelemedApiRoutes.apiRouteDoctorsByCaderId,
        param: param);
  }

  @override
  apiRouteDoctorQualifications({required context}) async {
    await _apiRead(
      context: context,
      token: selectedUserModel.token,
      apiRoute: TelemedApiRoutes.apiRouteDoctorQualifications,
    );
  }
}
