import 'dart:async';
import 'dart:io';

import 'package:flutter_zoom_plugin/zoom_view.dart';
import 'package:flutter_zoom_plugin/zoom_options.dart';

import 'package:flutter/material.dart';

class StartMeetingWidget extends StatelessWidget {

  ZoomOptions? zoomOptions;
  ZoomMeetingOptions? meetingOptions;

  Timer? timer;

  String SDKKey = 'jJbXtCPPsbt3KpaPMqkCgL7t0zWoHwsKb98k';
  String SDKSecret = 'qmo84JZAg24dguzikPZX49QwajdhpxBiYtu3';
  String Username = 'viren@zibma.com';
  String zoomAccessToken_ZAK =
      'eyJ6bV9za20iOiJ6bV9vMm0iLCJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJjbGllbnRzbSIsInVpZCI6ImFfTlVXQkxOU1g2UFQ5TUZuZUFhWHciLCJpc3MiOiJ3ZWIiLCJzdHkiOjEwMCwid2NkIjoiYXcxIiwiY2x0IjowLCJzdGsiOiI4RnNMbG54b0pHZlY1WTA3X3dDOFh6Z2tDMXJCZXNNd2R3MEJnbjMxUUFvLkJnWVljR3hHVGpscFJuZDFORFJKYUN0VWNHUjJlVkJLVVQwOVFEWTNOR1V5WldRMU5tWXlOemsxT1dVeVptWmtZams0WldabFlUaGpPREk0T0RVeE1tRXdZekE0TlRjM05ERTJPRFF5TWpjME1qQXlZakl4WWpoaU1Ua0FJRVZPTkhWM1ZUWXliWEZZU0d4aWVFUlVPVU4yT1hOcGVuVnpMemMzYlV0b0FBTmhkekVBQUFGNkhaUGJTUUFTZFFBQUFBIiwiZXhwIjoxNjI0MDAxMDY3LCJpYXQiOjE2MjM5OTM4NjcsImFpZCI6Ik40X1B0Vm1WVGhhQnVNS3g4UVVkTHciLCJjaWQiOiIifQ.-6CQIkE264YVjy658vpo2uDWa57zasOlpmCNZrR6emE';
  String displayName = 'Android';

  StartMeetingWidget({Key? key, meetingId}) : super(key: key) {
    this.zoomOptions = new ZoomOptions(
      domain: "zoom.us",
      appKey: SDKKey,
      appSecret: SDKSecret,
    );
    this.meetingOptions = new ZoomMeetingOptions(
        userId: Username,
        displayName: 'Test',
        meetingId: meetingId,
        zoomAccessToken: zoomAccessToken_ZAK,
        zoomToken: "<user_token>",
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
      result = status == "MEETING_STATUS_DISCONNECTING" || status == "MEETING_STATUS_FAILED";
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

          controller.initZoom(this.zoomOptions!)
              .then((results) {

            print("initialised");
            print(results);

            if(results[0] == 0) {

              controller.zoomStatusEvents.listen((status) {
                print("Meeting Status Stream: " + status[0] + " - " + status[1]);
                if (_isMeetingEnded(status[0])) {
                  Navigator.pop(context);
                  timer?.cancel();
                }
              });

              print("listen on event channel");

              controller.startMeeting(this.meetingOptions!)
                  .then((joinMeetingResult) {

                timer = Timer.periodic(new Duration(seconds: 2), (timer) {
                  controller.meetingStatus(this.meetingOptions!.meetingId!)
                      .then((status) {
                    print("Meeting Status Polling: " + status[0] + " - " + status[1]);
                  });
                });

              });
            }

          }).catchError((error) {

            print("Error");
            print(error);
          });
        })
      ),
    );
  }

}
