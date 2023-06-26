import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({Key? key}) : super(key: key);
  static const String route = '/cadersPage';

  @override
  DoctorsPageState createState() => DoctorsPageState();
}

class DoctorsPageState extends State<DoctorsPage>
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
    await data.apiRouteDoctorsByCaderId(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(TelemedStrings.medicalOfficers),
      ),
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                // shrinkWrap: true,
                itemCount: data.filteredUserModelList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: Text(
                      "${data.filteredUserModelList[index].firstName!} ${data.filteredUserModelList[index].lastName!}",
                    ),
                    subtitle: Text(
                      data.filteredUserModelList[index].email!,
                    ),
                    onTap: () async {
                      data.setSelectedData(data.filteredUserModelList[index]);
                      // RouteSettings settings =
                      //     RouteSettings(name: HomePage.route, arguments: '');
                      // var hasBeenClosed = await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       settings: settings,
                      //       builder: (context) => HomePage(
                      //             actions: psbsActions.view,
                      //             subRoute: HomePage.settings,
                      //           )),
                      // );
                    },
                  );
                },
                separatorBuilder: (_, __) => const Divider(height: 1),
              ),
            ),
    );
  }
}
