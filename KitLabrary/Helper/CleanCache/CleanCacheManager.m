//
//  CleanCacheManager.m
//  Unity-iPhone
//
//  Created by Mac on 16/8/15.
//
//

#import "CleanCacheManager.h"

@implementation CleanCacheManager

+ (instancetype)sharedManager{
    static CleanCacheManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CleanCacheManager alloc]init];
    });
    
    return manager;
}

-(CGFloat)cleanCache {
    return [self calculateFolderSizeAtPath:[self getPath]];
}

#pragma mark - 计算缓存文件的大小
//找到缓存文件的路径
-(NSString *)getPath {
    //在沙河目录下分为3个文件夹，有Documents,Library,Temp三个文件夹，缓存文件夹位于library文件夹下的cache
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return path;
}

//计算缓存文件夹得大小
-(CGFloat)calculateFolderSizeAtPath:(NSString*)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    CGFloat folderSize = 0.0;
    
    if ([fileManager fileExistsAtPath:path]) {
        
        NSArray *arr = [fileManager subpathsAtPath:path];
        for (NSString *fileName in arr) {
            NSString *filePath = [path stringByAppendingPathComponent:fileName];
            //计算子文件的大小
            CGFloat fileSize = [fileManager attributesOfItemAtPath:filePath error:nil].fileSize;
            //计算出来的文件大小是以字节为单位的
            folderSize += fileSize / 1024 / 1024;
        }
        
        [self deleteFolderSizeWith:folderSize];
        
        
        return folderSize;
    }else {
        return 0.0;
    }
    
}

//给用户弹出提示，让用户自由选择是否清除
-(void)deleteFolderSizeWith:(CGFloat)folerSize {
    
    if (folerSize > 0.01) {
        //提示是否清除
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"当前有%.2fM的缓存，是否清除", folerSize] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        
        [alert show];
        
        
    }else {
        //提示没有更多的缓存需要清理
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"当前没有缓存"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        
        [alert show];
        
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //彻底清除缓存
        [self clearCacheAtPath:[self getPath]];
    }
}

-(void)clearCacheAtPath :(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *arr = [fileManager subpathsAtPath:path];
        for (NSString *fileName in arr) {
            //过滤掉不清除的文件
            if ([fileName hasSuffix:@"mp3"]) {
                continue;
            }else {
                NSString *filePath = [path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:filePath error:nil];
            }
        }
    }
}

@end
