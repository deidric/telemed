import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/BookAppointmentsPage.dart';
import 'package:telemed/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String route = '/homePage';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Uri _url = Uri.parse("");

  @override
  void initState() {
    super.initState();
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
        title: Text(TelemedSettings.appName),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          // Respond to item press.
        },
        items: [
          BottomNavigationBarItem(
            label: TelemedStrings.home,
            icon: const Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: TelemedStrings.calendar,
            icon: const Icon(Icons.calendar_month),
          ),
          BottomNavigationBarItem(
            label: TelemedStrings.message,
            icon: const Icon(Icons.message),
          ),
          BottomNavigationBarItem(
            label: TelemedStrings.profile,
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.greetings,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.supp,
                          style: Theme.of(context).textTheme.bodyLarge!),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.upcomingAppointments,
                          style: Theme.of(context).textTheme.titleSmall!),
                    ),
                    ListTile(
                      title: Text(TelemedStrings.scheduledAppointments),
                      subtitle: Text(TelemedStrings.bookNow),
                      leading: const Icon(Icons.calendar_month),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.generalNeeds,
                          style: Theme.of(context).textTheme.titleSmall!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.gNeeds,
                          style: Theme.of(context).textTheme.bodySmall!),
                    ),
                    ListTile(
                      title: Text(TelemedStrings.bookNow),
                      subtitle: Text(TelemedStrings.generalNeedsChoosePrimary),
                      leading: const Icon(Icons.calendar_today),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          BookAppointmentsPage.route,
                        );
                      },
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.specificNeeds,
                          style: Theme.of(context).textTheme.titleSmall!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.specificNeedsPrimary,
                          style: Theme.of(context).textTheme.bodySmall!),
                    ),
                    ListTile(
                      title: Text(TelemedStrings.childrenHealth),
                      subtitle: Text(TelemedStrings.childHealth),
                      leading: const Icon(Icons.child_care),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(TelemedStrings.seniorHealth),
                      subtitle: Text(TelemedStrings.senHealth),
                      leading: const Icon(Icons.accessible),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    const Divider(),
                  ],
                ),
              ],
            ),
    );
  }
}
