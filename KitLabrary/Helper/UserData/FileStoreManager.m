//
//  FileStoreManager.m
//  AFNetWorkingDemo
//
//  Created by Yioks-Mac on 16/8/1.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "FileStoreManager.h"


@interface FileStoreManager (){
    NSURLSessionDownloadTask *_downloadTask;
    
    NSFileManager *_fileManager;
}

@end


@implementation FileStoreManager

+ (instancetype)sharedManager {
    static FileStoreManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FileStoreManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fileManager = [NSFileManager defaultManager];
        _dirPath = [self defaultDirPath];
    }
    return self;
}

-(void)downloadFileFromUrlStr:(NSString *)urlStr progress:(Progress)progress success:(Success)success failure:(Failure)failure {
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:conf];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"%f", downloadProgress.completedUnitCount * 1.0 / downloadProgress.totalUnitCount);
        
        _completePercentage = downloadProgress.completedUnitCount * 1.0 / downloadProgress.totalUnitCount;
        
        progress(downloadProgress);
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!self.dirPath) {
            self.dirPath = [self defaultDirPath];
        }
        
        NSString *filePath = [self.dirPath stringByAppendingPathComponent:response.suggestedFilename];
        _filePath = filePath;
        _fileName = response.suggestedFilename;
        return [NSURL fileURLWithPath:filePath];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //下载完成后的操作
        //@param filePath 文件所在的路径
        if (!error) {
            success(filePath);
        }else {
            failure(error);
        }
    }];
}

- (NSString*)defaultDirPath {
    return _dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

-(void)pauseDownload{
    [_downloadTask suspend];
}

-(void)resumeDownload{
    [_downloadTask resume];
}

//指定文件是否存在
-(BOOL)fileExistsWithName:(NSString*)fileName{
    return [_fileManager fileExistsAtPath:[self.dirPath stringByAppendingPathComponent:fileName]];
}
-(BOOL)fileExistsWithName:(NSString *)fileName atDirPath:(NSString*)dirPath{
    return [_fileManager fileExistsAtPath:[dirPath stringByAppendingPathComponent:fileName]];
}

-(BOOL)fileExistsWithName:(NSString *)fileName atDirPath:(NSString*)dirPath isDirectory:(BOOL *)isDirectory{
    return [_fileManager fileExistsAtPath:[dirPath stringByAppendingPathComponent:fileName] isDirectory:isDirectory];
}

//查找制定文件的路径
-(NSString*)filePathWithName:(NSString*)fileName{
    if ([_fileManager fileExistsAtPath:[self.dirPath stringByAppendingPathComponent:fileName]]) {
        return [self.dirPath stringByAppendingPathComponent:fileName];
    }else {
        return nil;
    }
}
-(NSString*)filePathWithName:(NSString *)fileName atDirPath:(NSString*)dirPath{
    if ([_fileManager fileExistsAtPath:[dirPath stringByAppendingPathComponent:fileName]]) {
        return [dirPath stringByAppendingPathComponent:fileName];
    }else {
        return nil;
    }
    
}

//删除指定文件
-(BOOL)deleteFileName:(NSString*)fileName{
    NSString *filePath = [self.dirPath stringByAppendingPathComponent:fileName];
    if ([_fileManager fileExistsAtPath:filePath]) {
        NSError *error;
        BOOL rel = [_fileManager removeItemAtPath:filePath error:&error];
        return rel;
    }else {
        NSLog(@"文件不存在");
        return YES;
    }
}
-(BOOL)deleteFileName:(NSString *)fileName atDirPath:(NSString*)dirPath{
    NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
    if ([_fileManager fileExistsAtPath:filePath]) {
        NSError *error;
        BOOL rel = [_fileManager removeItemAtPath:filePath error:&error];
        return rel;
    }else {
        NSLog(@"文件不存在");
        return YES;
    }
}

@end
