//
//  LoadingView.h
//  BookTest
//
//  Created by PingXuhui on 16/8/21.
//  Copyright © 2016年 PingXuhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoBallRotationProgressBar.h"

@protocol LoadingViewDelegate <NSObject>


@optional
- (void)reload;
- (void)exitU3D;

@end

@interface LoadingView : UIView


@property (nonatomic, weak) id<LoadingViewDelegate> delegate;

@property (nonatomic, strong) NSString *loadingText;

@property (nonatomic, strong) NSString *failureText;

@property (nonatomic, strong) UIButton *shutBtn;

@property (nonatomic, strong) TwoBallRotationProgressBar *indicatorBar;

- (instancetype)initWithFrame:(CGRect)frame animationImgArray:(NSArray *)imgArray;

- (void)starAnimation;
- (void)stopAnimation;

- (void)changeImage;


@end
