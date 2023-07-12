import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/PopupMenuButton.dart';
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
    if (mounted) {
      await data.apiRouteMessagesByConversationId(context: context);
    }
  }

  var currentPage = const MessagesPage();

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(TelemedStrings.messages), actions: const [
        AppBarActionsPopupMenuButton(),
      ]),
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : ListView(
              padding: const EdgeInsets.all(15.0),
              shrinkWrap: true,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: data.filteredMessageModelList.length,
                  itemBuilder: (context, index) {
                    bool isMessageFromLoggedInUser =
                        data.selectedUserModel.userTypeId ==
                            data.filteredMessageModelList[index].fromUserTypeId;
                    if (!isMessageFromLoggedInUser) {
                      return Row(
                        children: [
                          Expanded(
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                children: [
                                  ListTile(
                                    tileColor: Colors.blue,
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            "${data.filteredMessageModelList[index].toUserFirstName!} ${data.filteredMessageModelList[index].toUserLastName!}"),
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            data.filteredMessageModelList[index]
                                                .message!,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Image.asset(
                            TelemedImage.doctorImage,
                            width: 50,
                            height: 50,
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Image.asset(
                            TelemedImage.doctorImage,
                            width: 50,
                            height: 50,
                          ),
                          Expanded(
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                children: [
                                  ListTile(
                                    tileColor: Colors.grey,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${data.filteredMessageModelList[index].toUserFirstName!} ${data.filteredMessageModelList[index].toUserLastName!}"),
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            data.filteredMessageModelList[index]
                                                .message!,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        const Expanded(child: Divider()),
                        Text(TelemedSettings.dateFormat.format(
                            DateFormat("yyyy-MM-dd").parse(data
                                .filteredMessageModelList[index].sentDate!))),
                        const Expanded(child: Divider()),
                      ],
                    );
                  },
                ),
              ],
            ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return TelemedStrings.pleaseEnterText;
                  }
                  return null;
                },
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: TelemedStrings.message,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.mail_outline),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.emoji_emotions),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.attachment),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ],
    );
  }
}
