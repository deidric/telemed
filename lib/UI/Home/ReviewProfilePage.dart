import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/BookAppointmentPage.dart';
import 'package:telemed/UI/SignInSignUp/SignInPage.dart';
import 'package:telemed/settings.dart';

class ReviewProfilePage extends StatefulWidget {
  const ReviewProfilePage({Key? key}) : super(key: key);
  static const String route = '/reviewProfilePage';

  @override
  ReviewProfilePageState createState() => ReviewProfilePageState();
}

class ReviewProfilePageState extends State<ReviewProfilePage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Uri _url = Uri.parse("");
  int oneValue = 1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadAllAppMetaDataOnce();
    });
  }

  Future<void> loadAllAppMetaDataOnce() async {
    var data = context.read<TelemedDataProvider>();
    await data.apiRouteDoctorsByCaderId(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(TelemedStrings.reviewProfile),
      ),
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 150),
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.reviewprofileText,
                            style:
                                data.getTelemedTextStyle(context).bodyMedium!),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        color: getColour(),
                        child: Column(
                          children: [
                            ListTile(
                              leading: getIcon(),
                              title: Text(data.selectedMainReasonForVisit!),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.symptoms,
                            style:
                                data.getTelemedTextStyle(context).titleSmall!),
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
                            style:
                                data.getTelemedTextStyle(context).titleSmall!),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                data.selectedAppointmentModel!.medications ==
                                        null
                                    ? ""
                                    : data
                                        .selectedAppointmentModel!.medications!,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.drugAllergies,
                            style:
                                data.getTelemedTextStyle(context).titleSmall!),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                data.selectedAppointmentModel!
                                    .drugAllergiesModelList!
                                    .map((e) => e.drugName)
                                    .toList()
                                    .join(", "),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(TelemedStrings.complaints,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!),
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
                            style:
                                data.getTelemedTextStyle(context).titleSmall!),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!),
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
                            style:
                                data.getTelemedTextStyle(context).titleSmall!),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!),
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
                            style:
                                data.getTelemedTextStyle(context).titleSmall!),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!),
                                  Text(
                                    data.selectedAppointmentModel!
                                                .surgeryComplaint ==
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
                ],
              )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          data.selectedAppointmentModel!.caderId = data.selectedCaderModel!.id;
          RouteSettings settings =
              const RouteSettings(name: SignInPage.route, arguments: '');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  settings: settings,
                  builder: (context) => const BookAppointmentPage()),
              (route) => false);
          // await data.apiRouteCreateHealthProfile(
          //     context: context,
          //     healthProfileModel: data.selectedHealthProfileModel!);
        },
        label: Text(TelemedStrings.bookNow),
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
