import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/PopupMenuButton.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class PatientProfilePage extends StatefulWidget {
  const PatientProfilePage({Key? key}) : super(key: key);

  static const String route = '/basePage/patientProfilePage';

  @override
  PatientProfilePageState createState() => PatientProfilePageState();
}

class PatientProfilePageState extends State<PatientProfilePage> {
  final Uri _url = Uri.parse("");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadAllAppMetaDataOnce();
    });
  }

  Future<void> loadAllAppMetaDataOnce() async {
    var data = context.read<TelemedDataProvider>();
    if (mounted) {
      // await data.apiRouteMessagesByConversationId(context: context);
      await data.apiRouteAppointment(context: context);
    }
  }

  final ScrollController _scrollController = ScrollController();

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(TelemedStrings.patientProfile), actions: [
        const AppBarActionsPopupMenuButton(),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () async {
            // await data.apiRouteMessagesByConversationId(context: context);
          },
        )
      ]),
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : ListView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text(
                      "${data.selectedAppointmentModel!.patientUserFirstName!} ${data.selectedAppointmentModel!.patientUserLastName!}",
                      style: data.getTelemedTextStyle(context).titleMedium!),
                  leading: const Icon(Icons.sick_outlined),
                  onTap: () {},
                ),
                // Card(
                //   clipBehavior: Clip.antiAlias,
                //   color: getColour(),
                //   child: Column(
                //     children: [
                //       ListTile(
                //         leading: getIcon(),
                //         title: Text(data.selectedMainReasonForVisit!),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(TelemedStrings.symptoms,
                      style: data.getTelemedTextStyle(context).titleSmall!),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(data
                            .selectedAppointmentModel!.symptomsModelList!
                            .map((e) => e.symptom)
                            .toList()
                            .join(", ")),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(TelemedStrings.medications,
                      style: data.getTelemedTextStyle(context).titleSmall!),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          data.selectedAppointmentModel!.medications == null
                              ? ""
                              : data.selectedAppointmentModel!.medications!,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(TelemedStrings.drugAllergies,
                      style: data.getTelemedTextStyle(context).titleSmall!),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          data.selectedAppointmentModel!.drugAllergiesModelList!
                              .map((e) => e.drugName)
                              .toList()
                              .join(", "),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TelemedStrings.complaints,
                                style: Theme.of(context).textTheme.titleSmall!),
                            Text(
                              data.selectedAppointmentModel!
                                          .allergicToDrugsComplaint ==
                                      null
                                  ? ""
                                  : data.selectedAppointmentModel!
                                      .allergicToDrugsComplaint!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(TelemedStrings.medicalConditions,
                      style: data.getTelemedTextStyle(context).titleSmall!),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(data.selectedAppointmentModel!
                            .medicalConditionsModelList!
                            .map((e) => e.medicalCondition)
                            .toList()
                            .join(", ")),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TelemedStrings.complaints,
                                style: Theme.of(context).textTheme.titleSmall!),
                            Text(
                              data.selectedAppointmentModel!
                                          .medicalConditionComplaint ==
                                      null
                                  ? ""
                                  : data.selectedAppointmentModel!
                                      .medicalConditionComplaint!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(TelemedStrings.familyMedicalConditions,
                      style: data.getTelemedTextStyle(context).titleSmall!),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(data.selectedAppointmentModel!
                            .famMedicalConditionsModelList!
                            .map((e) => e.medicalCondition)
                            .toList()
                            .join(", ")),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TelemedStrings.complaints,
                                style: Theme.of(context).textTheme.titleSmall!),
                            Text(
                              data.selectedAppointmentModel!
                                          .familyMedicalConditionComplaint ==
                                      null
                                  ? ""
                                  : data.selectedAppointmentModel!
                                      .medicalConditionComplaint!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(TelemedStrings.surgeries,
                      style: data.getTelemedTextStyle(context).titleSmall!),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(data
                            .selectedAppointmentModel!.surgeriesModelList!
                            .map((e) => e.surgeryName)
                            .toList()
                            .join(", ")),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TelemedStrings.complaints,
                                style: Theme.of(context).textTheme.titleSmall!),
                            Text(
                              data.selectedAppointmentModel!.surgeryComplaint ==
                                      null
                                  ? ""
                                  : data.selectedAppointmentModel!
                                      .surgeryComplaint!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Color getColour() {
    final data = context.watch<TelemedDataProvider>();
    if (data.selectedMainReasonForVisit == TelemedStrings.newHealthConcern) {
      return Colors.redAccent;
    }
    if (data.selectedMainReasonForVisit == TelemedStrings.routineCheckup) {
      return Colors.blue;
    }
    if (data.selectedMainReasonForVisit == TelemedStrings.prescRefills) {
      return Colors.deepPurpleAccent;
    }
    if (data.selectedMainReasonForVisit == TelemedStrings.mentalHealthConcern) {
      return Colors.blueAccent;
    }
    if (data.selectedMainReasonForVisit == TelemedStrings.otherMedReason) {
      return Colors.grey;
    } else {
      return Colors.redAccent;
    }
  }

  Icon getIcon() {
    final data = context.watch<TelemedDataProvider>();
    if (data.selectedMainReasonForVisit == TelemedStrings.newHealthConcern) {
      return const Icon(Icons.emergency);
    }
    if (data.selectedMainReasonForVisit == TelemedStrings.routineCheckup) {
      return const Icon(Icons.verified);
    }
    if (data.selectedMainReasonForVisit == TelemedStrings.prescRefills) {
      return const Icon(Icons.medication);
    }
    if (data.selectedMainReasonForVisit == TelemedStrings.mentalHealthConcern) {
      return const Icon(Icons.theater_comedy);
    }
    if (data.selectedMainReasonForVisit == TelemedStrings.otherMedReason) {
      return const Icon(Icons.help_center);
    } else {
      return const Icon(Icons.emergency);
    }
  }
}
