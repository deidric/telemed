import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/BookAppointmentsReasonForVisitPage.dart';
import 'package:telemed/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  static const String route = '/basePage/homePage';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final Uri _url = Uri.parse("");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadAllAppMetaDataOnce();
    });
  }

  int runTimes = 0;

  Future<void> loadAllAppMetaDataOnce() async {
    var data = context.read<TelemedDataProvider>();
    if (mounted) {
      await data.apiRouteAppointmentByDate(context: context);
    }
  }

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
                if (data.appointmentModelList.isEmpty)
                  ListTile(
                    title: Text(TelemedStrings.scheduledAppointments),
                    subtitle: Text(TelemedStrings.bookNow),
                    leading: const Icon(Icons.calendar_month),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                if (data.appointmentModelList.isNotEmpty)
                  ListView.separated(
                    itemCount: data.appointmentModelList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(TelemedImage.doctorImage),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.message),
                        ),
                        title: Text(
                            "${data.appointmentModelList[index].firstName} ${data.appointmentModelList[index].lastName!}"),
                        subtitle: Text(data
                            .appointmentModelList[index].timeOfAppointment!),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
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
                      BookAppointmentsReasonForVisitPage.route,
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
