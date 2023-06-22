import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/SignInSignUp/HealthInsurancePage.dart';
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
                                initialValue: data.selectedUserModel.firstName,
                                onChanged: (newValue) {
                                  data.selectedUserModel.firstName = newValue;
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
                                initialValue: data.selectedUserModel.lastName,
                                onChanged: (newValue) {
                                  data.selectedUserModel.lastName = newValue;
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
                                onChanged: (newValue) {
                                  data.selectedUserModel.address = newValue;
                                },
                                initialValue: data.selectedUserModel.address,
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
                                        initialDate: data
                                                    .selectedUserModel.dob ==
                                                null
                                            ? DateTime.now()
                                            : DateFormat("yyyy-MM-dd").parse(
                                                data.selectedUserModel.dob!),
                                        firstDate: TelemedSettings.startDate,
                                        lastDate: TelemedSettings.endDate,
                                      ).then((selectedDate) {
                                        if (selectedDate != null) {
                                          setState(() {
                                            data.selectedUserModel.dob =
                                                selectedDate.toIso8601String();
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
                                    child: data.selectedUserModel.dob == null
                                        ? Text('',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge)
                                        : Text(
                                            TelemedSettings.dateFormat.format(
                                                DateFormat("yyyy-MM-dd").parse(
                                                    data.selectedUserModel
                                                        .dob!)),
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
                                        initialValue: data
                                            .selectedUserModel.bloodPressure,
                                        onChanged: (newValue) {
                                          data.selectedUserModel.bloodPressure =
                                              newValue;
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
                                        initialValue:
                                            data.selectedUserModel.bloodType,
                                        onChanged: (newValue) {
                                          data.selectedUserModel.bloodType =
                                              newValue;
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
                                  child: SegmentedButton(
                                    segments: [
                                      ButtonSegment(
                                        value: TelemedStrings.male,
                                        label: Text(TelemedStrings.male),
                                        icon: const Icon(Icons.male),
                                      ),
                                      ButtonSegment(
                                        value: TelemedStrings.female,
                                        label: Text(TelemedStrings.female),
                                        icon: const Icon(Icons.female),
                                      ),
                                    ],
                                    selected: <String>{
                                      data.selectedUserModel.gender == null
                                          ? TelemedStrings.male
                                          : data.selectedUserModel.gender!
                                    },
                                    onSelectionChanged: (newValue) {
                                      data.selectedUserModel.gender =
                                          newValue.first;
                                      setState(() {});
                                    },
                                  ),
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
                                        labelText: TelemedStrings.phoneNumber,
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                      onChanged: (phone) {
                                        data.selectedUserModel.phone =
                                            phone.completeNumber;
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
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          Navigator.pushNamed(
                                            context,
                                            HealthInsurancePage.route,
                                          );
                                        }
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
                                  style:
                                      Theme.of(context).textTheme.bodyLarge!),
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
