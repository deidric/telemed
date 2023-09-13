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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadAllAppMetaDataOnce();
    });
  }

  Future<void> loadAllAppMetaDataOnce() async {
    var data = context.read<TelemedDataProvider>();
    await data.apiRouteDoctorSpecialities(context: context);
    if (mounted) {
      await data.apiRouteDoctorQualifications(context: context);
    }
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
                    if (data.selectedUserModel.userTypeId ==
                        TelemedSettings.doctorId)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "${TelemedStrings.doctor} ${TelemedStrings.basicInformation}",
                            style: data
                                .getTelemedTextStyle(context)
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                    if (data.selectedUserModel.userTypeId ==
                        TelemedSettings.patientId)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "${TelemedStrings.patient} ${TelemedStrings.basicInformation}",
                            style: data
                                .getTelemedTextStyle(context)
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.basicInfo,
                          style: data.getTelemedTextStyle(context).bodyLarge!),
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
                            if (data.selectedUserModel.userTypeId == 3)
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
                                    prefixIcon: const Icon(
                                        Icons.account_circle_outlined),
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
                                        left: 8.0, right: 8.0, bottom: 16.0),
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
                            if (data.selectedUserModel.userTypeId ==
                                TelemedSettings.patientId)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          initialValue: data
                                              .selectedUserModel.bloodPressure,
                                          onChanged: (newValue) {
                                            data.selectedUserModel
                                                .bloodPressure = newValue;
                                          },
                                          keyboardType: TextInputType.phone,
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
                                          ? data.selectedUserModel.gender =
                                              TelemedStrings.male
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
                            if (data.selectedUserModel.userTypeId ==
                                TelemedSettings.doctorId)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: DropdownMenu(
                                  menuHeight: 250,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  leadingIcon: const Icon(
                                    Icons.menu_book,
                                  ),
                                  hintText: TelemedStrings.qualifications,
                                  label: Text(TelemedStrings.qualifications),
                                  initialSelection:
                                      data.selectedDoctorQualificationsModel ==
                                              null
                                          ? null
                                          : data
                                              .selectedDoctorQualificationsModel!
                                              .id,
                                  onSelected: (int? selectedId) {
                                    data.setSelectedData(
                                        model: data
                                            .doctorQualificationsModelList
                                            .firstWhere((element) =>
                                                element.id == selectedId));
                                    data.selectedUserModel.qualificationId =
                                        selectedId;
                                  },
                                  dropdownMenuEntries: () {
                                    List<DropdownMenuEntry<int>>
                                        dropdownMenuEntryList = [];
                                    for (var element
                                        in data.doctorQualificationsModelList) {
                                      dropdownMenuEntryList.add(
                                        DropdownMenuEntry(
                                          value: element.id!,
                                          label: element.qualification!,
                                        ),
                                      );
                                    }
                                    return dropdownMenuEntryList;
                                  }(),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: IntlPhoneField(
                                      initialValue:
                                          data.selectedUserModel.phone,
                                      decoration: InputDecoration(
                                        labelText: TelemedStrings.phoneNumber,
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                      onChanged: (phone) {
                                        data.selectedUserModel.phone =
                                            phone.number;
                                      },
                                      initialCountryCode:
                                          TelemedSettings.initialCountryCode,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (data.selectedUserModel.userTypeId ==
                                TelemedSettings.doctorId)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          initialValue: data.selectedUserModel
                                              .videoConsultationFee,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return TelemedStrings
                                                  .pleaseEnterText;
                                            }
                                            if (double.tryParse(value) ==
                                                null) {
                                              return TelemedStrings
                                                  .pleaseEnterNumber;
                                            }
                                            return null;
                                          },
                                          onChanged: (newValue) {
                                            data.selectedUserModel
                                                    .videoConsultationFee =
                                                newValue;
                                          },
                                          decoration: InputDecoration(
                                            labelText: TelemedStrings
                                                .videoConsultationFee,
                                            border: const OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(TelemedStrings.phoneNote,
                                  style: data
                                      .getTelemedTextStyle(context)
                                      .bodySmall!),
                            ),
                            if (data.selectedUserModel.userTypeId ==
                                TelemedSettings.doctorId)
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
                                  initialValue: data.selectedUserModel
                                      .medicalSchoolOfGraduation,
                                  onChanged: (newValue) {
                                    data.selectedUserModel
                                        .medicalSchoolOfGraduation = newValue;
                                  },
                                  decoration: InputDecoration(
                                    labelText: TelemedStrings
                                        .medicalSchoolOfGraduation,
                                    hintText: TelemedStrings
                                        .medicalSchoolOfGraduationHint,
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Icons.menu_book),
                                  ),
                                ),
                              ),
                            if (data.selectedUserModel.userTypeId ==
                                TelemedSettings.doctorId)
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "${TelemedStrings.boardCertified} : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!),
                                  ),
                                  Expanded(
                                    child: SegmentedButton(
                                      segments: [
                                        ButtonSegment(
                                          value: TelemedStrings.checkYes,
                                          label: Text(TelemedStrings.checkYes),
                                        ),
                                        ButtonSegment(
                                          value: TelemedStrings.checkNo,
                                          label: Text(TelemedStrings.checkNo),
                                        ),
                                      ],
                                      selected: <String>{
                                        data.selectedUserModel.boardCertified ==
                                                null
                                            ? () {
                                                data.selectedUserModel
                                                    .boardCertified = 1;
                                                return TelemedStrings.checkYes;
                                              }()
                                            : data.selectedUserModel
                                                        .boardCertified! ==
                                                    1
                                                ? TelemedStrings.checkYes
                                                : TelemedStrings.checkNo
                                      },
                                      onSelectionChanged: (newValue) {
                                        if (newValue.first ==
                                            TelemedStrings.checkYes) {
                                          data.selectedUserModel
                                              .boardCertified = 1;
                                        } else {
                                          data.selectedUserModel
                                              .boardCertified = 0;
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            if (data.selectedUserModel.userTypeId ==
                                TelemedSettings.doctorId)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: DropdownMenu(
                                  menuHeight: 250,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  leadingIcon: const Icon(
                                    Icons.medical_services,
                                  ),
                                  hintText: TelemedStrings.speciality,
                                  label: Text(TelemedStrings.speciality),
                                  initialSelection:
                                      data.selectedDoctorSpecialitiesModel ==
                                              null
                                          ? null
                                          : data
                                              .selectedDoctorSpecialitiesModel!
                                              .id,
                                  onSelected: (int? selectedId) {
                                    data.setSelectedData(
                                        model: data.doctorSpecialitiesModelList
                                            .firstWhere((element) =>
                                                element.id == selectedId));
                                    data.selectedUserModel.specialityId =
                                        selectedId;
                                  },
                                  dropdownMenuEntries: () {
                                    List<DropdownMenuEntry<int>>
                                        dropdownMenuEntryList = [];
                                    for (var element
                                        in data.doctorSpecialitiesModelList) {
                                      dropdownMenuEntryList.add(
                                        DropdownMenuEntry(
                                          value: element.id!,
                                          label: element.speciality!,
                                        ),
                                      );
                                    }
                                    return dropdownMenuEntryList;
                                  }(),
                                ),
                              ),
                            if (data.selectedUserModel.userTypeId ==
                                TelemedSettings.doctorId)
                              Row(
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
                                        initialValue: data.selectedUserModel
                                            .pdeaRegistrationNumber,
                                        onChanged: (newValue) {
                                          data.selectedUserModel
                                                  .pdeaRegistrationNumber =
                                              newValue;
                                        },
                                        decoration: InputDecoration(
                                          labelText: TelemedStrings
                                              .pdeaRegistrationNumber,
                                          border: const OutlineInputBorder(),
                                          prefixIcon: const Icon(Icons.numbers),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (data.selectedUserModel.userTypeId ==
                                TelemedSettings.doctorId)
                              Column(
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
                                      initialValue: data.selectedUserModel
                                          .currentMedicalLicenseNumber,
                                      onChanged: (newValue) {
                                        data.selectedUserModel
                                                .currentMedicalLicenseNumber =
                                            newValue;
                                      },
                                      decoration: InputDecoration(
                                        labelText: TelemedStrings
                                            .currentMedicalLicenseNumber,
                                        border: const OutlineInputBorder(),
                                        prefixIcon: const Icon(Icons.numbers),
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
                                                          .selectedUserModel
                                                          .currentMedicalLicenseNumberDateIssued ==
                                                      null
                                                  ? DateTime.now()
                                                  : DateFormat("yyyy-MM-dd")
                                                      .parse(data
                                                          .selectedUserModel
                                                          .currentMedicalLicenseNumberDateIssued!),
                                              firstDate:
                                                  TelemedSettings.startDate,
                                              lastDate: TelemedSettings.endDate,
                                            ).then((selectedDate) {
                                              if (selectedDate != null) {
                                                setState(() {
                                                  data.selectedUserModel
                                                          .currentMedicalLicenseNumberDateIssued =
                                                      selectedDate
                                                          .toIso8601String();
                                                });
                                              }
                                            });
                                          },
                                          child:
                                              Text(TelemedStrings.dateIssued),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              bottom: 16.0),
                                          child: data.selectedUserModel
                                                      .currentMedicalLicenseNumberDateIssued ==
                                                  null
                                              ? Text('',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge)
                                              : Text(
                                                  TelemedSettings.dateFormat
                                                      .format(DateFormat(
                                                              "yyyy-MM-dd")
                                                          .parse(data
                                                              .selectedUserModel
                                                              .currentMedicalLicenseNumberDateIssued!)),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
