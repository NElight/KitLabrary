//
//  NotificationIdentifier.h
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/12.
//
//

#ifndef NotificationIdentifier_h
#define NotificationIdentifier_h

#define NotificationCenter [NSNotificationCenter defaultCenter]

//网络变化通知
//无网络
#define NONetworkNotication @"NONetwork"
//wifi状态
#define WIFINetworkNotication @"WIFINetwork"
//手机网络
#define WWANNetworkNotication @"WWANNetwork"
//未知网络状态
#define UnKnownNetworkNotication @"UnKnownNetwork"

#define Notification_RefreshNotice @"Notification_refreshNotice"

// unity3d 加载动画完成
#define Unity_Notification_LoadingEnd @"Notification_loadingEnd"
// unity3d 返回
#define Unity_Notification_Back @"Notification_BACK"


#pragma mark - 比赛编辑后通知刷新的通知
#define MatchDeleteMinutesNotification @"MatchDeleteMinutes"
#define MatchInsertMinutesNotification @"MatchInsertMinutes"
#define MatchEditMinutesNotification @"MatchEditMinutes"


#endif /* NotificationIdentifier_h */
