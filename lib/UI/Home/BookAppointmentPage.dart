import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({Key? key}) : super(key: key);
  static const String route = '/bookAppointmentPage';

  @override
  BookAppointmentPageState createState() => BookAppointmentPageState();
}

class BookAppointmentPageState extends State<BookAppointmentPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Uri _url = Uri.parse("");
  int oneValue = 1;

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
        title: Text(TelemedStrings.bookingHeader),
      ),
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 150),
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text(
                          "${data.selectedDoctorModel!.firstName!} ${data.selectedDoctorModel!.lastName!}",
                        ),
                        subtitle: Text(
                          "${data.selectedDoctorModel!.firstName!} ${data.selectedDoctorModel!.lastName!}",
                        ),
                      ),
                    ],
                  ),
                ],
              )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
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
