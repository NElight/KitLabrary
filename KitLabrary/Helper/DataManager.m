//
//  DataManager.m
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/7/28.
//
//

#import "DataManager.h"
#import "AFHTTPSessionManager+SharedManager.h"

@implementation DataManager

+(instancetype)sharedManager {
    static DataManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[DataManager alloc]init];
    });
    return dataManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isInMyHomeView = NO;
        _isRestartInUnity = NO;
        _dataTaskArray = [NSMutableArray array];
    }
    return self;
}

+ (void)cancelOutOfDateNetworking{
    NSMutableArray *dataTaskArr = [DataManager sharedManager].dataTaskArray;
    @synchronized (dataTaskArr) {
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSLog(@"%@",dataTaskArr);
            for (NSURLSessionDataTask *task in dataTaskArr) {
                [task cancel];
            }
            [dataTaskArr removeAllObjects];
            
        });
    }
    
//    [[AFHTTPSessionManager sharedManager].operationQueue cancelAllOperations];
    
}

+ (void)cancelNetwork:(NSURLSessionDataTask *)task {
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [task cancel];   
    });
}

@end
