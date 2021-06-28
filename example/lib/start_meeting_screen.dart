import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_plugin_ios/zoom_options.dart';
import 'package:flutter_zoom_plugin_ios/zoom_view.dart';

class StartMeetingWidget extends StatelessWidget {
  ZoomOptions? zoomOptions;
  ZoomMeetingOptions? meetingOptions;

  Timer? timer;

  String SDKKey = 'jJbXtCPPsbt3KpaPMqkCgL7t0zWoHwsKb98k';
  String SDKSecret = 'qmo84JZAg24dguzikPZX49QwajdhpxBiYtu3';
  String Username = 'viren@zibma.com';
  String zoomAccessToken_ZAK =
      'eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJhdWQiOiJjbGllbnRzbSIsInVpZCI6ImFfTlVXQkxOU1g2UFQ5TUZuZUFhWHciLCJpc3MiOiJ3ZWIiLCJzdHkiOjEwMCwid2NkIjoiYXcxIiwiY2x0IjowLCJzdGsiOiJNVVVYQzVuNzE2ajNydFAzQjhINFlZRURXcks1OUpGNnNvZERWMWJQdDFrLkJnWVljR3hHVGpscFJuZDFORFJKYUN0VWNHUjJlVkJLVVQwOVFEWTNOR1V5WldRMU5tWXlOemsxT1dVeVptWmtZams0WldabFlUaGpPREk0T0RVeE1tRXdZekE0TlRjM05ERTJPRFF5TWpjME1qQXlZakl4WWpoaU1Ua0FJRVZPTkhWM1ZUWXliWEZZU0d4aWVFUlVPVU4yT1hOcGVuVnpMemMzYlV0b0FBTmhkekVBQUFGNkxoUDdWQUFTZFFBQUFBIiwiZXhwIjoxNjI0Mjc3ODk5LCJpYXQiOjE2MjQyNzA2OTksImFpZCI6Ik40X1B0Vm1WVGhhQnVNS3g4UVVkTHciLCJjaWQiOiIifQ.I9gZbqxlTNxXSrQXrBXKB_6-OpZExa6GQt1dwjUA8uk';
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
      disableDialIn: "true",
      disableDrive: "true",
      disableInvite: "false",
      disableShare: "false",
      noAudio: "false",
      noDisconnectAudio: "false",
      noMore: "false",
      noTitle: "false",
      noParticipant: "false",
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
