//
//  LoadingView.m
//  BookTest
//
//  Created by PingXuhui on 16/8/21.
//  Copyright © 2016年 PingXuhui. All rights reserved.
//

#import "LoadingView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"


@interface LoadingView (){
    UITapGestureRecognizer *tap;
    NSTimer *timer;
}

@property (nonatomic, strong) UIView *loadingView;

@property (nonatomic, strong) UIImageView *loopImgView;

@property (nonatomic, strong) UILabel *loadingLabel;

@property (nonatomic, strong) UIView *failView;

@property (nonatomic, strong) UIImageView *failImgView;

@property (nonatomic, strong) UILabel *failLabel;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;





@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame animationImgArray:(NSArray *)imgArray {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createLoadingView];
        [self createFailView];
        
    }
    return self;
}

- (void)createLoadingView {
    
    self.loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
    self.loadingView.center = self.center;
    [self addSubview:self.loadingView];
    
    //    NSArray *imgArray = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],[UIImage imageNamed:@"5"],[UIImage imageNamed:@"6"]];
    
    self.backgroundColor = [UIColor whiteColor];
    //    self.loopImgView = [[UIImageView alloc] init];
    //    self.loopImgView.frame = CGRectMake(20, 0, 40, 40);
    //    self.loopImgView.animationImages = imgArray;
    //    self.loopImgView.animationDuration = 0.3f;
    //    self.loopImgView.animationRepeatCount = 0;
    //    self.loopImgView.image = [UIImage sd_animatedGIFNamed:@"loading"];
    
//    self.indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    self.indicatorView.frame = CGRectMake(15, 0, 40, 40);
//    self.indicatorView.color = [UIColor lightGrayColor];
//    [self.indicatorView startAnimating];
//    
//    [self.loadingView addSubview:self.indicatorView];
    self.indicatorBar = [[TwoBallRotationProgressBar alloc]initWithFrame:CGRectMake(15, 0, 40, 40)];
    [self.loadingView addSubview:self.indicatorBar];
    [self.indicatorBar setOneBallColor:[UIColor greenColor] twoBallColor:[UIColor redColor]];
    //设置俩小球的半径8
    [self.indicatorBar setBallRadius:8];
    //设置动画时间1.5秒
    [self.indicatorBar setAnimatorDuration:1.5];
    [self.indicatorBar setAnimatorDistance:30];
    
    [self.indicatorBar startAnimator];
    
    self.loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 200, 20)];
    CGPoint cPoint = CGPointMake(self.loadingView.bounds.size.width / 2, 50);
    self.loadingLabel.center = cPoint;
    self.loadingLabel.text = @"加载中，请稍候...";
    self.loadingLabel.font = UIFont_Font(k1FontSize);
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.textColor = [UIColor lightGrayColor];
    [self.loadingView addSubview:self.loadingLabel];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(reloadLoadingLabelText:) userInfo:nil repeats:YES];
    
    
    self.shutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shutBtn.frame = CGRectMake(15, 20, 40, 40);
    
    self.shutBtn.hidden = YES;
    [self.shutBtn setImage:[UIImage imageNamed:@"loading-返回"] forState:UIControlStateNormal];
    [self.shutBtn addTarget:self action:@selector(shutDownLoadingViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.shutBtn];
    
}


- (void)reloadLoadingLabelText:(NSTimer *)timer {
    NSArray *textArray = @[@"加载中，请稍候...",@"稍等稍等，马上就来"];
    int r = arc4random() % textArray.count;
    self.loadingLabel.text = textArray[r];
}

- (void)shutDownLoadingViewAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(exitU3D)]) {
        [self.delegate exitU3D];
    }
    //    [self stopAnimation];
}

- (void)createFailView {
    
    self.failView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 150)];
    self.failView.center = self.center;
    [self addSubview:self.failView];
    
    self.failImgView = [[UIImageView alloc]init];
    self.failImgView.frame = CGRectMake(0, 0, 50, 50.0 / 383 * 569);
    self.failImgView.image = [UIImage imageNamed:@"failImage"];
    [self.failView addSubview:self.failImgView];
    
    self.failLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.failImgView.frame), 200, 50)];
    self.failLabel.font = UIFont_Font(k1FontSize);
    self.failLabel.numberOfLines = 2;
    self.failLabel.textColor = [UIColor lightGrayColor];
    
    self.failLabel.text = @"Sorry~,内容出错了~\n请点击重试";
    self.failLabel.textAlignment = NSTextAlignmentCenter;
    self.failLabel.center = CGPointMake(self.failImgView.center.x, self.failLabel.center.y);
    [self.failView addSubview:self.failLabel];
    
    self.failView.hidden = YES;
}

- (void)setFailureText:(NSString *)failureText {
    _failureText = failureText;
    self.failLabel.text = failureText;
}

- (void)starAnimation {
    //    self.hidden = NO;
    //    CABasicAnimation* rotationAnimation;
    //    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    //    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    //    rotationAnimation.duration = 1;
    //    rotationAnimation.cumulative = YES;
    //    rotationAnimation.repeatCount = NSIntegerMax;
    //
    //    [self.loopImgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopAnimation {
    
    [UIView animateWithDuration:0.35f
                     animations:^{
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self.loopImgView stopAnimating];
                         self.hidden = YES;
                         [self removeFromSuperview];
                         [timer invalidate];
                     }];
    
//    CATransition *animation = [CATransition animation];
//    [animation setDuration:0.5f];
//    [animation setType:kCATransitionFade];
//    [animation setFillMode:kCAFillModeForwards];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//    [self.loopImgView stopAnimating];
//    self.hidden = YES;
//    [timer invalidate];
//    [self.layer addAnimation:animation forKey:nil];
    
}

- (void)setLoadingText:(NSString *)loadingText {
    self.loadingLabel.text = loadingText;
}

- (void)changeImage {
    if (self.loadingView.hidden == NO) {
        self.loadingView.hidden = YES;
        self.failView.hidden = NO;
        
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadAgain:)];
        [self addGestureRecognizer:tap];
    }else {
        self.loadingView.hidden = NO;
        self.failView.hidden = YES;
        [self removeGestureRecognizer:tap];
    }
}

- (void)loadAgain:(UITapGestureRecognizer *)tap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(reload)]) {
        [self.delegate reload];
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
