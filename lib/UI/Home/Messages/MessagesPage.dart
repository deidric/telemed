import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Components/PopupMenuButton.dart';
import 'package:telemed/Components/TelemedLoadingProgressDialog.dart';
import 'package:telemed/Model/MessageModel.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';
import 'package:http/http.dart' as http;

// Crude counter to make messages unique
int _messageCount = 0;

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String? token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}

class MessagesPage extends StatefulWidget {
  final bool shouldPop;

  const MessagesPage({Key? key, required this.shouldPop}) : super(key: key);
  static const String route = '/basePage/messagesPage';

  @override
  MessagesPageState createState() => MessagesPageState();
}

class MessagesPageState extends State<MessagesPage> {
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

  Future<void> sendMessage(BuildContext context) async {
    var data = context.read<TelemedDataProvider>();
    MessageModel messageModel = MessageModel(
      toUserId: data.selectedConversationModel!.toUserId,
      sentDate: DateTime.now().toIso8601String(),
      attachments: null,
      message: message,
    );
    await data.apiRoutecreateMessages(
        context: context, messageModel: messageModel);
    if (mounted) {
      await data.apiRouteConversationsByUserId(context: context);
      final uniqueConversationSet = <dynamic>{};
      data.conversationModelList.retainWhere(
          (element) => uniqueConversationSet.add(element.conversationId));
      data.setData(modelList: uniqueConversationSet.toList());
    }
    if (mounted) {
      await data.apiRouteMessagesByConversationId(context: context);
      message = "";
      setState(() {});
      await sendPushMessage();
    }
  }

  Future<void> sendPushMessage() async {
    var data = context.read<TelemedDataProvider>();
    String? _token = data.selectedUserModel.device_key;
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(_token),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
    if (widget.shouldPop) {
      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  var currentPage = const MessagesPage(
    shouldPop: false,
  );
  String message = "";
  final ScrollController _scrollController = ScrollController();

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<TelemedDataProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(TelemedStrings.messages), actions: [
        const AppBarActionsPopupMenuButton(),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () async {
            await data.apiRouteMessagesByConversationId(context: context);
          },
        )
      ]),
      body: data.isLoading
          ? const TelemedLoadingProgressDialog()
          : ListView.separated(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${data.filteredMessageModelList[index].toUserFirstName!} ${data.filteredMessageModelList[index].toUserLastName!}"),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                        DateFormat("yyyy-MM-dd").parse(
                            data.filteredMessageModelList[index].sentDate!))),
                    const Expanded(child: Divider()),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: _scrollDown,
        child: const Icon(Icons.arrow_downward),
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
                onChanged: (value) {
                  message = value;
                  setState(() {});
                },
                initialValue: message,
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
              onPressed: () {
                sendMessage(context);
              },
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ],
    );
  }
}
