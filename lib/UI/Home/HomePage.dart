import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Model/ConversationModel.dart';
import 'package:telemed/Model/MessageModel.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/BasePage.dart';
import 'package:telemed/UI/Home/BookAppointmentsReasonForVisitPage.dart';
import 'package:telemed/UI/Home/PatientProfilePage.dart';
import 'package:telemed/Utils/DialogUtils.dart';
import 'package:telemed/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  static const String route = '/basePage/homePage';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final Uri _url = Uri.parse("");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadAllAppMetaDataOnce();
    });
  }

  int runTimes = 0;

  Future<void> loadAllAppMetaDataOnce() async {
    var data = context.read<TelemedDataProvider>();
    if (mounted) {
      await data.apiRouteAppointmentByDate(context: context);
    }
    if (mounted) {
      await data.apiRouteAppointment(context: context);
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    return Scaffold(
      key: _scaffoldKey,
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : ListView(
              padding: const EdgeInsets.all(15.0),
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "${TelemedStrings.greetings} ${data.selectedUserModel.firstName!} ${data.selectedUserModel.lastName!}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                      GoogleFonts.pacifico().fontFamily)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(TelemedStrings.supp,
                      style: data.getTelemedTextStyle(context).bodyLarge!),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(TelemedStrings.upcomingAppointments,
                      style: data.getTelemedTextStyle(context).titleMedium!),
                ),
                if (data.appointmentModelList.isEmpty)
                  ListTile(
                    title: Text(TelemedStrings.scheduledAppointments,
                        style: data.getTelemedTextStyle(context).titleMedium!),
                    subtitle: Text(TelemedStrings.bookNow,
                        style: data.getTelemedTextStyle(context).titleSmall!),
                    leading: const Icon(Icons.calendar_month),
                    // trailing: const Icon(Icons.arrow_forward_ios),
                    // onTap: () {},
                  ),
                if (data.appointmentModelList.isNotEmpty &&
                    data.selectedUserModel.userTypeId ==
                        TelemedSettings.patientId)
                  ListView.separated(
                    itemCount: data.appointmentModelList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(TelemedImage.doctorImage),
                        trailing: IconButton(
                          onPressed: () async {
                            RouteSettings settings = const RouteSettings(
                                name: BasePage.route, arguments: '');
                            data.setSelectedData(
                                model: ConversationModel(
                                    toUserId: data
                                        .appointmentModelList[index].doctorId));

                            MessageModel messageModel = MessageModel(
                              toUserId:
                                  data.selectedConversationModel!.toUserId,
                              sentDate: DateTime.now().toIso8601String(),
                              message: "Hi",
                            );
                            if (mounted) {
                              await data.apiRoutecreateMessages(
                                  context: context, messageModel: messageModel);
                            }

                            WidgetsBinding.instance
                                .addPostFrameCallback((_) async {
                              if (mounted) {
                                await DialogUtils.displayDialogOKCallBack(
                                    _scaffoldKey.currentContext!,
                                    TelemedStrings.alertTitle,
                                    TelemedStrings.alertMessageNavToMessages);
                              }
                            });
                          },
                          icon: const Icon(Icons.message),
                        ),
                        title: Text(
                            "${data.appointmentModelList[index].doctorUserFirstName} ${data.appointmentModelList[index].doctorUserLastName!}"),
                        subtitle: Text(data
                            .appointmentModelList[index].timeOfAppointment!),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                if (data.appointmentModelList.isNotEmpty &&
                    data.selectedUserModel.userTypeId ==
                        TelemedSettings.doctorId)
                  ListView.separated(
                    itemCount: data.appointmentModelList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(TelemedImage.doctorImage),
                        trailing: IconButton(
                          onPressed: () async {
                            RouteSettings settings = const RouteSettings(
                                name: BasePage.route, arguments: '');
                            data.setSelectedData(
                                model: ConversationModel(
                                    toUserId: data
                                        .appointmentModelList[index].doctorId));

                            MessageModel messageModel = MessageModel(
                              toUserId:
                                  data.selectedConversationModel!.toUserId,
                              sentDate: DateTime.now().toIso8601String(),
                              message: "Hi",
                            );
                            if (mounted) {
                              await data.apiRoutecreateMessages(
                                  context: context, messageModel: messageModel);
                            }

                            WidgetsBinding.instance
                                .addPostFrameCallback((_) async {
                              if (mounted) {
                                await DialogUtils.displayDialogOKCallBack(
                                    _scaffoldKey.currentContext!,
                                    TelemedStrings.alertTitle,
                                    TelemedStrings.alertMessageNavToMessages);
                              }
                            });
                          },
                          icon: const Icon(Icons.message),
                        ),
                        title: Text(
                            "${data.appointmentModelList[index].patientUserFirstName} ${data.appointmentModelList[index].patientUserLastName!}"),
                        subtitle: Text(data
                            .appointmentModelList[index].timeOfAppointment!),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                const Divider(),
                if (data.selectedUserModel.userTypeId ==
                    TelemedSettings.patientId)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(TelemedStrings.generalNeeds,
                        style: data.getTelemedTextStyle(context).titleSmall!),
                  ),
                if (data.selectedUserModel.userTypeId ==
                    TelemedSettings.patientId)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(TelemedStrings.gNeeds,
                        style: data.getTelemedTextStyle(context).bodySmall!),
                  ),
                if (data.selectedUserModel.userTypeId ==
                    TelemedSettings.patientId)
                  ListTile(
                    title: Text(TelemedStrings.bookNow,
                        style: data.getTelemedTextStyle(context).titleMedium!),
                    subtitle: Text(TelemedStrings.generalNeedsChoosePrimary,
                        style: data.getTelemedTextStyle(context).titleSmall!),
                    leading: const Icon(Icons.calendar_today),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        BookAppointmentsReasonForVisitPage.route,
                      );
                    },
                  ),
                if (data.selectedUserModel.userTypeId ==
                    TelemedSettings.patientId)
                  const Divider(),
                if (data.selectedUserModel.userTypeId ==
                    TelemedSettings.patientId)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(TelemedStrings.specificNeeds,
                        style: data.getTelemedTextStyle(context).titleSmall!),
                  ),
                if (data.selectedUserModel.userTypeId ==
                    TelemedSettings.patientId)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(TelemedStrings.specificNeedsPrimary,
                        style: data.getTelemedTextStyle(context).bodySmall!),
                  ),
                if (data.selectedUserModel.userTypeId ==
                    TelemedSettings.patientId)
                  ListTile(
                    title: Text(TelemedStrings.childrenHealth,
                        style: data.getTelemedTextStyle(context).titleMedium!),
                    subtitle: Text(TelemedStrings.childHealth,
                        style: data.getTelemedTextStyle(context).titleSmall!),
                    leading: const Icon(Icons.child_care),
                    // trailing: const Icon(Icons.arrow_forward_ios),
                    // onTap: () {},
                  ),
                if (data.selectedUserModel.userTypeId ==
                    TelemedSettings.patientId)
                  const Divider(),
                if (data.selectedUserModel.userTypeId ==
                    TelemedSettings.patientId)
                  ListTile(
                    title: Text(TelemedStrings.seniorHealth,
                        style: data.getTelemedTextStyle(context).titleMedium!),
                    subtitle: Text(TelemedStrings.senHealth,
                        style: data.getTelemedTextStyle(context).titleSmall!),
                    leading: const Icon(Icons.accessible),
                    // trailing: const Icon(Icons.arrow_forward_ios),
                    // onTap: () {},
                  ),
                if (data.selectedUserModel.userTypeId ==
                    TelemedSettings.patientId)
                  const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(TelemedStrings.reminders,
                      style: data.getTelemedTextStyle(context).titleMedium!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(TelemedStrings.dontForgetSchedule,
                      style: data.getTelemedTextStyle(context).titleSmall!),
                ),
                if (data.appointmentModelList.isEmpty)
                  ListTile(
                    title: Text(TelemedStrings.scheduledAppointments,
                        style: data.getTelemedTextStyle(context).titleMedium!),
                    subtitle: Text(TelemedStrings.bookNow,
                        style: data.getTelemedTextStyle(context).titleSmall!),
                    leading: const Icon(Icons.calendar_month),
                    // trailing: const Icon(Icons.arrow_forward_ios),
                    // onTap: () {},
                  ),
                if (data.selectedUserModel.userTypeId ==
                        TelemedSettings.doctorId &&
                    data.allAppointmentModelList.isNotEmpty)
                  ListView.separated(
                    itemCount: data.allAppointmentModelList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(TelemedImage.doctorImage),
                        trailing: IconButton(
                          onPressed: () async {
                            RouteSettings settings = const RouteSettings(
                                name: BasePage.route, arguments: '');
                            data.setSelectedData(
                                model: ConversationModel(
                                    toUserId: data
                                        .appointmentModelList[index].doctorId));

                            MessageModel messageModel = MessageModel(
                              toUserId:
                                  data.selectedConversationModel!.toUserId,
                              sentDate: DateTime.now().toIso8601String(),
                              message: "Hi",
                            );
                            if (mounted) {
                              await data.apiRoutecreateMessages(
                                  context: context, messageModel: messageModel);
                            }

                            WidgetsBinding.instance
                                .addPostFrameCallback((_) async {
                              if (mounted) {
                                await DialogUtils.displayDialogOKCallBack(
                                    _scaffoldKey.currentContext!,
                                    TelemedStrings.alertTitle,
                                    TelemedStrings.alertMessageNavToMessages);
                              }
                            });
                          },
                          icon: const Icon(Icons.message),
                        ),
                        title: Text(
                            "${data.allAppointmentModelList[index].patientUserFirstName} ${data.allAppointmentModelList[index].patientUserLastName!}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${data.allAppointmentModelList[index].dateOfAppointment} ${data.allAppointmentModelList[index].timeOfAppointment!}"),
                            OutlinedButton.icon(
                                onPressed: () {
                                  data.setSelectedData(
                                      model:
                                          data.allAppointmentModelList[index],
                                      typeOfUserModel:
                                          TelemedSettings.patientId);
                                  Navigator.pushNamed(
                                    context,
                                    PatientProfilePage.route,
                                  );
                                },
                                icon: const Icon(Icons.account_circle),
                                label: Text(TelemedStrings.profile)),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
              ],
            ),
    );
  }
}
