import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class HealthInsurancePage extends StatefulWidget {
  const HealthInsurancePage({Key? key}) : super(key: key);
  static const String route = '/healthInsurance';

  @override
  HealthInsurancePageState createState() => HealthInsurancePageState();
}

class HealthInsurancePageState extends State<HealthInsurancePage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Uri _url = Uri.parse("");

  @override
  void initState() {
    super.initState();
  }

  Future<void> save(BuildContext context) async {
    var data = context.read<TelemedDataProvider>();
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();
    await data.apiRouteCreateAccount(
        context: context, userModel: data.selectedUserModel);
    // }
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
                      child: Text(TelemedStrings.healthInsurance,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.hInsurance,
                          style: data.getTelemedTextStyle(context).bodyLarge!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: SearchBar(
                              leading: const Icon(Icons.search),
                              hintText: TelemedStrings.search,
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.insuranceEx,
                          style: data.getTelemedTextStyle(context).titleSmall!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                save(context);
                              },
                              child: Text(TelemedStrings.save),
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
                            child: OutlinedButton(
                              onPressed: () {
                                save(context);
                              },
                              child: Text(TelemedStrings.skipInsurance),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.skipIns,
                          style: data.getTelemedTextStyle(context).bodyLarge!),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
