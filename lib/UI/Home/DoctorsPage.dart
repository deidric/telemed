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
  var oneValue = '';

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
                  return RadioListTile(
                    value: data.filteredUserModelList[index].firstName,
                    secondary: const Icon(Icons.account_circle),
                    groupValue: oneValue,
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        oneValue = value.toString();
                      });
                    },
                    // leading: const Icon(Icons.account_circle),
                    title: Text(
                      "${data.filteredUserModelList[index].firstName!} ${data.filteredUserModelList[index].lastName!}",
                    ),
                    subtitle: Text(
                      data.filteredUserModelList[index].email!,
                    ),
                    // trailing: Radio(
                    //   value: data.filteredUserModelList[index].firstName,
                    //   groupValue: oneValue,
                    //   onChanged: (value) {
                    //     print(value);
                    //     setState(() {
                    //       oneValue = value.toString();
                    //     });
                    //   },
                    // ),
                    // onTap: (){
                    //
                    // }
                  );
                },
                separatorBuilder: (_, __) => const Divider(height: 1),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:   (){
          // Navigator.pushNamed(
          //   context,
          //   CadersPage.route,
          // );
        },
        label: Text(TelemedStrings.bookNow),
      ),
    );
  }
}
