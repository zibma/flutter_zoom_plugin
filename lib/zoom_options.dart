
class ZoomOptions {

  String? domain;
  String? appKey;
  String? appSecret;
  String? jwtToken;

  ZoomOptions({
    this.domain,
    this.appKey,
    this.appSecret,
    this.jwtToken
  });
}

class ZoomMeetingOptions {

  String? userId;
  String? displayName;
  String? meetingId;
  String? meetingPassword;
  String? zoomToken;
  String? zoomAccessToken;
  String? noInvite;
  String? noMeetingEndMessage;
  String? meetingViewsOptions;
  String? noTitleBar;
  String? noDialInViaPhone;
  String? noDialOutToPhone;


  ZoomMeetingOptions({
    this.userId,
    this.displayName,
    this.meetingId,
    this.meetingPassword,
    this.zoomToken,
    this.zoomAccessToken,
    this.noInvite,
    this.noMeetingEndMessage,
    this.meetingViewsOptions,
    this.noTitleBar,
    this.noDialInViaPhone,
    this.noDialOutToPhone,

  });
}
