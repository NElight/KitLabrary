//
//  HttpTools.h
//  Unity-iPhone
//
//  Created by Mac on 16/8/5.
//
//

#import <Foundation/Foundation.h>

typedef void(^NetworkSuccessBlock)(NSDictionary* successResult);
typedef void(^NetworkFailBlock)(id failResult);
typedef void(^NetworkProgressBlock)(NSProgress *progress);


@interface HttpTools : NSObject

+ (NSURLSessionDataTask *)get:(NSString *)url
     params:(NSDictionary *)params
    progress:(void (^)(NSProgress *progress))progress
    success:(void (^)(id responseObj))success
    failure:(void (^)(NSError *error))failure;

//请求xml
+ (void)getXML:(NSString *)url
     params:(NSDictionary *)params
   progress:(void (^)(NSProgress *progress))progress
    success:(void (^)(id responseObj))success
    failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     progress:(void (^)(NSProgress *progress))progress
     success:(void (^)(id responseObj))success
     failure:(void (^)(NSError *error))failure;

+(void)PostImageWithUrl:(NSString *)url
                 params:(NSDictionary *)params
                   data:(NSData *)data
                progress:(void (^)(NSProgress *progress))progress
                success:(void (^)(id responseObj))success
                failure:(void (^)(NSError *error))failure;

+(void)downloadFileWithUrl:(NSString *)url
                  filePath:(NSString *)aFilePath
                  fileName:(NSString *)aFileName
                  progress:(void (^)(NSProgress *progress))progress
                   success:(void (^)(id responseObj))success;

+(void)downloadXMLWithUrl:(NSString *)url
                 filePath:(NSString *)aFilePath
                 fileName:(NSString *)aFileName
                 progress:(void (^)(NSProgress *progress))progress
                  success:(void (^)(id responseObj))success;

+ (NSURLSessionDataTask *)uploadXMLFileWithUrl:(NSString *)url params:(NSDictionary *)params fileUrl:(NSString *)fileUrl fileName:(NSString *)fileName progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
