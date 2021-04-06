import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_plugin/zoom_options.dart';
import 'package:flutter_zoom_plugin/zoom_view.dart';

class StartMeetingWidget extends StatelessWidget {
  ZoomOptions? zoomOptions;
  ZoomMeetingOptions? meetingOptions;

  Timer? timer;

  String SDKKey = 'jJbXtCPPsbt3KpaPMqkCgL7t0zWoHwsKb98k';
  String SDKSecret = 'qmo84JZAg24dguzikPZX49QwajdhpxBiYtu3';
  String Username = 'viren@zibma.com';
  String zoomAccessToken_ZAK =
      'eyJ6bV9za20iOiJ6bV9vMm0iLCJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJjbGllbnQiLCJ1aWQiOiJhX05VV0JMTlNYNlBUOU1GbmVBYVh3IiwiaXNzIjoid2ViIiwic3R5IjoxMDAsIndjZCI6ImF3MSIsImNsdCI6MCwic3RrIjoiVnJtQWViVWNaQTUzZ3BKcHVsMzZGekhhbFBfRUJSMmV6QkZ2UGw1Yktvby5CZ1lZY0d4R1RqbHBSbmQxTkRSSmFDdFVjR1IyZVZCS1VUMDlRREkzWWpreU1EQmlNVEZoWVRCa1l6TTVOREJtWlRCaFl6RXlZVEptTW1NeU1tRm1OV1F6Tm1WaVpHSXdZMlppWW1ObVlUQmpPV1ZqWkRka05XSXlaamtBRERORFFrRjFiMmxaVXpOelBRQURZWGN4QUFBQmVLV0RFWEVBRW5VQUFBQSIsImV4cCI6MTYxNzY5MTczMywiaWF0IjoxNjE3Njg0NTMzLCJhaWQiOiJONF9QdFZtVlRoYUJ1TUt4OFFVZEx3IiwiY2lkIjoiIn0.dn1ZItX_CU4z_Ga4xMtP7t9NEveqGTHsR5uZoi7ROyQ';
  String displayName = 'Android';

  StartMeetingWidget({Key? key, meetingId}) : super(key: key) {
    this.zoomOptions = new ZoomOptions(
      domain: "zoom.us",
      appKey: SDKKey,
      appSecret: SDKSecret,
    );
    this.meetingOptions = new ZoomMeetingOptions(
      userId: Username,
      displayName: 'Rajnik',
      meetingId: meetingId,
      meetingPassword: '',
      zoomToken: "<user_token>",
      zoomAccessToken: zoomAccessToken_ZAK,

      noMore: '',
      noParticipant: '',
      noTitle: '',
      disableDialIn: "true",
      disableDrive: "true",
      disableInvite: "true",
      disableShare: "true",
      noAudio: "false",
      noDisconnectAudio: "false",
    );
  }

  bool _isMeetingEnded(String status) {
    var result = false;

    if (Platform.isAndroid)
      result = status == "MEETING_STATUS_DISCONNECTING" ||
          status == "MEETING_STATUS_FAILED";
    else
      result = status == "MEETING_STATUS_IDLE";

    return result;
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading meeting '),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ZoomView(onViewCreated: (controller) {
            print("Created the view");
            controller.initZoom(this.zoomOptions!).then((results) {
              print("initialised");
              print(results);
              if (results[0] == 0) {
                controller.zoomStatusEvents.listen((status) {
                  print("Meeting Status Stream: " +
                      status[0] +
                      " - " +
                      status[1]);
                  if (_isMeetingEnded(status[0])) {
                    Navigator.pop(context);
                    timer?.cancel();
                  }
                });
                print("listen on event channel");
                controller
                    .startMeeting(this.meetingOptions!)
                    .then((joinMeetingResult) {
                  timer = Timer.periodic(new Duration(seconds: 2), (timer) {
                    controller
                        .meetingStatus(this.meetingOptions!.meetingId!)
                        .then((status) {
                      print("Meeting Status Polling: " +
                          status[0] +
                          " - " +
                          status[1]);
                    });
                  });
                });
              }
            }).catchError((error) {
              print("Error");
              print(error);
            });
          })),
    );
  }
}
