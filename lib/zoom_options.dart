
class ZoomOptions {

  String domain;
  String? appKey;
  String? appSecret;
  String? jwtToken;

  ZoomOptions({
    required this.domain,
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
  String zoomToken;
  String zoomAccessToken;
  String disableDialIn;
  String disableDrive;
  String disableInvite;
  String disableShare;
  String noDisconnectAudio;
  String noAudio;
  String noTitle;
  String noParticipant;
  String noMore;

  ZoomMeetingOptions({
    this.userId,
    this.displayName,
    this.meetingId,
    this.meetingPassword,
    required this.zoomToken,
    required this.zoomAccessToken,
    required this.disableDialIn,
    required this.disableDrive,
    required this.disableInvite,
    required this.disableShare,
    required this.noDisconnectAudio,
    required this.noAudio,
    required this.noTitle,
    required this.noParticipant,
    required this.noMore,
  });
}
