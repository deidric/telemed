import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  var currentPage = const HomePage();

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "${TelemedStrings.greetings} ${data.selectedUserModel.firstName!} ${data.selectedUserModel.lastName!}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                      GoogleFonts.pacifico().fontFamily)),
                    ),
                  ],
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
    );
  }
}
