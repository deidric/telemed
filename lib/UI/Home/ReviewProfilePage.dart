import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
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
                            style: Theme.of(context).textTheme.bodyMedium!),
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
                            style: Theme.of(context).textTheme.titleSmall!),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(data.selectedHealthProfileModel!
                                  .symptomsModelList!
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
                            style: Theme.of(context).textTheme.titleSmall!),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                data.selectedHealthProfileModel!.medications!,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.drugAllergies,
                            style: Theme.of(context).textTheme.titleSmall!),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                data.selectedHealthProfileModel!
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
                                    data.selectedHealthProfileModel!
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
                            style: Theme.of(context).textTheme.titleSmall!),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(data.selectedHealthProfileModel!
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
                                    data.selectedHealthProfileModel!
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
                            style: Theme.of(context).textTheme.titleSmall!),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(data.selectedHealthProfileModel!
                                  .familyMedicalConditionsModelList!
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
                                    data.selectedHealthProfileModel!
                                        .familyMedicalConditionComplaint!,
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
                            style: Theme.of(context).textTheme.titleSmall!),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(data.selectedHealthProfileModel!
                                  .surgeriesModelList!
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
                                    data.selectedHealthProfileModel!
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
        onPressed: () {
          // Navigator.pushNamed(
          //   context,
          //   CadersPage.route,
          // );
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
