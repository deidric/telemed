import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Model/ConversationModel.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/Messages/MessagesPage.dart';
import 'package:telemed/settings.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({Key? key}) : super(key: key);
  static const String route = '/basePage/conversationsPage';

  @override
  ConversationsPageState createState() => ConversationsPageState();
}

class ConversationsPageState extends State<ConversationsPage> {
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
    if (mounted) {
      List<ConversationModel> conversationModelList = [];
      data.setData(modelList: conversationModelList);

      await data.apiRouteConversationsByUserId(context: context);
      // final uniqueConversationSet = <dynamic>{};
      //
      // data.conversationModelList.retainWhere(
      //     (element) => uniqueConversationSet.add(element.conversationId));
      // data.setData(modelList: uniqueConversationSet.toList());
    }
  }

  var currentPage = const ConversationsPage();

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
                Row(
                  children: [
                    Expanded(
                      child: TextField(
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
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () async {
                        List<ConversationModel> conversationModelList = [];
                        data.setData(modelList: conversationModelList);
                        await data.apiRouteConversationsByUserId(
                            context: context);
                        // final uniqueConversationSet = <dynamic>{};
                        //
                        // data.conversationModelList.retainWhere((element) =>
                        //     uniqueConversationSet.add(element.conversationId));
                        // data.setData(modelList: uniqueConversationSet.toList());
                      },
                    )
                  ],
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: data.filteredConversationModelList.length,
                  itemBuilder: (context, index) {
                    String personName = "";
                    if (data.filteredConversationModelList[index]
                            .fromUserTypeId ==
                        data.selectedUserModel.userTypeId) {
                      personName =
                          "${data.filteredConversationModelList[index].toUserFirstName!} ${data.filteredConversationModelList[index].toUserLastName!}";
                    } else {
                      personName =
                          "${data.filteredConversationModelList[index].fromUserFirstName!} ${data.filteredConversationModelList[index].fromUserLastName!}";
                    }
                    return ListTile(
                      isThreeLine: true,
                      leading: Image.asset(TelemedImage.doctorImage),
                      title: Text(personName),
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
                      onTap: () {
                        data.setSelectedData(
                            model: data.filteredConversationModelList[index]);
                        Navigator.pushNamed(
                          context,
                          MessagesPage.route,
                        );
                      },
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
