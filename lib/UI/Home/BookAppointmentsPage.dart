import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class BookAppointmentsPage extends StatefulWidget {
  const BookAppointmentsPage({Key? key}) : super(key: key);
  static const String route = '/bookAppointmentsPage';

  @override
  BookAppointmentsPageState createState() => BookAppointmentsPageState();
}

class BookAppointmentsPageState extends State<BookAppointmentsPage> with TickerProviderStateMixin {
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
                      child: Text(TelemedStrings.patientLocation,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(TelemedStrings.patientConnection,
                          style: Theme.of(context).textTheme.bodyLarge!),
                    ),

                  ],
                ),
              ],
            ),
    );
  }
}
