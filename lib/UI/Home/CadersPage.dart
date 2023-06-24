import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class CadersPage extends StatefulWidget {
  const CadersPage({Key? key}) : super(key: key);
  static const String route = '/cadersPage';

  @override
  CadersPageState createState() => CadersPageState();
}

class CadersPageState extends State<CadersPage> with TickerProviderStateMixin {
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
    await data.apiRouteCaders(context: context);
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
        title: Text(TelemedStrings.selectCaderHeader),
      ),
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                // shrinkWrap: true,
                itemCount: data.filteredCaderModelList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.health_and_safety),
                    title: Text(
                      data.filteredCaderModelList[index].cader!,
                    ),
                    subtitle: Text(
                      data.filteredCaderModelList[index].caderDescription!,
                    ),
                    onTap: () async {
                      data.setSelectedData(data.filteredCaderModelList[index]);
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
                }, separatorBuilder: (_ , __ ) => const Divider(height:1),
              ),
            ),
    );
  }
}
