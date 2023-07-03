import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/ReviewProfilePage.dart';
import 'package:telemed/settings.dart';

class HealthProfilePage extends StatefulWidget {
  const HealthProfilePage({Key? key}) : super(key: key);
  static const String route = '/healthProfilePage';

  @override
  HealthProfilePageState createState() => HealthProfilePageState();
}

class HealthProfilePageState extends State<HealthProfilePage>
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
    await data.apiRouteSymptoms(context: context);
    if (mounted) {
      await data.apiRouteDrugAllergies(context: context);
    }
    if (mounted) {
      await data.apiRouteMedicalConditions(context: context);
      data.setData(
          modelList: data.medicalConditionsModelList,
          isFamilyMedicalConditions: true);
    }
    if (mounted) {
      await data.apiRouteSurgeries(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(TelemedStrings.healthprofileHeader),
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
                        child: Text(TelemedStrings.hpText,
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
                        child: Text(TelemedStrings.hpQ1,
                            style: Theme.of(context).textTheme.bodyMedium!),
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
                          initialValue:
                              data.selectedHealthProfileModel!.lengthOfFeeling,
                          onChanged: (newValue) {
                            data.selectedHealthProfileModel!.lengthOfFeeling =
                                newValue;
                          },
                          decoration: InputDecoration(
                            labelText: TelemedStrings.hpQ1,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.date_range),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.hpQ2,
                            style: Theme.of(context).textTheme.bodyMedium!),
                      ),
                      Wrap(
                        children: List.generate(
                          data.symptomsModelList.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FilterChip(
                                label: Text(
                                    data.symptomsModelList[index].symptom!),
                                selected: data.selectedHealthProfileModel!
                                    .symptomsModelList!
                                    .any((element) =>
                                        element.id ==
                                        data.symptomsModelList[index].id),
                                onSelected: (bool isSelected) {
                                  data.symptomsModelList[index].isSelected =
                                      isSelected;
                                  if (isSelected) {
                                    data.addIntoHealthProfileLists(
                                        model: data.symptomsModelList[index]);
                                  } else {
                                    data.removeFromHealthProfileLists(
                                        model: data.symptomsModelList[index]);
                                  }
                                },
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.hpQ3,
                            style: Theme.of(context).textTheme.bodyMedium!),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.hpQ3text1,
                            style: Theme.of(context).textTheme.bodyMedium!),
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
                          initialValue:
                              data.selectedHealthProfileModel!.medications,
                          onChanged: (newValue) {
                            data.selectedHealthProfileModel!.medications =
                                newValue;
                          },
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: TelemedStrings.hpQ3text2,
                            hintText: TelemedStrings.hpQ3text2Hint,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.medication),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.hpQ4,
                            style: Theme.of(context).textTheme.bodyMedium!),
                      ),
                      Wrap(
                        children: List.generate(
                          data.drugAllergiesModelList.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FilterChip(
                                label: Text(data
                                    .drugAllergiesModelList[index].drugName!),
                                selected: data.selectedHealthProfileModel!
                                    .drugAllergiesModelList!
                                    .any((element) =>
                                        element.id ==
                                        data.drugAllergiesModelList[index].id),
                                onSelected: (bool isSelected) {
                                  if (isSelected) {
                                    data.addIntoHealthProfileLists(
                                        model:
                                            data.drugAllergiesModelList[index]);
                                  } else {
                                    data.removeFromHealthProfileLists(
                                        model:
                                            data.drugAllergiesModelList[index]);
                                  }
                                },
                              ),
                            );
                          },
                        ).toList(),
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
                          initialValue: data.selectedHealthProfileModel!
                              .allergicToDrugsComplaint,
                          onChanged: (newValue) {
                            data.selectedHealthProfileModel!
                                .allergicToDrugsComplaint = newValue;
                          },
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: TelemedStrings.typeComplaints,
                            hintText: TelemedStrings.typeDrugComplaintsHint,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.warning),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.hpQ5,
                            style: Theme.of(context).textTheme.bodyMedium!),
                      ),
                      Wrap(
                        children: List.generate(
                          data.medicalConditionsModelList.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FilterChip(
                                label: Text(data
                                    .medicalConditionsModelList[index]
                                    .medicalCondition!),
                                selected: data.selectedHealthProfileModel!
                                    .medicalConditionsModelList!
                                    .any((element) =>
                                        element.id ==
                                        data.medicalConditionsModelList[index]
                                            .id),
                                onSelected: (bool isSelected) {
                                  if (isSelected) {
                                    data.addIntoHealthProfileLists(
                                        model: data
                                            .medicalConditionsModelList[index]);
                                  } else {
                                    data.removeFromHealthProfileLists(
                                        model: data
                                            .medicalConditionsModelList[index]);
                                  }
                                },
                              ),
                            );
                          },
                        ).toList(),
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
                          initialValue: data.selectedHealthProfileModel!
                              .medicalConditionComplaint,
                          onChanged: (newValue) {
                            data.selectedHealthProfileModel!
                                .medicalConditionComplaint = newValue;
                          },
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: TelemedStrings.typeComplaints,
                            hintText: TelemedStrings
                                .typeMedicalConditionsComplaintsHint,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.warning),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.hpQ7,
                            style: Theme.of(context).textTheme.bodyMedium!),
                      ),
                      Wrap(
                        children: List.generate(
                          data.familyMedicalConditionsModelList.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FilterChip(
                                label: Text(data
                                    .familyMedicalConditionsModelList[index]
                                    .medicalCondition!),
                                selected: data.selectedHealthProfileModel!
                                    .familyMedicalConditionsModelList!
                                    .any((element) =>
                                        element.id ==
                                        data
                                            .familyMedicalConditionsModelList[
                                                index]
                                            .id),
                                onSelected: (bool isSelected) {
                                  if (isSelected) {
                                    data.addIntoHealthProfileLists(
                                        model:
                                            data.familyMedicalConditionsModelList[
                                                index],
                                        isFamilyMedicalConditions: true);
                                  } else {
                                    data.removeFromHealthProfileLists(
                                        model:
                                            data.familyMedicalConditionsModelList[
                                                index],
                                        isFamilyMedicalConditions: true);
                                  }
                                },
                              ),
                            );
                          },
                        ).toList(),
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
                          initialValue: data.selectedHealthProfileModel!
                              .familyMedicalConditionComplaint,
                          onChanged: (newValue) {
                            data.selectedHealthProfileModel!
                                .familyMedicalConditionComplaint = newValue;
                          },
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: TelemedStrings.typeComplaints,
                            hintText: TelemedStrings
                                .typeFamilyMedicalConditionsComplaintsHint,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.warning),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(TelemedStrings.hpQ6,
                            style: Theme.of(context).textTheme.bodyMedium!),
                      ),
                      Wrap(
                        children: List.generate(
                          data.surgeriesModelList.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FilterChip(
                                label: Text(data
                                    .surgeriesModelList[index].surgeryName!),
                                selected: data.selectedHealthProfileModel!
                                    .surgeriesModelList!
                                    .any((element) =>
                                        element.id ==
                                        data.surgeriesModelList[index].id),
                                onSelected: (bool isSelected) {
                                  if (isSelected) {
                                    data.addIntoHealthProfileLists(
                                        model: data.surgeriesModelList[index]);
                                  } else {
                                    data.removeFromHealthProfileLists(
                                        model: data.surgeriesModelList[index]);
                                  }
                                  setState(() {});
                                },
                              ),
                            );
                          },
                        ).toList(),
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
                          initialValue:
                              data.selectedHealthProfileModel!.surgeryComplaint,
                          onChanged: (newValue) {
                            data.selectedHealthProfileModel!.surgeryComplaint =
                                newValue;
                          },
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: TelemedStrings.typeComplaints,
                            hintText:
                                TelemedStrings.typeSurgeriesComplaintsHint,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.warning),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            ReviewProfilePage.route,
          );
        },
        label: Text(TelemedStrings.reviewProfile),
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
