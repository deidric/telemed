import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Model/ConversationModel.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/Messages/MessagesPage.dart';
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
      await data.apiRouteConversationsByUserId(context: context);
      final uniqueConversationSet = <dynamic>{};
      data.conversationModelList.retainWhere(
          (element) => uniqueConversationSet.add(element.conversationId));
      data.setData(modelList: uniqueConversationSet.toList());
    }
    if (mounted) {
      if (data.selectedUserModel.userTypeId == TelemedSettings.patientId) {
        await data.apiRouteAppointmentByDate(context: context);
      }
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
                if (data.selectedUserModel.userTypeId ==
                        TelemedSettings.patientId &&
                    data.appointmentModelList.isNotEmpty)
                  ListView.separated(
                    itemCount: data.appointmentModelList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(TelemedImage.doctorImage),
                        trailing: IconButton(
                          onPressed: () async {
                            var conversationModel = data.conversationModelList
                                .firstWhereOrNull((element) =>
                                    element.toUserId ==
                                    data.appointmentModelList[index].doctorId);

                            if (conversationModel != null) {
                              data.setSelectedData(model: conversationModel);
                            } else {
                              ConversationModel conversationModel1 =
                                  ConversationModel(
                                      conversationId: null,
                                      toUserId: data.appointmentModelList[index]
                                          .doctorId);
                              data.setSelectedData(model: conversationModel1);
                            }

                            Navigator.pushNamed(
                              context,
                              MessagesPage.route,
                            );
                          },
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
              ],
            ),
    );
  }
}
