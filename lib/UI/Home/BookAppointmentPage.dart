import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                            style:
                                data.getTelemedTextStyle(context).bodyMedium!),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.doctor,
                            style:
                                data.getTelemedTextStyle(context).bodyMedium!),
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
                            style:
                                data.getTelemedTextStyle(context).bodyMedium!),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(data.selectedCaderModel!.cader!,
                                style: data
                                    .getTelemedTextStyle(context)
                                    .bodyMedium!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "- ${TelemedStrings.videoConsultationFee} - (${TelemedSettings.costOfVideoConsultation})",
                                style: data
                                    .getTelemedTextStyle(context)
                                    .bodyMedium!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data.selectedUserModel.videoConsultationFee ==
                                      null
                                  ? ""
                                  : data
                                      .selectedUserModel.videoConsultationFee!,
                              style:
                                  data.getTelemedTextStyle(context).bodyMedium!,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await showDatePicker(
                                    context: context,
                                    initialDate: data.selectedAppointmentModel!
                                                .dateOfAppointment ==
                                            null
                                        ? DateTime.now()
                                        : DateFormat("yyyy-MM-dd").parse(data
                                            .selectedAppointmentModel!
                                            .dateOfAppointment!),
                                    firstDate: TelemedSettings.startDate,
                                    lastDate: TelemedSettings.endDate,
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      setState(() {
                                        data.selectedAppointmentModel!
                                                .dateOfAppointment =
                                            selectedDate.toIso8601String();
                                      });
                                    }
                                  });
                                },
                                child: Text(TelemedStrings.date),
                              ),
                            ),
                            data.selectedAppointmentModel!.dateOfAppointment ==
                                    null
                                ? Text('',
                                    style: data
                                        .getTelemedTextStyle(context)
                                        .titleLarge)
                                : Text(
                                    TelemedSettings.dateFormat.format(
                                        DateFormat("yyyy-MM-dd").parse(data
                                            .selectedAppointmentModel!
                                            .dateOfAppointment!)),
                                    style: data
                                        .getTelemedTextStyle(context)
                                        .titleLarge),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await showTimePicker(
                                    context: context,
                                    initialTime: data.selectedAppointmentModel!
                                                .timeOfAppointment ==
                                            null
                                        ? TimeOfDay.now()
                                        : TimeOfDay.fromDateTime(
                                            DateFormat("h:mm a").parse(data
                                                .selectedAppointmentModel!
                                                .timeOfAppointment!)),
                                  ).then((selectedTime) {
                                    if (selectedTime != null) {
                                      setState(() {
                                        data.selectedAppointmentModel!
                                                .timeOfAppointment =
                                            selectedTime.format(context);
                                      });
                                    }
                                  });
                                },
                                child: Text(TelemedStrings.time),
                              ),
                            ),
                            data.selectedAppointmentModel!.timeOfAppointment ==
                                    null
                                ? Text('',
                                    style: data
                                        .getTelemedTextStyle(context)
                                        .titleLarge)
                                : Text(
                                    data.selectedAppointmentModel!
                                        .timeOfAppointment!,
                                    style: data
                                        .getTelemedTextStyle(context)
                                        .titleLarge),
                          ],
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "${TelemedStrings.doctorsPhoneNumber} : ",
                                style: data
                                    .getTelemedTextStyle(context)
                                    .bodyMedium!),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.phone),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: data.selectedUserModel.phone == null
                                ? const SelectableText("")
                                : SelectableText(data.selectedUserModel.phone!),
                          ),
                        ],
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
                              data.selectedAppointmentModel!.complaint,
                          onChanged: (newValue) {
                            data.selectedAppointmentModel!.complaint = newValue;
                          },
                          decoration: InputDecoration(
                            labelText: TelemedStrings.complaints,
                            hintText: TelemedStrings.patientComplaintsHint,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.notes),
                          ),
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
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            // for below version 2 use this
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            // for version 2 and greater youcan also use this
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          initialValue:
                              data.selectedAppointmentModel!.pwdIdNumber == null
                                  ? ""
                                  : data.selectedAppointmentModel!.pwdIdNumber
                                      .toString(),
                          onChanged: (newValue) {
                            data.selectedAppointmentModel!.pwdIdNumber =
                                int.tryParse(newValue);
                          },
                          decoration: InputDecoration(
                            labelText: TelemedStrings.pwdIDnumber,
                            hintText: TelemedStrings.pwdIDnumber,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.numbers),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await showDatePicker(
                                    context: context,
                                    initialDate: data.selectedAppointmentModel!
                                                .pwdIdExpirationDate ==
                                            null
                                        ? DateTime.now()
                                        : DateFormat("yyyy-MM-dd").parse(data
                                            .selectedAppointmentModel!
                                            .pwdIdExpirationDate!),
                                    firstDate: TelemedSettings.startDate,
                                    lastDate: TelemedSettings.endDate,
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      setState(() {
                                        data.selectedAppointmentModel!
                                                .pwdIdExpirationDate =
                                            selectedDate.toIso8601String();
                                      });
                                    }
                                  });
                                },
                                child: Text(TelemedStrings.pwdExpirationDate),
                              ),
                            ),
                            data.selectedAppointmentModel!
                                        .pwdIdExpirationDate ==
                                    null
                                ? Text('',
                                    style: data
                                        .getTelemedTextStyle(context)
                                        .titleLarge)
                                : Text(
                                    TelemedSettings.dateFormat.format(
                                        DateFormat("yyyy-MM-dd").parse(data
                                            .selectedAppointmentModel!
                                            .pwdIdExpirationDate!)),
                                    style: data
                                        .getTelemedTextStyle(context)
                                        .titleLarge),
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
                          initialValue: data
                              .selectedAppointmentModel!.paymentReferenceNumber,
                          onChanged: (newValue) {
                            data.selectedAppointmentModel!
                                .paymentReferenceNumber = newValue;
                          },
                          decoration: InputDecoration(
                            labelText: TelemedStrings.paymentReferenceNumber,
                            hintText: TelemedStrings.paymentReferenceNumber,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.numbers),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          data.selectedAppointmentModel!.caderId = data.selectedCaderModel!.id;
          data.selectedAppointmentModel!.doctorId =
              data.selectedDoctorModel!.id;
          data.selectedAppointmentModel!.patientId = data.selectedUserModel.id;
          data.selectedAppointmentModel!.caderId = data.selectedCaderModel!.id;
          await data.apiRouteCreateAppointment(
              context: context,
              appointmentModel: data.selectedAppointmentModel!);
        },
        label: Text(TelemedStrings.bookAnAppointment),
      ),
    );
  }
}
