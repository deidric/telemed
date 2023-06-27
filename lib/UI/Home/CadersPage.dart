import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/DoctorsPage.dart';
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
                      data.setSelectedData(model: data.filteredCaderModelList[index]);
                      RouteSettings settings = const RouteSettings(
                          name: DoctorsPage.route, arguments: '');
                      var hasBeenClosed = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            settings: settings,
                            builder: (context) => const DoctorsPage()),
                      );
                    },
                  );
                },
                separatorBuilder: (_, __) => const Divider(height: 1),
              ),
            ),
    );
  }
}
