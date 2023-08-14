import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const String route = '/basePage/profilePage';

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
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
    if (mounted) {
      // await data.apiRouteAppointmentByDate(context: context);
    }
  }

  var currentPage = const ProfilePage();

  int? _selectedTextSize = 1;

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    DateTime dob = dateFormat.parse(data.selectedUserModel.dob!);
    DateTime currentDate = DateTime.now();
    int ageInDays = currentDate.difference(dob).inDays;
    double ageInYears = ageInDays / 365;
    return Scaffold(
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
                    ListTile(
                      title: Text(
                          "${data.selectedUserModel.firstName!} ${data.selectedUserModel.lastName!}",
                          style:
                              data.getTelemedTextStyle(context).titleMedium!),
                      leading: const Icon(Icons.account_circle),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      subtitle: Text(
                          "${data.selectedUserModel.gender!}, ${ageInYears.toStringAsFixed(2)} ${TelemedStrings.yearsOld}"),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.payment,
                          style:
                              data.getTelemedTextStyle(context).titleMedium!),
                    ),
                    ListTile(
                      title: Text(
                        TelemedStrings.transactions,
                      ),
                      isThreeLine: true,
                      leading: const Icon(Icons.receipt),
                      subtitle: Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(TelemedStrings.view),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.textSize,
                          style:
                              data.getTelemedTextStyle(context).titleMedium!),
                    ),
                    Wrap(
                      spacing: 10,
                      children: List<Widget>.generate(
                        TelemedTextSizeEnum.values.length,
                        (int idx) {
                          return ChoiceChip(
                              label: Text(TelemedTextSizeEnum.values[idx].name),
                              selected: _selectedTextSize == idx,
                              onSelected: (bool selected) {
                                data.setTelemedTextSize(
                                    TelemedTextSizeEnum.values[idx]);
                                setState(() {
                                  _selectedTextSize = selected ? idx : null;
                                });
                              });
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
