import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const String route = '/profilePage';

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Uri _url = Uri.parse("");

  @override
  void initState() {
    super.initState();
  }

  var currentPage = const ProfilePage();

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
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
                          style: Theme.of(context).textTheme.titleMedium!),
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
                          style: Theme.of(context).textTheme.titleMedium!),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.settings,
                          style: Theme.of(context).textTheme.titleMedium!),
                    ),
                    ListTile(
                      title: Text(
                        TelemedStrings.settings,
                      ),
                      isThreeLine: true,
                      leading: const Icon(Icons.settings),
                      subtitle: Text(TelemedStrings.configureYourAccount),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                        TelemedStrings.helpAndSupport,
                      ),
                      isThreeLine: true,
                      leading: const Icon(Icons.help),
                      subtitle: Text(TelemedStrings.configureYourAccount),
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                        TelemedStrings.logOut,
                      ),
                      isThreeLine: true,
                      leading: const Icon(Icons.logout),
                      subtitle: Text(TelemedStrings.securelyLogOut),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
