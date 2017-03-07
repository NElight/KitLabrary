//
//  HttpTools.m
//  Unity-iPhone
//
//  Created by Mac on 16/8/5.
//
//

#import "HttpTools.h"
#import "AFNetworking.h"
#import "DeviceManager.h"
#import "NSString+Hashing.h"
#import "AFHTTPSessionManager+SharedManager.h"
#import "LYHTTPClient.h"
#import "YYCache.h"
#import "NetworkState.h"
#import "DataManager.h"



@implementation HttpTools

//YYCache缓存文件存放的文件夹
NSString * const HttpCache = @"HttpRequestCache";

+ (NSURLSessionDataTask *)get:(NSString *)url params:(NSDictionary *)params progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    
    
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager sharedManager];
    
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    mgr.requestSerializer.timeoutInterval = 20;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (id key in params)
    {
        [dict setObject: [params objectForKey:key]
                 forKey:key];
    }
    
    //在这里添加固定参数
    [dict setObject:[[DeviceManager getUUIDString] MD5Hash] forKey:@"mpKey"];
    
    //时间戳
    NSDate *localDate = [NSDate date]; //当前时间
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localDate timeIntervalSince1970]];
    
    if (![dict valueForKey:@"v"]) {
        
        [dict setValue:@"1" forKey:@"v"]; //版本
    }
    
    [dict setValue:timeSp forKey:@"_t"]; //时间戳
    [dict setValue:@"12" forKey:@"t"];
    [dict setValue:[@"234234234" MD5Hash] forKey:@"dataKey"]; //数据MD5
    [dict setValue:@"3241234" forKey:@"codeKey"];  //指纹key
//    [dict setValue:@"2" forKey:@"devType"];
    //    [dict setValue:@"" forKey:@"token"]; //用户登录标示
//    NSString *fileName = [[self getCacheDictionary] stringByAppendingPathComponent:[[self urlDictToStringWithUrlStr:url WithDict:params] MD5Hash]];
//    if (![NetworkState requestBeforeJudgeConnect]) {
//        if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
//            NSData *data = [[NSData alloc]initWithContentsOfFile:fileName];
//            NSDictionary *resoponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            if (resoponse) {
//                success(resoponse);
//                return nil;
//            }
//        }
//    }
    
    
    // 2.发送GET请求
    NSLog(@"http get: url=%@, params=%@",url, dict);
    NSURLSessionDataTask *task = [mgr GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"http get: url=%@, params=%@, progress=%@",url, dict, downloadProgress);
        if (progress) {
            progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"http get: url=%@, params=%@, response=%@",url, dict, responseObject);
        if (success) {
//            if (![dict[@"a"] isEqualToString:kUserLogin] && [responseObject[@"code"] intValue] == 0) {
//                NSError *err = nil;
//                NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&err];
//                if (!err) {
//                    BOOL rel = [data writeToFile:fileName atomically:YES];
//                    NSLog(@"%d", rel);
//                }
//                
//            }
            
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"http get: url=%@, params=%@, fail=%@",url, dict, error);
        if (failure) {
            failure(error);
        }
    }];
    
    return task;
    
}

+ (NSString *)getCacheDictionary {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
}

#pragma mark - 拼接请求的网络地址
/**
 *  拼接请求的网络地址
 *
 *  @param urlStr     基础网址
 *  @param parameters 拼接参数
 *
 *  @return 拼接完成的网址
 */
+(NSString *)urlDictToStringWithUrlStr:(NSString *)urlString WithDict:(NSDictionary *)parameters
{
    if (!parameters) {
        return urlString;
    }
    
    
    NSMutableArray *parts = [NSMutableArray array];
    //enumerateKeysAndObjectsUsingBlock会遍历dictionary并把里面所有的key和value一组一组的展示给你，每组都会执行这个block 这其实就是传递一个block到另一个方法，在这个例子里它会带着特定参数被反复调用，直到找到一个ENOUGH的key，然后就会通过重新赋值那个BOOL *stop来停止运行，停止遍历同时停止调用block
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //字符串处理
        key=[NSString stringWithFormat:@"%@",key];
        obj=[NSString stringWithFormat:@"%@",obj];
        
        //接收key
        NSString *finalKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //接收值
        NSString *finalValue = [obj stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        
        NSString *part =[NSString stringWithFormat:@"%@=%@",finalKey,finalValue];
        
        [parts addObject:part];
        
    }];
    
    NSString *queryString = [parts componentsJoinedByString:@"&"];
    
    queryString = queryString.length!=0 ? [NSString stringWithFormat:@"?%@",queryString] : @"";
    
    NSString *pathStr = [NSString stringWithFormat:@"%@%@",urlString,queryString];
    
    return pathStr;
    
}

+ (void)getXML:(NSString *)url
        params:(NSDictionary *)params
      progress:(void (^)(NSProgress *progress))progress
       success:(void (^)(id responseObj))success
       failure:(void (^)(NSError *error))failure{
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr setSecurityPolicy:securityPolicy];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (id key in params)
    {
        [dict setObject: [params objectForKey:key]
                 forKey:key];
    }
    
    //在这里添加固定参数
    [dict setObject:[[DeviceManager getUUIDString] MD5Hash] forKey:@"mpKey"];
    
    //时间戳
    NSDate *localDate = [NSDate date]; //当前时间
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localDate timeIntervalSince1970]];
    
    [dict setValue:@"1" forKey:@"v"]; //版本
    [dict setValue:timeSp forKey:@"_t"]; //时间戳
    [dict setValue:@"12" forKey:@"t"];
    [dict setValue:[@"234234234" MD5Hash] forKey:@"dataKey"]; //数据MD5
    [dict setValue:@"3241234" forKey:@"codeKey"];  //指纹key
    //    [dict setValue:@"" forKey:@"token"]; //用户登录标示
    
    
    // 2.发送post请求
    NSLog(@"post get: url=%@, params=%@",url, dict);
    [mgr GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"http post: url=%@, params=%@, progress=%@",url, dict, downloadProgress);
        if (progress) {
            progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"http post: url=%@, params=%@, response=%@",url, dict, responseObject);
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"http post: url=%@, params=%@, fail=%@",url, dict, error);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    mgr.requestSerializer.timeoutInterval = 20;
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (id key in params)
    {
        [dict setObject: [params objectForKey:key]
                 forKey:key];
    }
    
    //在这里添加固定参数
    [dict setObject:[[DeviceManager getUUIDString] MD5Hash] forKey:@"mpKey"];
    
    //时间戳
    NSDate *localDate = [NSDate date]; //当前时间
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localDate timeIntervalSince1970]];
    
    [dict setValue:@"1" forKey:@"v"]; //版本
    [dict setValue:timeSp forKey:@"_t"]; //时间戳
    [dict setValue:@"12" forKey:@"t"];
    [dict setValue:[@"234234234" MD5Hash] forKey:@"dataKey"]; //数据MD5
    [dict setValue:@"3241234" forKey:@"codeKey"];  //指纹key
    //    [dict setValue:@"" forKey:@"token"]; //用户登录标示
    
    
    // 2.发送post请求
    NSLog(@"post get: url=%@, params=%@",url, dict);
    NSURLSessionDataTask *task = [mgr POST:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"http post: url=%@, params=%@, progress=%@",url, dict, downloadProgress);
        if (progress) {
            progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"http post: url=%@, params=%@, response=%@",url, dict, responseObject);
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"http post: url=%@, params=%@, fail=%@",url, dict, error);
        if (failure) {
            failure(error);
        }
    }];
    [[DataManager sharedManager].dataTaskArray addObject:task];
}

+(void)PostImageWithUrl:(NSString *)url
                 params:(NSDictionary *)params
                   data:(NSData *)data
                progress:(void (^)(NSProgress *progress))progress
                success:(void (^)(id))success
                failure:(void (^)(NSError *))failure
{
    
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (id key in params)
    {
        [dic setObject: [params objectForKey:key]
                forKey:key];
    }
    
    //在这里添加固定的参数
    
    
    
    // 2.发送POST请求
    
    
    NSString * fileName = [NSString stringWithFormat:@"%@.jpg",[dic objectForKey:@"fileName"]];
    
    NSURLSessionDataTask *task = [mgr POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"data" fileName:fileName mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            progress(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    [task resume];
}

+(void)downloadFileWithUrl:(NSString *)url
                  filePath:(NSString *)aFilePath
                  fileName:(NSString *)aFileName
                  progress:(void (^)(NSProgress *progress))progress
                  success:(void (^)(id responseObj))success{
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //下载Task操作
    NSURLSessionDownloadTask *_downloadTask = [manager downloadTaskWithRequest:request
                                                                      progress:^(NSProgress * _Nonnull downloadProgress) {
                                                                          
                                                                          progress(downloadProgress);
                                                                          
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSLog(@"1111111111111111111");
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [cachesPath stringByAppendingPathComponent:aFilePath];
        NSString *path = [filePath stringByAppendingPathComponent:aFileName];
        
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSLog(@"22222222222222222222");
        //设置下载完成操作
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        if (!error) {
            success(filePath);
        }else {
            NSLog(@"errorrjiladjfdalijf dsajaldjf");
//            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_BACK" object:nil];
        }
        
        
    }];
    
    //开始下载
    [_downloadTask resume];
}

+(void)downloadXMLWithUrl:(NSString *)url
                  filePath:(NSString *)aFilePath
                  fileName:(NSString *)aFileName
                  progress:(void (^)(NSProgress *progress))progress
                   success:(void (^)(id responseObj))success {
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //下载Task操作
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        success(responseObject);
    }];
    //开始下载
    [task resume];
}



extern NSString *getFightFilePath();

+ (NSURLSessionDataTask *)uploadXMLFileWithUrl:(NSString *)url params:(NSDictionary *)params fileUrl:(NSString *)fileUrl fileName:(NSString *)fileName progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //拿到上传头像的接口
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //设置content-type
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    
    mgr.requestSerializer.timeoutInterval = 20;
    
    
    //参数列表（字典类型）
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (id key in params)
    {
        [dict setObject: [params objectForKey:key]
                 forKey:key];
    }
    
    //在这里添加固定参数
    [dict setObject:[[DeviceManager getUUIDString] MD5Hash] forKey:@"mpKey"];
    
    //时间戳
    NSDate *localDate = [NSDate date]; //当前时间
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localDate timeIntervalSince1970]];
    
    [dict setValue:@"2" forKey:@"v"]; //版本
    [dict setValue:timeSp forKey:@"_t"]; //时间戳
    [dict setValue:@"12" forKey:@"t"];
    [dict setValue:[@"234234234" MD5Hash] forKey:@"dataKey"]; //数据MD5
    [dict setValue:@"3241234" forKey:@"codeKey"];  //指纹key
    //    [dict setValue:@"2" forKey:@"devType"];
    //    [dict setValue:@"" forKey:@"token"]; //用户登录标示
    
    //用post上传图片
    
    /*
     
     第一个参数：接口网址路径
     
     第二个参数：参数列表（字典类型）
     
     第三个参数：上传图片的block(请求体)
     
     第四个参数：进度block
     
     第五个参数：成功block
     
     第六个参数：失败block
     
     */
    
    NSURLSessionDataTask *task = [mgr POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        /*
         
         第一个参数：原始图片位置的URL
         
         第二个参数：名字：这个名字由后台提供
         
         第三个参数：上传后文件的名字，这个名字不重要（自定义）
         
         第四个参数：MIME类型这里是PNG格式图片类型image/png
         
         第五个参数：报错信息
         
         */
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:fileUrl] name:fileName fileName:@"fight" mimeType:@"text/xml" error:nil];
        /*
        超文本标记语言文本.html text/html
        
        xml文档.xml text/xml
        
        XHTML文档.xhtml application/xhtml+xml
        
        普通文本.txt text/plain
        
        RTF文本.rtf application/rtf
        
        PDF文档.pdf application/pdf
        
        Microsoft Word文件.word application/msword
        
        PNG图像.png image/png
        
        GIF图形.gif image/gif
        
        JPEG图形.jpeg,.jpg image/jpeg
        
        au声音文件.au audio/basic
        
        MIDI音乐文件mid,.midi audio/midi,audio/x-midi
        
        RealAudio音乐文件.ra, .ram audio/x-pn-realaudio
        
        MPEG文件.mpg,.mpeg video/mpeg
        
        AVI文件.avi video/x-msvideo
        
        GZIP文件.gz application/x-gzip
        
        TAR文件.tar application/x-tar
        
        任意的二进制数据application/octet-stream
        
        */
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    return task;
    
}



@end
