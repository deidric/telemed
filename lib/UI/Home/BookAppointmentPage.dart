import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({Key? key}) : super(key: key);
  static const String route = '/bookAppointmentPage';

  @override
  BookAppointmentPageState createState() => BookAppointmentPageState();
}

class BookAppointmentPageState extends State<BookAppointmentPage>
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
        title: Text(TelemedStrings.bookingHeader),
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
                        child: Text(TelemedStrings.bookingNote,
                            style: Theme.of(context).textTheme.bodyMedium!),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.doctor,
                            style: Theme.of(context).textTheme.bodyMedium!),
                      ),
                      ListTile(
                        leading: const Icon(Icons.account_circle),
                        title: Text(
                          "${data.selectedDoctorModel!.firstName!} ${data.selectedDoctorModel!.lastName!}",
                        ),
                        subtitle: Text(
                          "${data.selectedDoctorModel!.firstName!} ${data.selectedDoctorModel!.lastName!}",
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.serviceLabel,
                            style: Theme.of(context).textTheme.bodyMedium!),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(data.selectedCaderModel!.cader!,
                                style: Theme.of(context).textTheme.bodyMedium!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "- ${TelemedStrings.videoConsultationFee} - ",
                                style: Theme.of(context).textTheme.bodyMedium!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data.selectedUserModel.videoConsultationFee ==
                                      null
                                  ? ""
                                  : data
                                      .selectedUserModel.videoConsultationFee!,
                              style: Theme.of(context).textTheme.bodyMedium!,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate: data.selectedUserModel
                                              .currentMedicalLicenseNumberDateIssued ==
                                          null
                                      ? DateTime.now()
                                      : DateFormat("yyyy-MM-dd").parse(data
                                          .selectedUserModel
                                          .currentMedicalLicenseNumberDateIssued!),
                                  firstDate: TelemedSettings.startDate,
                                  lastDate: TelemedSettings.endDate,
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    setState(() {
                                      data.selectedUserModel
                                              .currentMedicalLicenseNumberDateIssued =
                                          selectedDate.toIso8601String();
                                    });
                                  }
                                });
                              },
                              child: Text(TelemedStrings.date),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 16.0),
                              child: data.selectedUserModel
                                          .currentMedicalLicenseNumberDateIssued ==
                                      null
                                  ? Text('',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge)
                                  : Text(
                                      TelemedSettings.dateFormat.format(
                                          DateFormat("yyyy-MM-dd").parse(data
                                              .selectedUserModel
                                              .currentMedicalLicenseNumberDateIssued!)),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    setState(() {
                                      // data.selectedUserModel
                                      //     .currentMedicalLicenseNumberDateIssued =
                                      //     selectedDate
                                      //         .toIso8601String();
                                    });
                                  }
                                });
                              },
                              child: Text(TelemedStrings.time),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 16.0),
                              child: data.selectedUserModel
                                          .currentMedicalLicenseNumberDateIssued ==
                                      null
                                  ? Text('',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge)
                                  : Text(
                                      TelemedSettings.dateFormat.format(
                                          DateFormat("yyyy-MM-dd").parse(data
                                              .selectedUserModel
                                              .currentMedicalLicenseNumberDateIssued!)),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return TelemedStrings.pleaseEnterText;
                            }
                            return null;
                          },
                          maxLines: 5,
                          initialValue:
                              data.selectedUserModel.medicalSchoolOfGraduation,
                          onChanged: (newValue) {
                            data.selectedUserModel.medicalSchoolOfGraduation =
                                newValue;
                          },
                          decoration: InputDecoration(
                            labelText: TelemedStrings.complaints,
                            hintText:
                                TelemedStrings.patientComplaintsHint,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.notes),
                          ),
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
        label: Text(TelemedStrings.healthProfile),
      ),
    );
  }
}
