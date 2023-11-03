import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/Messages/ParticipantTile.dart';
import 'package:telemed/settings.dart';
import 'package:videosdk/videosdk.dart';
import 'package:http/http.dart' as http;

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  static const String route = '/basePage/messagesPage/videoCallPage';

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late Room _room;

  Map<String, Participant> participants = {};
  String? joined;

  @override
  void initState() {
    final data = context.read<TelemedDataProvider>();
    String uniqueChannelName = "";

    // // create room
    // _room = VideoSDK.createRoom(
    //   // roomId: "9rn9-5f51-mwim",
    //   roomId: uniqueChannelName,
    //   token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI2MjJkOGMxNy0wMTExLTQzZjgtOWFhNC1iNzJkYjc1NzZmYjEiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY5ODY4Mzk5MSwiZXhwIjoxNjk4NzcwMzkxfQ.JizuAh2yAnEfwClrY0qQGaBGFycNydVo74NKu6CExJo",
    //   displayName: "daedric's Org",
    //   micEnabled: true,
    //   camEnabled: true,
    //   defaultCameraIndex:
    //   1, // Index of MediaDevices will be used to set default camera
    // );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (data.channelName == null) {
        String roomId = await createMeeting();
        data.setChannelName(roomId);

        uniqueChannelName = TelemedSettings.uniqueDistinguish + roomId;
      } else {
        uniqueChannelName =
            TelemedSettings.uniqueDistinguish + data.channelName!;
      }
      print(uniqueChannelName);

      // create room
      _room = VideoSDK.createRoom(
        roomId: "9rn9-5f51-mwim",
        // roomId: uniqueChannelName,
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI2MjJkOGMxNy0wMTExLTQzZjgtOWFhNC1iNzJkYjc1NzZmYjEiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY5ODY4Mzk5MSwiZXhwIjoxNjk4NzcwMzkxfQ.JizuAh2yAnEfwClrY0qQGaBGFycNydVo74NKu6CExJo",
        displayName: "daedric's Org",
        micEnabled: true,
        camEnabled: true,
        defaultCameraIndex:
            1, // Index of MediaDevices will be used to set default camera
      );

      //set up event listener which will give any updates happening in the room
      setRoomEventListener();
    });

    super.initState();
  }

  // API call to create meeting
  Future<String> createMeeting() async {
    final http.Response httpResponse = await http.post(
      Uri.parse("https://api.videosdk.live/v2/rooms"),
      headers: {
        'Authorization':
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI2MjJkOGMxNy0wMTExLTQzZjgtOWFhNC1iNzJkYjc1NzZmYjEiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY5ODY4Mzk5MSwiZXhwIjoxNjk4NzcwMzkxfQ.JizuAh2yAnEfwClrY0qQGaBGFycNydVo74NKu6CExJo"
      },
    );

//Destructuring the roomId from the response
    return json.decode(httpResponse.body)['roomId'];
  }

  // listening to room events
  void setRoomEventListener() {
    //Event called when room is joined successfully
    _room.on(Events.roomJoined, () {
      setState(() {
        joined = "JOINED";
        participants.putIfAbsent(
            _room.localParticipant.id, () => _room.localParticipant);
      });
    });

    //Event called when new participant joins
    _room.on(
      Events.participantJoined,
      (Participant participant) {
        setState(
          () => participants.putIfAbsent(participant.id, () => participant),
        );
      },
    );
    //Event called when a participant leaves the room
    _room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(
          () => participants.remove(participantId),
        );
      }
    });
    //Event called when you leave the meeting
    _room.on(Events.roomLeft, () {
      participants.clear();
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }

  // onbackButton pressed leave the room
  Future<bool> _onWillPop() async {
    _room.leave();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('VideoSDK QuickStart'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: joined != null
              ? joined == "JOINED"
                  ? Column(
                      children: [
                        //render all participants in the room
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return ParticipantTile(
                                  participant:
                                      participants.values.elementAt(index));
                            },
                            itemCount: participants.length,
                          ),
                        )
                      ],
                    )
                  : const Text("JOINING the Room",
                      style: TextStyle(color: Colors.white))
              : ElevatedButton(
                  onPressed: () {
                    //Method to join the room
                    _room.join();
                    setState(() {
                      joined = "JOINING";
                    });
                  },
                  child: const Text("Join the Room")),
        ),
      ),
    );
  }
}
