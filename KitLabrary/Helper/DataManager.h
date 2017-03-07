//
//  DataManager.h
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/7/28.
//
//

#import <Foundation/Foundation.h>
#import "StandingViewController.h"

@interface DataManager : NSObject


@property (nonatomic) BOOL isInMyHomeView;

@property (nonatomic, strong) UIWindow *myWindow;

@property (nonatomic, strong) UIViewController *unityViewController;

@property (nonatomic, strong) UIViewController *homeViewController;

@property (nonatomic) BOOL isRestartInUnity;

@property (nonatomic, strong) NSMutableArray *dataTaskArray;

//积分版
@property (nonatomic, strong) StandingViewController *standVC;


+ (instancetype) sharedManager;

+ (void)cancelOutOfDateNetworking;

+ (void)cancelNetwork:(NSURLSessionDataTask*)task;

@end
