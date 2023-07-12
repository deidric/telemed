import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);
  static const String route = '/basePage/messagesPage';

  @override
  MessagesPageState createState() => MessagesPageState();
}

class MessagesPageState extends State<MessagesPage> {
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
    print(data.selectedUserModel.id);
    if (mounted) {
      await data.apiRouteConversationsByUserId(context: context);
      final uniqueConversationSet = <dynamic>{};
      data.conversationModelList.retainWhere(
          (element) => uniqueConversationSet.add(element.conversationId));
      data.setData(modelList: uniqueConversationSet.toList());
    }
  }

  var currentPage = const MessagesPage();

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    DateTime dob = dateFormat.parse(data.selectedUserModel.dob!);
    DateTime currentDate = DateTime.now();
    int ageInDays = currentDate.difference(dob).inDays;
    double ageInYears = ageInDays / 365;
    return Scaffold(
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : ListView(
              padding: const EdgeInsets.all(15.0),
              shrinkWrap: true,
              children: [
                TextField(
                  onChanged: (value) {
                    if (value.isEmpty) {
                      data.setData(modelList: data.conversationModelList);
                    } else {
                      data.updateFilteredData(
                          modelList: data.filteredConversationModelList
                              .where((element) =>
                                  element.toUserFirstName!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  element.toUserLastName!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                              .toList());
                    }
                  },
                  decoration: InputDecoration(
                    labelText: TelemedStrings.search,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: data.filteredConversationModelList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      isThreeLine: true,
                      leading: Image.asset(TelemedImage.doctorImage),
                      title: Text(
                          "${data.filteredConversationModelList[index].toUserFirstName!} ${data.filteredConversationModelList[index].toUserLastName!}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.filteredConversationModelList[index].message!,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                          ),
                          Text(TelemedSettings.dateFormat.format(
                              DateFormat("yyyy-MM-dd").parse(data
                                  .filteredConversationModelList[index]
                                  .sentDate!))),
                        ],
                      ),
                      onTap: (){},
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
