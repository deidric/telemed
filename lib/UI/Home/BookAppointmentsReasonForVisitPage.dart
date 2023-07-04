import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/CadersPage.dart';
import 'package:telemed/settings.dart';

class BookAppointmentsReasonForVisitPage extends StatefulWidget {
  const BookAppointmentsReasonForVisitPage({Key? key}) : super(key: key);
  static const String route = '/bookAppointmentsReasonForVisitPage';

  @override
  BookAppointmentsReasonForVisitPageState createState() =>
      BookAppointmentsReasonForVisitPageState();
}

class BookAppointmentsReasonForVisitPageState
    extends State<BookAppointmentsReasonForVisitPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Uri _url = Uri.parse("");
  bool cbHealthConcern = false;
  bool cbRoutine = false;
  bool cbPrescription = false;
  bool cbGenMentalHealth = false;
  bool cbOtherMedReasons = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> signIn(BuildContext context) async {
    var data = context.read<TelemedDataProvider>();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // UserModel userModel = UserModel(
      //     email: emailController.text.trim(),
      //     password: passwordController.text.trim());
      //
      // await data.apiRouteLogin(context: context, userModel: userModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(TelemedStrings.reasonOfVisit),
      ),
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : ListView(
              padding: const EdgeInsets.all(15.0),
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.patientLocation,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.patientConnection,
                          style: Theme.of(context).textTheme.bodyLarge!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on),
                          Text("London, United Kingdom",
                              style: Theme.of(context).textTheme.bodyLarge!),
                          TextButton(
                              onPressed: () {},
                              child: Text("(${TelemedStrings.change})")),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.whatIsReasonOfVisit,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CheckboxListTile(
                            tileColor: Colors.redAccent,
                            value: cbHealthConcern,
                            onChanged: (bool? value) {
                              setState(() {
                                cbHealthConcern = value!;
                                if (value) {
                                  cbRoutine = false;
                                  cbPrescription = false;
                                  cbGenMentalHealth = false;
                                  cbOtherMedReasons = false;
                                }
                              });
                            },
                            secondary: const Icon(Icons.emergency),
                            isThreeLine: true,
                            title: Text(
                              TelemedStrings.newHealthConcern,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            subtitle: Text(TelemedStrings.findDoctor,
                                style: Theme.of(context).textTheme.bodySmall!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CheckboxListTile(
                            tileColor: Colors.blue,
                            value: cbRoutine,
                            onChanged: (bool? value) {
                              setState(() {
                                cbRoutine = value!;
                                if (value) {
                                  cbHealthConcern = false;
                                  cbPrescription = false;
                                  cbGenMentalHealth = false;
                                  cbOtherMedReasons = false;
                                }
                              });
                            },
                            secondary: const Icon(Icons.verified),
                            isThreeLine: true,
                            title: Text(
                              TelemedStrings.routineCheckup,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            subtitle: Text(TelemedStrings.findDoctor,
                                style: Theme.of(context).textTheme.bodySmall!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CheckboxListTile(
                            tileColor: Colors.deepPurpleAccent,
                            value: cbPrescription,
                            onChanged: (bool? value) {
                              setState(() {
                                cbPrescription = value!;
                                if (value) {
                                  cbHealthConcern = false;
                                  cbRoutine = false;
                                  cbGenMentalHealth = false;
                                  cbOtherMedReasons = false;
                                }
                              });
                            },
                            secondary: const Icon(Icons.medication),
                            isThreeLine: true,
                            title: Text(
                              TelemedStrings.prescRefills,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            subtitle: Text(TelemedStrings.talkToPharmacist,
                                style: Theme.of(context).textTheme.bodySmall!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CheckboxListTile(
                            tileColor: Colors.blueAccent,
                            value: cbGenMentalHealth,
                            onChanged: (bool? value) {
                              setState(() {
                                cbGenMentalHealth = value!;
                                if (value) {
                                  cbHealthConcern = false;
                                  cbRoutine = false;
                                  cbPrescription = false;
                                  cbOtherMedReasons = false;
                                }
                              });
                            },
                            secondary: const Icon(Icons.theater_comedy),
                            isThreeLine: true,
                            title: Text(
                              TelemedStrings.mentalHealthConcern,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            subtitle: Text(TelemedStrings.findDoctor,
                                style: Theme.of(context).textTheme.bodySmall!),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CheckboxListTile(
                            tileColor: Colors.grey,
                            value: cbOtherMedReasons,
                            onChanged: (bool? value) {
                              setState(() {
                                cbOtherMedReasons = value!;
                                if (value) {
                                  cbHealthConcern = false;
                                  cbRoutine = false;
                                  cbPrescription = false;
                                  cbGenMentalHealth = false;
                                }
                              });
                            },
                            secondary: const Icon(Icons.help_center),
                            isThreeLine: true,
                            title: Text(
                              TelemedStrings.otherMedReason,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            subtitle: Text(TelemedStrings.findDoctor,
                                style: Theme.of(context).textTheme.bodySmall!),
                          ),
                        ),
                      ],
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      TelemedStrings.medEmergency,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: !cbHealthConcern &&
                !cbRoutine &&
                !cbPrescription &&
                !cbGenMentalHealth &&
                !cbOtherMedReasons
            ? null
            : () {
                if (cbHealthConcern) {
                  data.setSelectedMainReasonForVisit(
                      selectedMainReasonForVisit:
                          TelemedStrings.newHealthConcern);
                }
                if (cbRoutine) {
                  data.setSelectedMainReasonForVisit(
                      selectedMainReasonForVisit:
                          TelemedStrings.routineCheckup);
                }
                if (cbPrescription) {
                  data.setSelectedMainReasonForVisit(
                      selectedMainReasonForVisit: TelemedStrings.prescRefills);
                }
                if (cbGenMentalHealth) {
                  data.setSelectedMainReasonForVisit(
                      selectedMainReasonForVisit:
                          TelemedStrings.mentalHealthConcern);
                }
                if (cbOtherMedReasons) {
                  data.setSelectedMainReasonForVisit(
                      selectedMainReasonForVisit:
                          TelemedStrings.otherMedReason);
                }
                Navigator.pushNamed(
                  context,
                  CadersPage.route,
                );
              },
        label: Text(TelemedStrings.selectCaderHeader),
      ),
    );
  }
}
