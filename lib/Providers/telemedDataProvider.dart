import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telemed/Model/AppointmentModel.dart';
import 'package:telemed/Model/AttachmentsModel.dart';
import 'package:telemed/Model/CaderModel.dart';
import 'package:telemed/Model/ConversationModel.dart';
import 'package:telemed/Model/DoctorQualificationsModel.dart';
import 'package:telemed/Model/DoctorSpecialitiesModel.dart';
import 'package:telemed/Model/DrugAllergiesModel.dart';
import 'package:telemed/Model/JsendResponseModel.dart';
import 'package:telemed/Model/MedicalConditionsModel.dart';
import 'package:telemed/Model/MessageModel.dart';
import 'package:telemed/Model/SurgeriesModel.dart';
import 'package:telemed/Model/SymptomsModel.dart';
import 'package:telemed/Model/UserModel.dart';
import 'package:telemed/Networking/APIJsend.dart';
import 'package:telemed/Networking/APIManager.dart';
import 'package:telemed/Networking/TelemedApi.dart';
import 'package:telemed/UI/Home/BasePage.dart';
import 'package:telemed/UI/SignInSignUp/SignInPage.dart';
import 'package:telemed/Utils/DialogUtils.dart';
import 'package:telemed/settings.dart';

class TelemedDataProvider
    with ChangeNotifier, DiagnosticableTreeMixin
    implements TelemedApi {
  TextTheme getTelemedTextStyle(BuildContext context) {
    double increaseFontSizeBy = 1;
    switch (telemedTextSize) {
      case TelemedTextSizeEnum.small:
        increaseFontSizeBy = 0.8;
        break;
      case TelemedTextSizeEnum.medium:
        increaseFontSizeBy = 1;
        break;
      case TelemedTextSizeEnum.large:
        increaseFontSizeBy = 1.2;
        break;
      default:
        increaseFontSizeBy = 1;
        break;
    }

    TextTheme textTheme = TextTheme(
      displayLarge: TextStyle(fontSize: (57.0 * increaseFontSizeBy)),
      displayMedium: TextStyle(fontSize: 45.0 * increaseFontSizeBy),
      displaySmall: TextStyle(fontSize: 36.0 * increaseFontSizeBy),
      headlineLarge: TextStyle(fontSize: 32.0 * increaseFontSizeBy),
      headlineMedium: TextStyle(fontSize: 28.0 * increaseFontSizeBy),
      headlineSmall: TextStyle(fontSize: 24.0 * increaseFontSizeBy),
      titleLarge: TextStyle(fontSize: 22.0 * increaseFontSizeBy),
      titleMedium: TextStyle(fontSize: 16.0 * increaseFontSizeBy),
      titleSmall: TextStyle(fontSize: 14.0 * increaseFontSizeBy),
      labelLarge: TextStyle(fontSize: 14.0 * increaseFontSizeBy),
      labelMedium: TextStyle(fontSize: 12.0 * increaseFontSizeBy),
      labelSmall: TextStyle(fontSize: 11.0 * increaseFontSizeBy),
      bodyLarge: TextStyle(fontSize: 16.0 * increaseFontSizeBy),
      bodyMedium: TextStyle(fontSize: 14.0 * increaseFontSizeBy),
      bodySmall: TextStyle(fontSize: 12.0 * increaseFontSizeBy),
    );
    return textTheme;
  }

  String _newAuthority = "";

  String get newAuthority => _newAuthority;

  void setNewAuthority(String newAuthority) {
    _newAuthority = newAuthority;
    notifyListeners();
  }

  TelemedTextSizeEnum _telemedTextSize = TelemedTextSizeEnum.medium;

  TelemedTextSizeEnum get telemedTextSize => _telemedTextSize;

  void setTelemedTextSize(TelemedTextSizeEnum telemedTextSize) {
    _telemedTextSize = telemedTextSize;
    notifyListeners();
  }

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

  String? _selectedMainReasonForVisit;

  String? get selectedMainReasonForVisit => _selectedMainReasonForVisit;

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

  // DoctorQualificationsModel
  DoctorSpecialitiesModel? _selectedDoctorSpecialitiesModel =
      DoctorSpecialitiesModel();

  DoctorSpecialitiesModel? get selectedDoctorSpecialitiesModel =>
      _selectedDoctorSpecialitiesModel;

  // Drug allergies
  DrugAllergiesModel? _selectedDrugAllergiesModel = DrugAllergiesModel();

  DrugAllergiesModel? get selectedDrugAllergiesModel =>
      _selectedDrugAllergiesModel;

  // Medical conditions
  MedicalConditionsModel? _selectedMedicalConditionsModel =
      MedicalConditionsModel();

  MedicalConditionsModel? get selectedMedicalConditionsModel =>
      _selectedMedicalConditionsModel;

  // Surgeries
  SurgeriesModel? _selectedSurgeriesModel = SurgeriesModel();

  SurgeriesModel? get selectedSurgeriesModel => _selectedSurgeriesModel;

  // Symptoms
  SymptomsModel? _selectedSymptomsModel = SymptomsModel(isSelected: false);

  SymptomsModel? get selectedSymptomsModel => _selectedSymptomsModel;

  // Appointments
  AppointmentModel? _selectedAppointmentModel = AppointmentModel(
      surgeriesModelList: [],
      drugAllergiesModelList: [],
      medicalConditionsModelList: [],
      famMedicalConditionsModelList: [],
      symptomsModelList: []);

  AppointmentModel? get selectedAppointmentModel => _selectedAppointmentModel;

  // Conversations
  ConversationModel? _selectedConversationModel = ConversationModel();

  ConversationModel? get selectedConversationModel =>
      _selectedConversationModel;

  // Messages
  MessageModel? _selectedMessageModel = MessageModel();

  MessageModel? get selectedMessageModel => _selectedMessageModel;

  void setSelectedMainReasonForVisitNull() {
    _selectedMainReasonForVisit = null;
  }

  void setSelectedMainReasonForVisit(
      {required String selectedMainReasonForVisit}) {
    _selectedMainReasonForVisit = selectedMainReasonForVisit;
  }

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
    if (model is DoctorSpecialitiesModel) {
      _selectedDoctorSpecialitiesModel = null;
    }
    if (model is DrugAllergiesModel) {
      _selectedDrugAllergiesModel = null;
    }
    if (model is MedicalConditionsModel) {
      _selectedMedicalConditionsModel = null;
    }
    if (model is SurgeriesModel) {
      _selectedSurgeriesModel = null;
    }
    if (model is SymptomsModel) {
      _selectedSymptomsModel = null;
    }
    if (model is AppointmentModel) {
      _selectedAppointmentModel = null;
    }
    if (model is ConversationModel) {
      _selectedConversationModel = null;
    }
    if (model is MessageModel) {
      _selectedMessageModel = null;
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
    if (model is DoctorSpecialitiesModel) {
      _selectedDoctorSpecialitiesModel = model;
    }
    if (model is DrugAllergiesModel) {
      _selectedDrugAllergiesModel = model;
    }
    if (model is MedicalConditionsModel) {
      _selectedMedicalConditionsModel = model;
    }
    if (model is SurgeriesModel) {
      _selectedSurgeriesModel = model;
    }
    if (model is SymptomsModel) {
      _selectedSymptomsModel = model;
    }
    if (model is AppointmentModel) {
      _selectedAppointmentModel = model;
    }
    if (model is ConversationModel) {
      _selectedConversationModel = model;
    }
    if (model is MessageModel) {
      _selectedMessageModel = model;
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

  List<DoctorSpecialitiesModel> _doctorSpecialitiesModelList = [];
  List<DoctorSpecialitiesModel> _filteredDoctorSpecialitiesModelList = [];

  List<DoctorSpecialitiesModel> get doctorSpecialitiesModelList =>
      _doctorSpecialitiesModelList;

  List<DoctorSpecialitiesModel> get filteredDoctorSpecialitiesModelList =>
      _filteredDoctorSpecialitiesModelList;

  List<DrugAllergiesModel> _drugAllergiesModelList = [];
  List<DrugAllergiesModel> _filteredDrugAllergiesModelList = [];

  List<DrugAllergiesModel> get drugAllergiesModelList =>
      _drugAllergiesModelList;

  List<DrugAllergiesModel> get filteredDrugAllergiesModelList =>
      _filteredDrugAllergiesModelList;

  List<MedicalConditionsModel> _medicalConditionsModelList = [];
  List<MedicalConditionsModel> _filteredMedicalConditionsModelList = [];

  List<MedicalConditionsModel> get medicalConditionsModelList =>
      _medicalConditionsModelList;

  List<MedicalConditionsModel> get filteredMedicalConditionsModelList =>
      _filteredMedicalConditionsModelList;

  List<MedicalConditionsModel> _familyMedicalConditionsModelList = [];
  List<MedicalConditionsModel> _filteredFamilyMedicalConditionsModelList = [];

  List<MedicalConditionsModel> get familyMedicalConditionsModelList =>
      _familyMedicalConditionsModelList;

  List<MedicalConditionsModel> get filteredFamilyMedicalConditionsModelList =>
      _filteredFamilyMedicalConditionsModelList;

  List<SurgeriesModel> _surgeriesModelList = [];
  List<SurgeriesModel> _filteredSurgeriesModelList = [];

  List<SurgeriesModel> get surgeriesModelList => _surgeriesModelList;

  List<SurgeriesModel> get filteredSurgeriesModelList =>
      _filteredSurgeriesModelList;

  List<SymptomsModel> _symptomsModelList = [];
  List<SymptomsModel> _filteredSymptomsModelList = [];

  List<SymptomsModel> get symptomsModelList => _symptomsModelList;

  List<SymptomsModel> get filteredSymptomsModelList =>
      _filteredSymptomsModelList;

  List<AppointmentModel> _appointmentModelList = [];
  List<AppointmentModel> _filteredAppointmentModelList = [];

  List<AppointmentModel> get appointmentModelList => _appointmentModelList;

  List<AppointmentModel> get filteredAppointmentModelList =>
      _filteredAppointmentModelList;

  List<AppointmentModel> _allAppointmentModelList = [];
  List<AppointmentModel> _filteredAllAppointmentModelList = [];

  List<AppointmentModel> get allAppointmentModelList =>
      _allAppointmentModelList;

  List<AppointmentModel> get filteredAllAppointmentModelList =>
      _filteredAllAppointmentModelList;

  List<ConversationModel> _conversationModelList = [];
  List<ConversationModel> _filteredConversationModelList = [];

  List<ConversationModel> get conversationModelList => _conversationModelList;

  List<ConversationModel> get filteredConversationModelList =>
      _filteredConversationModelList;

  List<MessageModel> _messageModelList = [];
  List<MessageModel> _filteredMessageModelList = [];

  List<MessageModel> get messageModelList => _messageModelList;

  List<MessageModel> get filteredMessageModelList => _filteredMessageModelList;

  void addIntoHealthProfileLists(
      {required model, bool isFamilyMedicalConditions = false}) {
    if (model is SymptomsModel) {
      _selectedAppointmentModel!.symptomsModelList!.add(model);
    }
    if (model is DrugAllergiesModel) {
      _selectedAppointmentModel!.drugAllergiesModelList!.add(model);
    }
    if (model is MedicalConditionsModel && !isFamilyMedicalConditions) {
      _selectedAppointmentModel!.medicalConditionsModelList!.add(model);
    }
    if (model is SurgeriesModel) {
      _selectedAppointmentModel!.surgeriesModelList!.add(model);
    }
    if (model is MedicalConditionsModel && isFamilyMedicalConditions) {
      _selectedAppointmentModel!.famMedicalConditionsModelList!.add(model);
    }
    notifyListeners();
  }

  void removeFromHealthProfileLists(
      {required model, bool isFamilyMedicalConditions = false}) {
    if (model is SymptomsModel) {
      _selectedAppointmentModel!.symptomsModelList!
          .removeWhere((element) => element.id == model.id);
    }
    if (model is DrugAllergiesModel) {
      _selectedAppointmentModel!.drugAllergiesModelList!
          .removeWhere((element) => element.id == model.id);
    }
    if (model is MedicalConditionsModel && !isFamilyMedicalConditions) {
      _selectedAppointmentModel!.medicalConditionsModelList!
          .removeWhere((element) => element.id == model.id);
    }
    if (model is SurgeriesModel) {
      _selectedAppointmentModel!.surgeriesModelList!
          .removeWhere((element) => element.id == model.id);
    }
    if (model is MedicalConditionsModel && isFamilyMedicalConditions) {
      _selectedAppointmentModel!.famMedicalConditionsModelList!
          .removeWhere((element) => element.id == model.id);
    }
    notifyListeners();
  }

  void setData(
      {required modelList,
      bool isFamilyMedicalConditions = false,
      bool isAllAppointments = false}) {
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

    if (modelList is List<DoctorSpecialitiesModel>) {
      _doctorSpecialitiesModelList = modelList;
      _filteredDoctorSpecialitiesModelList = modelList;
    }

    if (modelList is List<DrugAllergiesModel>) {
      _drugAllergiesModelList = modelList;
      _filteredDrugAllergiesModelList = modelList;
    }

    if (modelList is List<MedicalConditionsModel>) {
      _medicalConditionsModelList = modelList;
      _filteredMedicalConditionsModelList = modelList;
    }

    if (modelList is List<SurgeriesModel>) {
      _surgeriesModelList = modelList;
      _filteredSurgeriesModelList = modelList;
    }

    if (modelList is List<SymptomsModel>) {
      _symptomsModelList = modelList;
      _filteredSymptomsModelList = modelList;
    }

    if (modelList is List<MedicalConditionsModel> &&
        isFamilyMedicalConditions) {
      _familyMedicalConditionsModelList = modelList;
      _filteredFamilyMedicalConditionsModelList = modelList;
    }

    if (modelList is List<AppointmentModel> && isAllAppointments == false) {
      _appointmentModelList = modelList;
      _filteredAppointmentModelList = modelList;
    }

    if (modelList is List<AppointmentModel> && isAllAppointments == true) {
      _allAppointmentModelList = modelList;
      _filteredAllAppointmentModelList = modelList;
    }

    if (modelList is List<ConversationModel>) {
      _conversationModelList = modelList;
      _filteredConversationModelList = modelList;
    }
    if (modelList is List<MessageModel>) {
      _messageModelList = modelList;
      _filteredMessageModelList = modelList;
    }

    notifyListeners();
  }

  void updateFilteredData(
      {required modelList,
      bool isFamilyMedicalConditions = false,
      bool isAllAppointments = false}) {
    if (modelList is List<CaderModel>) {
      _filteredCaderModelList = modelList;
    }
    if (modelList is List<UserModel>) {
      _filteredUserModelList = modelList;
    }
    if (modelList is List<DoctorQualificationsModel>) {
      _filteredDoctorQualificationsModelList = modelList;
    }
    if (modelList is List<DoctorSpecialitiesModel>) {
      _filteredDoctorSpecialitiesModelList = modelList;
    }
    if (modelList is List<DrugAllergiesModel>) {
      _filteredDrugAllergiesModelList = modelList;
    }
    if (modelList is List<MedicalConditionsModel>) {
      _filteredMedicalConditionsModelList = modelList;
    }
    if (modelList is List<SurgeriesModel>) {
      _filteredSurgeriesModelList = modelList;
    }
    if (modelList is List<SymptomsModel>) {
      _filteredSymptomsModelList = modelList;
    }
    if (modelList is List<MedicalConditionsModel> &&
        isFamilyMedicalConditions) {
      _filteredFamilyMedicalConditionsModelList = modelList;
    }
    if (modelList is List<AppointmentModel> && isAllAppointments == false) {
      _filteredAppointmentModelList = modelList;
    }

    if (modelList is List<AppointmentModel> && isAllAppointments == true) {
      _filteredAllAppointmentModelList = modelList;
    }
    if (modelList is List<ConversationModel>) {
      _filteredConversationModelList = modelList;
    }
    if (modelList is List<MessageModel>) {
      _filteredMessageModelList = modelList;
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
      case TelemedApiRoutes.apiRouteDoctorSpecialities:
        list = List<DoctorSpecialitiesModel>.from([]);
        break;
      case TelemedApiRoutes.apiRouteDrugAllergies:
        list = List<DrugAllergiesModel>.from([]);
        break;
      case TelemedApiRoutes.apiRouteMedicalConditions:
        list = List<MedicalConditionsModel>.from([]);
        break;
      case TelemedApiRoutes.apiRouteSurgeries:
        list = List<SurgeriesModel>.from([]);
        break;
      case TelemedApiRoutes.apiRouteSymptoms:
        list = List<SymptomsModel>.from([]);
        break;
      case TelemedApiRoutes.apiRouteAppointmentByDate:
        list = List<AppointmentModel>.from([]);
        break;
      case TelemedApiRoutes.apiRouteAppointment:
        list = List<AppointmentModel>.from([]);
        break;
      case TelemedApiRoutes.apiRouteConversationsByUserId:
        list = List<ConversationModel>.from([]);
        break;
      case TelemedApiRoutes.apiRouteMessagesByConversationId:
        list = List<MessageModel>.from([]);
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
        setData(modelList: list);
        break;
      case TelemedApiRoutes.apiRouteDoctorsByCaderId:
        list = List<UserModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          UserModel model = UserModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        setData(modelList: list);
        break;
      case TelemedApiRoutes.apiRouteDoctorQualifications:
        list = List<DoctorQualificationsModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          DoctorQualificationsModel model =
              DoctorQualificationsModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        setData(modelList: list);
        break;
      case TelemedApiRoutes.apiRouteDoctorSpecialities:
        list = List<DoctorSpecialitiesModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          DoctorSpecialitiesModel model =
              DoctorSpecialitiesModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        setData(modelList: list);
        break;
      case TelemedApiRoutes.apiRouteDrugAllergies:
        list = List<DrugAllergiesModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          DrugAllergiesModel model =
              DrugAllergiesModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        setData(modelList: list);
        break;
      case TelemedApiRoutes.apiRouteMedicalConditions:
        list = List<MedicalConditionsModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          MedicalConditionsModel model =
              MedicalConditionsModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        setData(modelList: list);
        break;
      case TelemedApiRoutes.apiRouteSurgeries:
        list = List<SurgeriesModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          SurgeriesModel model =
              SurgeriesModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        setData(modelList: list);
        break;
      case TelemedApiRoutes.apiRouteSymptoms:
        list = List<SymptomsModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          SymptomsModel model =
              SymptomsModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        setData(modelList: list);
        break;
      case TelemedApiRoutes.apiRouteCreateAppointment:
        list = List<AppointmentModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          AppointmentModel model =
              AppointmentModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        setData(modelList: list);
        break;
      case TelemedApiRoutes.apiRouteAppointmentByDate:
        list = List<AppointmentModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          AppointmentModel model =
              AppointmentModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        setData(modelList: list);
        break;
      case TelemedApiRoutes.apiRouteAppointment:
        list = List<AppointmentModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          AppointmentModel model =
              AppointmentModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        setData(modelList: list, isAllAppointments: true);
        break;
      case TelemedApiRoutes.apiRouteConversationsByUserId:
        list = List<ConversationModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          ConversationModel model =
              ConversationModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        setData(modelList: list);
        break;
      case TelemedApiRoutes.apiRouteMessagesByConversationId:
        list = List<MessageModel>.from([]);
        for (int idx = 0; idx < jsendResponseModel.data.length; idx++) {
          MessageModel model =
              MessageModel.fromJson(jsendResponseModel.data[idx]);
          list.add(model);
        }
        setData(modelList: list);
        break;
    }
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
              const RouteSettings(name: BasePage.route, arguments: '');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  settings: settings,
                  builder: (context) => const BasePage(
                        subRoute: BasePage.homePage,
                      )),
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
        } else if (apiRoute == TelemedApiRoutes.apiRouteCreateAppointment) {
          var result = await DialogUtils.displayDialogOKforAppointScheduledCallBack(
              context,
              TelemedStrings.appointmentConfirmed,
              "${TelemedStrings.appointmentConfirmationDialogMessage}\n${selectedDoctorModel!.firstName!} ${selectedDoctorModel!.lastName!}\n${selectedAppointmentModel!.timeOfAppointment!} ${TelemedStrings.at} ${TelemedSettings.dateFormat.format(DateFormat("yyyy-MM-dd").parse(selectedAppointmentModel!.dateOfAppointment!))}");

          if (result != null && result) {
            RouteSettings settings =
                const RouteSettings(name: SignInPage.route, arguments: '');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    settings: settings,
                    builder: (context) => const BasePage(
                          subRoute: BasePage.homePage,
                        )),
                (route) => false);
          }
        } else if (apiRoute == TelemedApiRoutes.apiRouteCreateMessages) {
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

  @override
  apiRouteDoctorSpecialities({required context}) async {
    await _apiRead(
      context: context,
      token: selectedUserModel.token,
      apiRoute: TelemedApiRoutes.apiRouteDoctorSpecialities,
    );
  }

  @override
  apiRouteDrugAllergies({required context}) async {
    await _apiRead(
      context: context,
      token: selectedUserModel.token,
      apiRoute: TelemedApiRoutes.apiRouteDrugAllergies,
    );
  }

  @override
  apiRouteMedicalConditions({required context}) async {
    await _apiRead(
      context: context,
      token: selectedUserModel.token,
      apiRoute: TelemedApiRoutes.apiRouteMedicalConditions,
    );
  }

  @override
  apiRouteSurgeries({required context}) async {
    await _apiRead(
      context: context,
      token: selectedUserModel.token,
      apiRoute: TelemedApiRoutes.apiRouteSurgeries,
    );
  }

  @override
  apiRouteSymptoms({required context}) async {
    await _apiRead(
      context: context,
      token: selectedUserModel.token,
      apiRoute: TelemedApiRoutes.apiRouteSymptoms,
    );
  }

  // @override
  // apiRouteCreateHealthProfile(
  //     {required context,
  //     required HealthProfileModel healthProfileModel}) async {
  //   await _apiCreateOrUpdate(
  //       context: context,
  //       token: selectedUserModel.token,
  //       apiRoute: TelemedApiRoutes.apiRouteCreateHealthProfile,
  //       model: healthProfileModel);
  // }

  @override
  apiRouteCreateAppointment(
      {required context, required AppointmentModel appointmentModel}) async {
    await _apiCreateOrUpdate(
        context: context,
        token: selectedUserModel.token,
        apiRoute: TelemedApiRoutes.apiRouteCreateAppointment,
        model: appointmentModel);
  }

  @override
  apiRouteAppointmentByDate({required context}) async {
    Map<String, dynamic> param = {
      'dateOfAppointment':
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
    };
    await _apiRead(
        context: context,
        token: selectedUserModel.token,
        apiRoute: TelemedApiRoutes.apiRouteAppointmentByDate,
        param: param);
  }

  @override
  apiRouteAppointment({required context}) async {
    await _apiRead(
      context: context,
      token: selectedUserModel.token,
      apiRoute: TelemedApiRoutes.apiRouteAppointment,
    );
  }

  @override
  apiRouteConversationsByUserId({required context}) async {
    await _apiRead(
      context: context,
      token: selectedUserModel.token,
      apiRoute: TelemedApiRoutes.apiRouteConversationsByUserId,
    );
  }

  @override
  apiRouteMessagesByConversationId({required context}) async {
    Map<String, dynamic> param = {
      'conversationId': _selectedConversationModel!.id.toString(),
    };
    await _apiRead(
        context: context,
        token: selectedUserModel.token,
        apiRoute: TelemedApiRoutes.apiRouteMessagesByConversationId,
        param: param);
  }

  @override
  apiRoutecreateMessages(
      {required context, required MessageModel messageModel}) async {
    await _apiCreateOrUpdate(
      context: context,
      token: selectedUserModel.token,
      apiRoute: TelemedApiRoutes.apiRouteCreateMessages,
      model: messageModel,
    );
  }

  @override
  apiRouteCreateAttachment(
      {required context,
      required AttachmentsModel attachmentsModel,
      required String localFilePath}) async {
    String jsonEncoded = convert.jsonEncode(attachmentsModel);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? authority =
        prefs.getString(TelemedSettings.sharefPrefsAuthority);

    http.Client client = http.Client();


    Uri uri = Uri.https(
        authority!,
        TelemedSettings.unencodedPath +
            TelemedApiRoutes.apiRouteCreateAttachment,
        {});

    Map<String, String> headers = TelemedSettings.getFileAttachmentHttpHeaders(
        token: selectedUserModel.token);

    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(headers);
    // request.fields['user'] = 'blah';
    // request.fields.addAll(attachmentsModel.toJson() as Map<String, String>);
    request.files.add(
      http.MultipartFile.fromBytes(
        'attachmentFile',
        await File.fromUri(Uri.parse(localFilePath)).readAsBytes(),
        filename: "attachmentFile"
        // contentType: MediaType('*', '*'),
        // contentType: MediaType.parse("image/jpg"),
        // contentType: MediaType('application', 'pdf'),
        // contentType: MediaType('image', 'jpeg'),
      ),
    );

    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });

    // await _apiCreateOrUpdate(
    //   context: context,
    //   token: selectedUserModel.token,
    //   apiRoute: TelemedApiRoutes.apiRouteCreateAttachment,
    //   model: attachmentsModel,
    // );
  }
}
