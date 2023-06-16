import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class BasicInformationPage extends StatefulWidget {
  const BasicInformationPage({Key? key}) : super(key: key);
  static const String route = '/basicInformation';

  @override
  BasicInformationPageState createState() => BasicInformationPageState();
}

class BasicInformationPageState extends State<BasicInformationPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Uri _url = Uri.parse("");

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

  ///Passing a key to access the validate function
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(TelemedSettings.appName),
      ),
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : ListView(
              padding: const EdgeInsets.all(15.0),
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.basicInformation,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.basicInfo,
                          style: Theme.of(context).textTheme.bodyLarge!),
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: IntrinsicWidth(
                        stepWidth: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return TelemedStrings.pleaseEnterText;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: TelemedStrings.firstName,
                                  border: const OutlineInputBorder(),
                                  prefixIcon:
                                      const Icon(Icons.account_circle_outlined),
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
                                decoration: InputDecoration(
                                  labelText: TelemedStrings.lastName,
                                  border: const OutlineInputBorder(),
                                  prefixIcon:
                                      const Icon(Icons.account_circle_outlined),
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
                                decoration: InputDecoration(
                                  labelText: TelemedStrings.address,
                                  border: const OutlineInputBorder(),
                                  prefixIcon:
                                      const Icon(Icons.account_circle_outlined),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await showDatePicker(
                                        context: context,
                                        initialDate: null == null
                                            ? DateTime.now()
                                            : DateTime.now(),
                                        firstDate: TelemedSettings.startDate,
                                        lastDate: TelemedSettings.endDate,
                                      ).then((selectedDate) {
                                        if (selectedDate != null) {
                                          setState(() {
                                            // _feedTransferInModel.dateReceived =
                                            //     selectedDate.toIso8601String();
                                          });
                                        }
                                      });
                                    },
                                    child:
                                        Text(TelemedStrings.selectDateOfBirth),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Text("01/03/1992"),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return TelemedStrings
                                                .pleaseEnterText;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText:
                                              TelemedStrings.bloodPressure,
                                          border: const OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return TelemedStrings
                                                .pleaseEnterText;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: TelemedStrings.bloodType,
                                          border: const OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SegmentedButton(segments: [
                                    ButtonSegment(value: 0, label: Text(TelemedStrings.male)),
                                    ButtonSegment(value: 1, label: Text(TelemedStrings.female)),
                                  ], selected: <int>{0},onSelectionChanged: (newValue){

                                  }),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: IntlPhoneField(
                                      decoration: InputDecoration(
                                        labelText:
                                        TelemedStrings.phoneNumber,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                      onCountryChanged: (phone) {
                                        // countryCodeController.text =
                                        // phone.countryCode!;
                                      },
                                      initialCountryCode:
                                      TelemedSettings.initialCountryCode,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {


                                        Navigator.pushNamed(
                                          context,
                                          BasicInformationPage.route,
                                        );



                                      },
                                      child: Text(TelemedStrings.proceed),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(TelemedStrings.phoneNote,
                                  style: Theme.of(context).textTheme.bodyLarge!),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
