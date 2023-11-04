import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
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
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
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

    initAgora(uniqueChannelName);
  }

  void initAgora(String uniqueChannelName) async {
    final data = context.read<TelemedDataProvider>();
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: "6c859c545f27425aa2ebc6cbbe30b1fa",
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: data.selectedUserModel.token!,
      channelId: uniqueChannelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );

    // client = AgoraClient(
    //   agoraConnectionData: AgoraConnectionData(
    //     appId: "6c859c545f27425aa2ebc6cbbe30b1fa",
    //     channelName: uniqueChannelName,
    //     // tempToken: data.selectedUserModel.token,
    //   ),
    //   enabledPermission: [
    //     Permission.camera,
    //     Permission.microphone,
    //   ],
    // );
    //
    // await client.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              // AgoraVideoViewer(
              //   client: client,
              //   layoutType: Layout.floating,
              //   showNumberOfUsers: true,
              //   showAVState: true,
              //   enableHostControls: true, // Add this to enable host controls
              // ),
              // AgoraVideoButtons(
              //   client: client,
              //   onDisconnect: () {
              //     Navigator.pop(context);
              //   },
              //   addScreenSharing: false, // Add this to enable screen sharing
              // ),
              Center(
                child: _remoteVideo(),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 100,
                  height: 150,
                  child: Center(
                    child: _localUserJoined
                        ? AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: _engine,
                              canvas: const VideoCanvas(uid: 0),
                            ),
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: uniqueChannelName),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
