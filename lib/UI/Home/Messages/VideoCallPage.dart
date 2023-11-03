import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Model/MessageModel.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/settings.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  static const String route = '/basePage/messagesPage/videoCallPage';

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  String uniqueChannelName = "";

  @override
  void initState() {
    super.initState();
    final data = context.read<TelemedDataProvider>();

    if (data.channelName == null) {
      uniqueChannelName =
          TelemedSettings.uniqueDistinguish + UniqueKey().toString();
    } else {
      uniqueChannelName = TelemedSettings.uniqueDistinguish + data.channelName!;
    }
    print(uniqueChannelName);
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
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1364334216,
      // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          "28ff2565e57521c80d1e13f50e362ab54f03a645aad2697f28e0a3796aaae6c5",
      // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: 'user_id',
      userName: 'user_name',
      // callID: callID,
      callID: uniqueChannelName,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
