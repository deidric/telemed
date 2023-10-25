import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Model/MessageModel.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  static const String route = '/basePage/messagesPage/videoCallPage';

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  late final AgoraClient client;

  @override
  void initState() {
    super.initState();
    final data = context.read<TelemedDataProvider>();
    String uniqueChannelName = "";
    if(data.channelName == null){
      uniqueChannelName = TelemedSettings.uniqueDistinguish + "." + UniqueKey().toString();
    }
    else{
      uniqueChannelName = TelemedSettings.uniqueDistinguish + "." + data.channelName!;
    }

    // print(data.selectedConversationModel!.toUserId);
    int? toUserId;
    bool isMessagetoLoggedInUser =
        data.selectedUserModel.id == data.selectedConversationModel!.toUserId;
    if (!isMessagetoLoggedInUser) {
      toUserId = data.selectedConversationModel!.toUserId;
    } else {
      toUserId = data.selectedConversationModel!.fromUserId;
    }
    MessageModel messageModel = MessageModel(
      toUserId: toUserId,
      sentDate: DateTime.now().toIso8601String(),
      message: uniqueChannelName,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await data.apiRoutecreateMessages(
          context: context, messageModel: messageModel);
    });

    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "6c859c545f27425aa2ebc6cbbe30b1fa",
        channelName: uniqueChannelName,
        tempToken: data.selectedUserModel.token,
      ),
      enabledPermission: [
        Permission.camera,
        Permission.microphone,
      ],
    );
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
                layoutType: Layout.floating,
                showNumberOfUsers: true,
                showAVState: true,
                enableHostControls: true, // Add this to enable host controls
              ),
              AgoraVideoButtons(
                client: client,
                onDisconnect: () {
                  Navigator.pop(context);
                },
                addScreenSharing: false, // Add this to enable screen sharing
              ),
            ],
          ),
        ),
      ),
    );
  }
}
