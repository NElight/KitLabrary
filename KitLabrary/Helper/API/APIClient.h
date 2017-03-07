//
//  APIClient.h
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/8.
//
//

#import <Foundation/Foundation.h>
#import "HttpTools.h"

#define NoNetwork @"网络加载失败，请检查网络连接"

typedef void(^NetworkSuccessBlock)(NSDictionary* successResult);
typedef void(^NetworkFailBlock)(id failResult);

typedef void(^exceptionCatchBlock)(NSException* exception);

//发送get请求
NSURLSessionDataTask* getRequest(NSString* url, NSDictionary* params, NetworkSuccessBlock successBlock, NetworkFailBlock failBlock);

// 发送post请求
void postRequest(NSString* url, NSDictionary* params, NetworkSuccessBlock successBlock, NetworkFailBlock failBlock);

// 异常捕捉
void catchBlockException(dispatch_block_t tryBlock, exceptionCatchBlock catchBlock);

// 对请求到的数据进一步处理
void processResponse(id responseObj, NetworkSuccessBlock sucBlock, NetworkFailBlock failBlock);
void processError(NSError* error, NetworkFailBlock failBlock);


@interface APIClient : NSObject

#pragma mark - device
+ (NSURLSessionDataTask *)networkForPostDeviceInfosuccess:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

#pragma mark - server
/**
 *  服务器列表
 *
 *  @param success
 *  @param failure
 */
+ (NSURLSessionDataTask *)networkForServerListWithMode:(NSString *)mode success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

/**
 *  服务器详情
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForServerInfosuccess:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

#pragma mark - user
/**
 *  用户登录
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForUserLoginWithUsername:(NSString*)username password:(NSString *)password success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

/**
 *  获取用户信息
 *
 *  @param token   登录时返回的用户token
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForUserInfoWithToken:(NSString *)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

#pragma mark - lesson
/**
 *  教案类型
 *
 *  @param token <#token description#>
 */
+ (NSURLSessionDataTask *)networkForLessonTypeWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

/**
 *  教案列表
 *
 *  @param token       <#token description#>
 *  @param pageNum     <#pageNum description#>
 *  @param lessonType  <#lessonType description#>
 *  @param gradeType   <#gradeType description#>
 *  @param lessonTitle <#lessonTitle description#>
 */
+ (NSURLSessionDataTask *)networkForLessonListWithToken:(NSString *)token pageNum:(NSString*)pageNum lessonType:(NSString*)lessonType gradeType:(NSString*)gradeType lessonTitle:(NSString*)lessonTitle success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

/**
 *  教案详情
 *
 *  @param token    <#token description#>
 *  @param lessonId <#lessonId description#>
 *  @param success  <#success description#>
 *  @param failure  <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForLessonInfoWithToken:(NSString*)token lessonId:(NSString*)lessonId success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;


#pragma mark - video

/**
 *  视频类型
 *
 *  @param token   <#token description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForVideoTypeWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

/**
 *  视频难度等级
 *
 *  @param token   <#token description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForVideoLevelWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

/**
 *  视频列表
 *
 *  @param token      <#token description#>
 *  @param pageNum    <#pageNum description#>
 *  @param videoType  <#videoType description#>
 *  @param videoLevel <#videoLevel description#>
 *  @param videoTitle <#videoTitle description#>
 */
+ (NSURLSessionDataTask *)networkForVideoListWithToken:(NSString*)token pageNum:(NSString*)pageNum videoType:(NSString*)videoType videoLevel:(NSString*)videoLevel videoTitle:(NSString*)videoTitle success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

/**
 *  视频详情
 *
 *  @param token   <#token description#>
 *  @param videoId <#videoId description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForVideoInfoWithToken:(NSString*)token videoId:(NSString*)videoId success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

#pragma mark - tactical

/**
 *  战术资源类型
 *
 *  @param token   <#token description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForTacticalTypeWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

/**
 *  技术分类
 *
 *  @param token   <#token description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForTacticalTechnologyTypeWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

/**
 *  战术列表
 *
 *  @param token          <#token description#>
 *  @param pageNum        <#pageNum description#>
 *  @param tacticalType   <#tacticalType description#>
 *  @param technologyType <#technologyType description#>
 *  @param tacticalTitle  <#tacticalTitle description#>
 *  @param success        <#success description#>
 *  @param failure        <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForTacticalListWithToken:(NSString*)token pageNum:(NSString*)pageNum tacticalType:(NSString*)tacticalType technologyType:(NSString*)technologyType tacticalTitle:(NSString*)tacticalTitle success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

/**
 *  战术详情
 *
 *  @param token      <#token description#>
 *  @param tacticalId <#tacticalId description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForTacticalInfoWithToken:(NSString*)token tacticalId:(NSString*)tacticalId success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;


#pragma mark - technology

/**
 *  技术资源类型
 *
 *  @param token   <#token description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForTechnologyTypeWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;


/**
 技术资源难度

 @param token   <#token description#>
 @param success <#success description#>
 @param failure <#failure description#>

 @return <#return value description#>
 */
+ (NSURLSessionDataTask *)networkForTechnologyLevelWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

/**
 *  技术资源列表
 *
 *  @param token          <#token description#>
 *  @param pageNum        <#pageNum description#>
 *  @param technologyType <#technologyType description#>
 *  @param gradeType      <#gradeType description#>
 *  @param title          <#title description#>
 *  @param success        <#success description#>
 *  @param failure        <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForTechnologyListWithToken:(NSString *)token pageNum:(NSString*)pageNum technologyType:(NSString*)technologyType technologyContentType:(NSString*)technologyContentType technologyLevelType:(NSString *)technologyLevelType technologyTitle:(NSString*)title success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

/**
 *  删除接口_技术详情
 *
 *  @param token        <#token description#>
 *  @param technologyId <#technologyId description#>
 *  @param success      <#success description#>
 *  @param failure      <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForTechnologyInfoWithToken:(NSString*)token technologyId:(NSString*)technologyId success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

#pragma mark - 首页数据

/**
 *  请求首页数据
 *
 *  @param token   <#token description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForHomeDataWithToken:(NSString *)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

#pragma mark - 通知
/**
 *  获取通知列表
 *
 *  @param token   <#token description#>
 *  @param pageNum <#pageNum description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForNoticeListWithToken:(NSString *)token pageNum:(NSString *)pageNum success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

#pragma mark - 课程
/**
 *  课程列表
 *
 *  @param token     <#token description#>
 *  @param pageNum   <#pageNum description#>
 *  @param dataMonth <#dataMonth description#>
 *  @param success   <#success description#>
 *  @param failure   <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForScheduleListWithToken:(NSString *)token pageNum:(NSString *)pageNum dataMonth:(NSString*)dataMonth success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

#pragma mark - 政策法规
/**
 *  法规政策列表
 *
 *  @param token   <#token description#>
 *  @param pageNum <#pageNum description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForPolicyListWithToken:(NSString*)token pageNum:(NSString*)pageNum success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

#pragma mark - 二维码
/**
 *  二维码扫描结果
 *
 *  @param token       <#token description#>
 *  @param scanInfo    <#scanInfo description#>
 *  @param scanInfoKey <#scanInfoKey description#>
 *  @param success     <#success description#>
 *  @param failure     <#failure description#>
 */
+ (NSURLSessionDataTask *)networkForScanResultWithToken:(NSString*)token scanInfo:(NSString*)scanInfo scanInfoKey:(NSString*)scanInfoKey success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;


#pragma mark - 获取比赛类型
/**
 获取比赛类型

 @param token <#token description#>
 @param success <#success description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
+ (NSURLSessionDataTask *)networkForMatchTypeWithToken:(NSString *)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

#pragma mark - 获取比赛列表
/**
 获取比赛列表

 @param token <#token description#>
 @param typeId <#typeId description#>
 @param classTypeId <#classTypeId description#>
 @param groupTypeId <#groupTypeId description#>
 @param statusTypeId <#statusTypeId description#>
 @param matchName <#matchName description#>
 @param success <#success description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
+ (NSURLSessionDataTask *)networkForMatchOfListWithToken:(NSString *)token matchLevel:(NSString *)matchLevel pageNum:(NSString *)pageNum classTypeId:(NSString *)classTypeId groupTypeId:(NSString *)groupTypeId statusTypeId:(NSString *)statusTypeId matchName:(NSString *)matchName success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

#pragma mark - 获取对战列表标签

/**
 获取对战列表标签

 @param token <#token description#>
 @param matchId <#matchId description#>
 @param matchTypeId <#matchTypeId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
+ (NSURLSessionDataTask *)networkForFightTabWithToken:(NSString *)token matchId:(NSString *)matchId matchTypeId:(NSString *)matchTypeId success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;

#pragma mark - 获取对战列表

/**
 获取对战列表

 @param token <#token description#>
 @param matchId <#matchId description#>
 @param matchType <#matchType description#>
 @param fightGroupName <#fightGroupName description#>
 @param success <#success description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
+ (NSURLSessionDataTask *)networkForFightOfListWithToken:(NSString *)token matchId:(NSString *)matchId matchType:(NSString *)matchType fightGroupName:(NSString *)fightGroupName success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure;



@end
