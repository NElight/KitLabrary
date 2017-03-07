//
//  StoryBoardIdentifier.h
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/3.
//
//

#ifndef StoryBoardIdentifier_h
#define StoryBoardIdentifier_h

#define MAIN_STORYBOARD_V1 @"Main"

//StoryBoard中ViewController标识
#define BASE_NAV_VC @"baseNavVC"

#define SERVER_SELECTED_VC @"ServerSelectedVC"

#define AUTO_LOGIN_VC @"AutoLoginVC"

#define LOGIN_VC @"LoginVC"

#define TEACHPLAN_DESCRIBE_VC @"TeachPlanDescribeViewController"


//StoryBoard中segue标识
//战术教学
//跳转登录界面
#define GO_LOGIN_SEGUE @"goLoginSegue"
//跳转主页面
#define GO_HOME_PAGE @"goHomePageSegue"
//从自动登录跳转主页面
#define GO_HOME_PAGE_AUTOLOGIN @"fromAutoLoginToHomePage"

//自动登录失败,返回手动登录
#define GO_LOGIN_BACK @"backToLoginSegue"

//跳转个人中心
#define GO_USER_CENTER @"goUserCenterSegue"

//从个人中心跳转帮助文档
#define GO_HELPPAGE_SEGUE @"fromUserToHelpSegue"

//跳转历史记录
#define GO_HESTORY @"goHistorySegue"
//直接从主页跳转历史记录
#define GO_HISTORY_DIRECT @"directGoHistorySegue"

//跳转课堂教案列表
#define GO_TEACHPLAN_LIST @"goTeachPlanSegue"
//跳转课堂教案信息介绍
#define GO_TEACHPLAN_INFO @"goLessonInfoSegue"
//跳转课堂教案详情
#define GO_TEACHPLAN_DETAIL @"toTeachPlanDetailSegue"
//跳转课堂教案搜索
#define GO_TEACHPLAN_SEARCH @"goLessonSearchSegue"
//跳转搜索结果
#define GO_TEACHPLAN_SEARCH_RESULT @"goTeachPlanSearchResultSegue"
//从搜索结果跳转详情
#define GO_TEACHPLAN_INFO_FROM_RESULT @"fromSearchToInfoSegue"

//根据观看记录直接跳转
#define GO_TEACHPLAN_HISTORY_INFO @"goTeachPlanHistoryInfo"

//视频资源
#define GO_VIDEO_LIST @"goVideoListSegue"
//跳转视频详情
#define GO_VIDEO_INFO @"soVideoInfoSegue"


#pragma mark - v2

#define MIAN_STORYBOARD_V2 @"Main2"

//StoryBoard中ViewController标识
#define SERVER_LIST_VC @"ServerListVC"

#define LOGIN_VC_V2 @"LoginV2VC"

#define TEACH_PLAN_VC @"TeachPlanListViewController"

#define HOME_PAGE_VC @"HomePageViewController"

#define TEACH_PLAN_INFO_VC @"TeachPlanInfoVC"

//StoryBoard中segue标识
//跳转登录界面
#define GO_LOGIN_SEGUE_V2 @"GO_LOGIN_SEGUE_V2"
//跳转主页
#define GO_HOME_PAGE_V2 @"goHomePageV2Segue"
//跳转帮助页面
#define GO_HELP_PAGE_V2 @"goHelpPageV2Segue"

//跳转设置
#define GO_SETTING_PAGE @"goSettingPageSegue"

#define GO_SCAN_RESULT @"goScanResultSegue"

//跳转服务器列表验证
#define GO_DEBUG_SERVER_PAGE @"goDebugMode"


#endif /* StoryBoardIdentifier_h */
