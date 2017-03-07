//
//  FileStoreManager.h
//  AFNetWorkingDemo
//
//  Created by Yioks-Mac on 16/8/1.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


typedef void(^Success)(NSURL *path);

typedef void(^Failure)(NSError *error);

typedef void(^Progress)(NSProgress *downloadProgress);

@interface FileStoreManager : NSObject

//文件存储的目录
@property (nonatomic, copy) NSString *dirPath;

//文件下载已经完成的百分比
@property (assign, readonly) CGFloat completePercentage;

//文件保存路径
@property (nonatomic, copy, readonly) NSString *filePath;

//文件名称
@property (nonatomic, copy, readonly) NSString *fileName;

+ (instancetype)sharedManager;


//从网络下载文件
-(void)downloadFileFromUrlStr:(NSString *)urlStr progress:(Progress)progress success:(Success)success failure:(Failure)failure;

//暂停
-(void)pauseDownload;

//开始
-(void)resumeDownload;

//指定文件是否存在
-(BOOL)fileExistsWithName:(NSString*)fileName;
-(BOOL)fileExistsWithName:(NSString *)fileName atDirPath:(NSString*)dirPath;
-(BOOL)fileExistsWithName:(NSString *)fileName atDirPath:(NSString*)dirPath isDirectory:(BOOL *)isDirectory;

//查找制定文件的路径
-(NSString*)filePathWithName:(NSString*)fileName;
-(NSString*)filePathWithName:(NSString *)fileName atDirPath:(NSString*)dirPath;

//删除指定文件
-(BOOL)deleteFileName:(NSString*)fileName;
-(BOOL)deleteFileName:(NSString *)fileName atDirPath:(NSString*)dirPath;



@end
