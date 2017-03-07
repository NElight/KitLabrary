//
//  APIClient.m
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/8.
//
//

#import "APIClient.h"
#import "Urls.h"
#import "UIDevice+UserInfo.h"
#import "BaseNavViewController.h"
#import "OfflineCacheManager.h"

void tokenError() {
    [SVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
    [OfflineCacheManager deleteOfflineFile];
    UIApplication *app = [UIApplication sharedApplication];
    BaseNavViewController *nav = (BaseNavViewController*)app.delegate.window.rootViewController;
    @try {
        [nav popToRootViewControllerAnimated:YES];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma mark - - 发送请求
NSURLSessionDataTask* getRequest(NSString* url, NSDictionary* params, NetworkSuccessBlock successBlock, NetworkFailBlock failBlock)
{
    NSURLSessionDataTask *task = [HttpTools get:url params:params progress:^(NSProgress *progress) {
        
    } success:^(id responseObj) {
        processResponse(responseObj, successBlock, failBlock);
    } failure:^(NSError *error) {
        if ([params[@"a"] isEqualToString:kPostDeviceInfo] || [params[@"a"] isEqualToString:kPostErrorInfo]) {
            return;
        }
        processError(error, failBlock);
    }];
    return task;
}

void postRequest(NSString* url, NSDictionary* params, NetworkSuccessBlock successBlock, NetworkFailBlock failBlock)
{
    [HttpTools post:url params:params progress:^(NSProgress *progress) {
        
    } success:^(id responseObj) {
        processResponse(responseObj, successBlock, failBlock);
    } failure:^(NSError *error) {
        processError(error, failBlock);
    }];
}

#pragma mark - - 对请求到的数据进一步处理
void processResponse(id responseObj, NetworkSuccessBlock sucBlock, NetworkFailBlock failBlock)
{
    catchBlockException(^{
        NSDictionary* responseDic = (NSDictionary*)responseObj;
        if ([responseDic[@"code"] intValue] == 0) {
            catchBlockException(^{
                if (sucBlock) {
                    sucBlock(responseDic);
                }
            }, nil);
        }
        else {
            catchBlockException(^{
                if (sucBlock) {
                    if ([responseDic[@"code"] intValue] == -201) {
                        tokenError();
                        failBlock(@"登录失效，请重新登录");
                    }else if ([responseDic[@"code"] intValue] < 0) {
                        sucBlock(responseDic);
                    }           
                }
            }, nil);
        }
    }, ^(NSException *exception) {
        NSLog(@"responseObj:%@ \n-- exception:%@", [responseObj toJSONString], exception);
        if (failBlock) {
            failBlock(@"请求失败，请稍后重试");
        }
    });
}

void processError(NSError* error, NetworkFailBlock failBlock)
{
    NSLog(@"request error:%@", error);
    
    if (failBlock) {
        if (error.code==-1009) {
            [SVProgressHUD showErrorWithStatus:NoNetwork];
            
            failBlock(NoNetwork);
        }else if (error.code == -1001){
            
            [SVProgressHUD showErrorWithStatus:@"请求超时"];
            failBlock(@"请求超时");
            
        }else if (error.code == -999) {
            // 取消请求
            failBlock(error.localizedDescription);
        }else if (error.code == 3840){
            //平台不正确
//            failBlock(@"非本平台账号");
            failBlock(@"未知错误");
        }else {
            failBlock(error.localizedDescription);
        }
    }
    
}



#pragma mark - - 异常捕获 block
void catchBlockException(dispatch_block_t tryBlock, exceptionCatchBlock catchBlock)
{
    @try {
        if (tryBlock) {
            tryBlock();
        }
    }
    @catch (NSException *exception) {
        NSLog(@"(-- %s --)exception:%@", __func__, exception);
        if (catchBlock) {
            catchBlock(exception);
        }
    }
}



@implementation APIClient

#pragma mark - device
+ (NSURLSessionDataTask *)networkForPostDeviceInfosuccess:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:3];
    [param setObject:kPostDeviceInfo forKey:@"a"];
    
    [param setObject:@"2" forKey:@"devType"];
    [param setObject:[UIDevice currentDevice].localizedModel forKey:@"devName"];
    [param setObject:[UIDevice getDeviceDesciption] forKey:@"devInfo"];
    
    
    NSURLSessionDataTask *task = getRequest(kPubServer, param, success, failure);
    return task;
}

#pragma mark - 获取服务器列表
+ (NSURLSessionDataTask *)networkForServerListWithMode:(NSString *)mode success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
    [param setObject:kGetServerList forKey:@"a"];
    
    if ([mode isEqualToString:@"1"]) {
        [param setObject:@"debug" forKey:@"m"];
    }else {
        [param setObject:@"app" forKey:@"m"];
    }
    [param setValue:@"2" forKey:@"v"];
    
    NSURLSessionDataTask *task = getRequest(kPubServer, param, success, failure);
    return task;
}

+ (NSURLSessionDataTask *)networkForServerInfosuccess:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:1];
    [param setObject:kGetServerInfo forKey:@"a"];
    
    NSURLSessionDataTask *task = getRequest(kPubServer, param, success, failure);
    return task;
}

#pragma mark - user
+ (NSURLSessionDataTask *)networkForUserLoginWithUsername:(NSString *)username password:(NSString *)password success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:3];
    [param setObject:kUserLogin forKey:@"a"];
    
    [param setObject:username forKey:@"userName"];
    [param setObject:password forKey:@"password"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

+ (NSURLSessionDataTask *)networkForUserInfoWithToken:(NSString *)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:2];
    [param setObject:kGetUserInfo forKey:@"a"];
    [param setObject:token forKey:@"token"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}


#pragma mark - lesson

+ (NSURLSessionDataTask *)networkForLessonTypeWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:2];
    [param setObject:kGetLessonType forKey:@"a"];
    [param setObject:token forKey:@"token"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

+ (NSURLSessionDataTask *)networkForLessonListWithToken:(NSString *)token pageNum:(NSString*)pageNum lessonType:(NSString*)lessonType gradeType:(NSString*)gradeType lessonTitle:(NSString*)lessonTitle success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetLessonList forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:pageNum forKey:@"pageNum"];
    [param setObject:kLessonDefaultItemNum forKey:@"pageData"];
    if (lessonType) {
        [param setObject:lessonType forKey:@"lessonType"];
    }else {
        [param setObject:@"" forKey:@"lessonType"];
    }
    if (gradeType) {
        [param setObject:gradeType forKey:@"gradeType"];
    }else {
        [param setObject:@"" forKey:@"gradeType"];
    }
    
    if (lessonTitle) {
        [param setObject:lessonTitle forKey:@"lessonTitle"];
        
    }else {
        [param setObject:@"" forKey:@"lessonTitle"];
    }
    
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
    
}

+ (NSURLSessionDataTask *)networkForLessonInfoWithToken:(NSString*)token lessonId:(NSString*)lessonId success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetLessonInfo forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:lessonId forKey:@"lessonId"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

#pragma mark - video

+ (NSURLSessionDataTask *)networkForVideoTypeWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:2];
    [param setObject:kGetVideoType forKey:@"a"];
    [param setObject:token forKey:@"token"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

+ (NSURLSessionDataTask *)networkForVideoLevelWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:2];
    [param setObject:kGetVideoLevel forKey:@"a"];
    [param setObject:token forKey:@"token"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

+ (NSURLSessionDataTask *)networkForVideoListWithToken:(NSString*)token pageNum:(NSString*)pageNum videoType:(NSString*)videoType videoLevel:(NSString*)videoLevel videoTitle:(NSString*)videoTitle success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetVideoList forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:pageNum forKey:@"pageNum"];
    [param setObject:kVideoDefaultItemNum forKey:@"pageData"];
    if (videoType) {
        [param setObject:videoType forKey:@"videoType"];
    }else {
        [param setObject:@"" forKey:@"videoType"];
    }
    if (videoLevel) {
        [param setObject:videoLevel forKey:@"videoLevel"];
    }else {
        [param setObject:@"" forKey:@"videoLevel"];
    }
    
    if (videoTitle) {
        [param setObject:videoTitle forKey:@"videoTitle"];
        
    }else {
        [param setObject:@"" forKey:@"lessonTitle"];
    }
    
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

+ (NSURLSessionDataTask *)networkForVideoInfoWithToken:(NSString*)token videoId:(NSString*)videoId success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetVideoInfo forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:videoId forKey:@"videoId"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}


#pragma mark - tactical

+ (NSURLSessionDataTask *)networkForTacticalTypeWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetTacticalType forKey:@"a"];
    [param setObject:token forKey:@"token"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

+ (NSURLSessionDataTask *)networkForTacticalTechnologyTypeWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetTacticalTechnologyType forKey:@"a"];
    [param setObject:token forKey:@"token"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

+ (NSURLSessionDataTask *)networkForTacticalListWithToken:(NSString*)token pageNum:(NSString*)pageNum tacticalType:(NSString*)tacticalType technologyType:(NSString*)technologyType tacticalTitle:(NSString*)tacticalTitle success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetTacticalList forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:pageNum forKey:@"pageNum"];
    [param setObject:kTacticalDefaultItemNum forKey:@"pageData"];
    if (tacticalType) {
        [param setObject:tacticalType forKey:@"tacticalType"];
    }else {
        [param setObject:@"" forKey:@"tacticalType"];
    }
    
    if (technologyType) {
        [param setObject:technologyType forKey:@"technologyType"];
    }else {
        [param setObject:@"" forKey:@"technologyType"];
    }
    
    if (tacticalTitle) {
        [param setObject:tacticalTitle forKey:@"tacticalTitle"];
        
    }else {
        [param setObject:@"" forKey:@"tacticalTitle"];
    }
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

+ (NSURLSessionDataTask *)networkForTacticalInfoWithToken:(NSString*)token tacticalId:(NSString*)tacticalId success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetTacticalInfo forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:tacticalId forKey:@"tacticalId"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}


#pragma mark - technology

+ (NSURLSessionDataTask *)networkForTechnologyTypeWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetTechnologyType forKey:@"a"];
    [param setObject:token forKey:@"token"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

+ (NSURLSessionDataTask *)networkForTechnologyLevelWithToken:(NSString*)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetTechnologyLevel forKey:@"a"];
    [param setObject:token forKey:@"token"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}


+ (NSURLSessionDataTask *)networkForTechnologyListWithToken:(NSString *)token pageNum:(NSString*)pageNum technologyType:(NSString*)technologyType technologyContentType:(NSString*)technologyContentType technologyLevelType:(NSString *)technologyLevelType technologyTitle:(NSString*)title success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetTechnologyList forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:pageNum forKey:@"pageNum"];
    [param setObject:kTechnologyDefaultItemNum forKey:@"pageData"];
    if (technologyType) {
        [param setObject:technologyType forKey:@"technologyType"];
    }else {
//        [param setObject:@"" forKey:@"technologyType"];
    }
    if (technologyContentType) {
        [param setObject:technologyContentType forKey:@"technologyContentType"];
    }else {
//        [param setObject:@"" forKey:@"technologyContentType"];
    }
    if (technologyLevelType) {
        [param setObject:technologyLevelType forKey:@"technologyLevelType"];
    }else {
//        [param setObject:@"" forKey:@"technologyLevelType"];
    }
    
    if (title) {
        [param setObject:title forKey:@"technologyTitle"];
        
    }else {
        [param setObject:@"" forKey:@"technologyTitle"];
    }
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}


+ (NSURLSessionDataTask *)networkForTechnologyInfoWithToken:(NSString*)token technologyId:(NSString*)technologyId  success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetTechnologyInfo forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:technologyId forKey:@"technologyId"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
    
}

#pragma mark - 首页数据


+ (NSURLSessionDataTask *)networkForHomeDataWithToken:(NSString *)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetHomeData forKey:@"a"];
    [param setObject:token forKey:@"token"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

#pragma mark - 通知
+ (NSURLSessionDataTask *)networkForNoticeListWithToken:(NSString *)token pageNum:(NSString *)pageNum success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetNoticeList forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:kNoticeDefaultItemNum forKey:@"pageData"];
    [param setObject:pageNum forKey:@"pageNum"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

#pragma mark - 课程

+ (NSURLSessionDataTask *)networkForScheduleListWithToken:(NSString *)token pageNum:(NSString *)pageNum dataMonth:(NSString*)dataMonth success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetScheduleList forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:kScheduleDefaultItemNum forKey:@"pageData"];
    [param setObject:pageNum forKey:@"pageNum"];
    [param setObject:dataMonth forKey:@"dateMonth"];
//    [param setObject:@"" forKey:@"dataMonth"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

#pragma mark - 政策法规

+ (NSURLSessionDataTask *)networkForPolicyListWithToken:(NSString*)token pageNum:(NSString*)pageNum success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetPolicyList forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:kPolicyDefaultItemNum forKey:@"pageData"];
    [param setObject:pageNum forKey:@"pageNum"];
    [param setObject:@"2" forKey:@"v"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

#pragma mark - 二维码

+ (NSURLSessionDataTask *)networkForScanResultWithToken:(NSString*)token scanInfo:(NSString*)scanInfo scanInfoKey:(NSString*)scanInfoKey success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetScan forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:scanInfo forKey:@"scanInfo"];
    if (scanInfoKey) {
        [param setObject:scanInfoKey forKey:@"scanInfoKey"];
    }
    
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

#pragma mark - 获取比赛类型
+ (NSURLSessionDataTask *)networkForMatchTypeWithToken:(NSString *)token success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetMatchType forKey:@"a"];
    [param setObject:token forKey:@"token"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}

#pragma mark - 获取比赛列表
+ (NSURLSessionDataTask *)networkForMatchOfListWithToken:(NSString *)token matchLevel:(NSString *)matchLevel pageNum:(NSString *)pageNum classTypeId:(NSString *)classTypeId groupTypeId:(NSString *)groupTypeId statusTypeId:(NSString *)statusTypeId matchName:(NSString *)matchName success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetMatchOfList forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:kMatchDefaultItemNum forKey:@"pageData"];
    
    [param setObject:pageNum forKey:@"pageNum"];
    
    if (matchLevel) {
        [param setObject:matchLevel forKey:@"matchLevel"];
    }
    
    if (classTypeId) {
        [param setObject:classTypeId forKey:@"classTypeId"];
    }
    
    if (groupTypeId) {
        [param setObject:groupTypeId forKey:@"groupTypeId"];
    }
    
    if (statusTypeId) {
        [param setObject:statusTypeId forKey:@"statusTypeId"];
    }
    
    if (matchName) {
        [param setObject:matchName forKey:@"matchName"];
    }
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
    
}

#pragma mark - 获取对战列表
+ (NSURLSessionDataTask *)networkForFightOfListWithToken:(NSString *)token matchId:(NSString *)matchId matchType:(NSString *)matchType fightGroupName:(NSString *)fightGroupName success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetFightOfList forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:matchId forKey:@"matchId"];
    [param setObject:matchType forKey:@"matchType"];
    if (fightGroupName) {
        [param setObject:fightGroupName forKey:@"fightGroupName"];
    }
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
    
}

#pragma mark - 获取对战列表标签
+ (NSURLSessionDataTask *)networkForFightTabWithToken:(NSString *)token matchId:(NSString *)matchId matchTypeId:(NSString *)matchTypeId success:(NetworkSuccessBlock)success failure:(NetworkFailBlock)failure {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:0];
    [param setObject:kGetFightTab forKey:@"a"];
    [param setObject:token forKey:@"token"];
    [param setObject:matchId forKey:@"matchId"];
    [param setObject:matchTypeId forKey:@"matchTypeId"];
    
    NSURLSessionDataTask *task = getRequest(kPriServer, param, success, failure);
    return task;
}




@end
