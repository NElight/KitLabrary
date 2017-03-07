//
//  Urls.h
//  Unity-iPhone
//
//  Created by Mac on 16/8/3.
//
//

#ifndef Urls_h
#define Urls_h


//公共服务器接口：软件升级检测、DEBUG信息提交、服务器列表 
//共有服务器
#define kPubServer @"http://sync.yioks.com/server_api.mpl"
//#define kPubServer @"http://sync.devzz.yioks.org:32280/server_api.mpl"
//#define kPubDevServer @"http://sync.yioks.cn/server_api.mpl"


//除调用公共服务器的接口，其他都调用私有服务器
//私有服务器
//#define kPriServer @"http://dev2015.yioks.org:32280/app_api.mpl"
#define kPriServer [NSString stringWithFormat:@"http://%@/app_api.mpl", [UserInfoSaveManager dataOfUserDefaultKeyed:YIOKS_USER_DEFAULT_SERVER_HOME]]
#define k3DImgServer [NSString stringWithFormat:@"http://%@", [UserInfoSaveManager dataOfUserDefaultKeyed:YIOKS_USER_DEFAULT_SERVER_HOME]]
// 3D教案域名
//#define k3DServer @"http://dev2015.yioks.org:32280"


// 视频域名
#define kVideoServer @"http://rescdn.yioks.cn/uploads/video_library/video/"


//操作类型

#pragma mark - 服务器
//上传设备信息
#define kPostDeviceInfo @"dev_info"

//上传错误信息
#define kPostErrorInfo @"debug_app"

//获取服务器列表
#define kGetServerList @"server_get"

//获取服务器详情信息
#define kGetServerInfo @"server_getInfo"


#pragma mark - 用户
//登录
#define kUserLogin @"user_login"

//获取用户信息
#define kGetUserInfo @"user_get"


#pragma mark - 课程教案
//获取教案类型
#define kGetLessonType @"lesson_getLessonType"

//获取教案列表
#define kGetLessonList @"lesson_getList"

#define kLessonDefaultItemNum @"10"

//获取教案详情
#define kGetLessonInfo @"lesson_getLessonInfo"


#pragma mark - 视频资源
//获取视频类型
#define kGetVideoType @"video_getVideoType"

//获取视频难度等级
#define kGetVideoLevel @"video_getVideoLevel"

//获取视频列表
#define kGetVideoList @"video_getList"

#define kVideoDefaultItemNum @"10"

//获取视频详情
#define kGetVideoInfo @"video_getVideoInfo"


#pragma mark - 战术资源
//获取战术资源类型
#define kGetTacticalType @"tactical_getTacticalType"

//获取战术资源技术分类
#define kGetTacticalTechnologyType @"tactical_getTechnologyType"

//获取战术列表
#define kGetTacticalList @"tactical_getList"

#define kTacticalDefaultItemNum @"10"

//获取战术详情
#define kGetTacticalInfo @"tactical_getTacticalInfo"


#pragma mark - 技术教学
//技术资源类型
#define kGetTechnologyType @"technology_getTechnologyType"

//技术资源难度类型
#define kGetTechnologyLevel @"technology_getTechnologyLevelType"

//获取技术列表
#define kGetTechnologyList @"technology_getList"

#define kTechnologyDefaultItemNum @"10"

//删除接口-技术详情
#define kGetTechnologyInfo @"technology_getTechnologyInfo"

#pragma mark - 首页
//首页数据
#define kGetHomeData @"index_getData"

#pragma mark - 通知
//通知列表
#define kGetNoticeList @"notice_getList"

#define kNoticeDefaultItemNum @"10"

#pragma mark - 课程表
//课程列表
#define kGetScheduleList @"schedule_getList"

#define kScheduleDefaultItemNum @"10"

#pragma mark - 政策法规
//政策法规
#define kGetPolicyList @"policy_getList"

#define kPolicyDefaultItemNum @"10"

#pragma mark - 扫一扫
//扫一扫
#define kGetScan @"scan_get"

#pragma mark - 获取比赛类型

#define kGetMatchType @"match_getMatchLevelList"

#pragma mark - 获取比赛列表

#define kGetMatchOfList @"match_getMatchOfList"

#define kMatchDefaultItemNum @"10"

#pragma mark - 获取对战列表

#define kGetFightOfList @"match_getFightOfList"

#pragma mark - 获取对战列表标签

#define kGetFightTab @"match_getFightTab"

#endif /* Urls_h */
