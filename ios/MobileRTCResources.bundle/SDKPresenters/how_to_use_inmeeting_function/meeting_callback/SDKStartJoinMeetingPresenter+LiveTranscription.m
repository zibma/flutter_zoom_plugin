//
//  SDKStartJoinMeetingPresenter+LiveTranscription.m
//  MobileRTCSample
//
//  Created by Zoom Video Communications on 2021/10/27.
//  Copyright © 2021 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKStartJoinMeetingPresenter+LiveTranscription.h"

@implementation SDKStartJoinMeetingPresenter (LiveTranscription)
- (void)onSinkLiveTranscriptionStatus:(MobileRTCLiveTranscriptionStatus)status;
{
    NSLog(@"LiveTranscription: onSinkLiveTranscriptionStatus = %@",@(status));
}

- (void)onSinkLiveTranscriptionMsgReceived:(NSString *_Nonnull)msg speakerId:(NSUInteger)speakerId type:(MobileRTCLiveTranscriptionOperationType)type;
{
    NSLog(@"LiveTranscription: onSinkLiveTranscriptionMsgReceived = %@ speakerId = %@  type = %@",msg, @(speakerId) ,@(type));
}

- (void)onSinkRequestForLiveTranscriptReceived:(NSUInteger)requesterUserId bAnonymous:(BOOL)bAnonymous
{
    NSLog(@"LiveTranscription: onSinkRequestForLiveTranscriptReceived = %@  bAnonymous = %@",@(requesterUserId), @(bAnonymous));
}
@end
