 //
//  ScanerVC.m
//  SuperScanner
//
//  Created by Jeans Huang on 10/19/15.
//  Copyright © 2015 gzhu. All rights reserved.
//

#import "ScanerVC.h"
#import "ScanerView.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanModel.h"
#import "ScanResultViewController.h"
#import "NoticeWebViewController.h"
#import "TeachPlanInfoViewController.h"
#import "LessonListModel.h"
#import "Teach3DViewController.h"
#import "TeachPlanDescribeViewController.h"
#import "LessonItemModel.h"
#import "ScanVideo3DViewController.h"
#import "MyVideoViewController.h"
#import "CustomMovieViewController.h"
#import "Teach3DModel.h"

@interface ScanerVC ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>{
    ScanModel *_scanModel;
}

//! 加载中视图
@property (weak, nonatomic) IBOutlet UIView     *loadingView;

//! 扫码区域动画视图
@property (weak, nonatomic) IBOutlet ScanerView *scanerView;

//AVFoundation
//! AV协调器
@property (strong,nonatomic) AVCaptureSession           *session;
//! 取景视图
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) UILabel *networkErrorLabel;

@end

@implementation ScanerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scanerView.alpha = 0;
    //设置扫描区域边长
    self.scanerView.scanAreaEdgeLength = [[UIScreen mainScreen] bounds].size.width - 2 * 50;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.scanerView.alpha = 0;
    //设置扫描区域边长
    self.scanerView.scanAreaEdgeLength = [[UIScreen mainScreen] bounds].size.width - 2 * 50;
    
    if (!self.session){
        
        //添加镜头盖开启动画
        [self addCameraAnimation];
        
        //初始化扫码
        [self setupAVFoundation];
        
        //调整摄像头取景区域
        [self modifyCameraFrame];
    }else if (self.session) {
        //添加镜头盖开启动画
        [self addCameraAnimation];
        [self.scanerView startMoveLine];
        [self.session startRunning];
        //调整摄像头取景区域
        [self modifyCameraFrame];
    }
    
    [self judgeNetwork];
    
}

- (void)judgeNetwork {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkOK) name:WIFINetworkNotication object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkOK) name:WWANNetworkNotication object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkError) name:NONetworkNotication object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkError) name:UnKnownNetworkNotication object:nil];
    
    
    
    
}

- (void)networkOK {
    if (self.session) {
        [self.scanerView startMoveLine];
        [self.networkErrorLabel removeFromSuperview];
        self.networkErrorLabel = nil;
    }
    
}

- (void)networkError {
    
    
    self.networkErrorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, 60)];
    self.networkErrorLabel.center = CGPointMake(DEVICE_SCREEN_WIDTH / 2, DEVICE_SCREEN_HEIGHT / 2);
    self.networkErrorLabel.textAlignment = NSTextAlignmentCenter;
    self.networkErrorLabel.textColor = [UIColor whiteColor];
    self.networkErrorLabel.numberOfLines = 2;
    self.networkErrorLabel.font = UIFont_Font(k3FontSize);
    self.networkErrorLabel.text = @"当前网络不可用\n请检查网络设置";
    self.networkErrorLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.networkErrorLabel];
    
    [self.scanerView.qrLine removeFromSuperview];
}

- (void)addCameraAnimation {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.type = @"cameraIrisHollowOpen";
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    animation.delegate = self;
    [self.view.layer addAnimation:animation forKey:@"animation"];
}

- (void)modifyCameraFrame {
    CGRect rect = self.view.bounds;
    rect.origin.y = self.navigationController.navigationBarHidden ? 0 : 64;
    self.previewLayer.frame = rect;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.scanerView.alpha = 0;
}

//! 动画结束回调
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    self.loadingView.hidden = YES;
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.scanerView.alpha = 1;
                         if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus <= 0) {
                             [self networkError];
                         }
                     }];
}


//! 初始化扫码
- (void)setupAVFoundation{
    //创建会话
    self.session = [[AVCaptureSession alloc] init];
    
    
    //获取摄像头设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if(input) {
        [self.session addInput:input];
    } else {
        //出错处理
        NSLog(@"%@", error);
        NSString *msg = [NSString stringWithFormat:@"请在手机【设置】-【隐私】-【相机】选项中，允许【%@】访问您的相机",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]];
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提醒"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
        [av show];
        return;
    }
    
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [self.session addOutput:output];
    
    //设置扫码类型
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
//                                   AVMetadataObjectTypeEAN13Code,//条形码
//                                   AVMetadataObjectTypeEAN8Code,
//                                   AVMetadataObjectTypeCode128Code
                                   ];
   
    //设置代理，在主线程刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //创建摄像头取景区域
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    if ([self.previewLayer connection].isVideoOrientationSupported)
        [self.previewLayer connection].videoOrientation = AVCaptureVideoOrientationPortrait;
    
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter]addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                     object:nil
                                                      queue:[NSOperationQueue mainQueue]
                                                 usingBlock:^(NSNotification * _Nonnull note) {
                                                     if (weakSelf){
                                                         //调整扫描区域
                                                         AVCaptureMetadataOutput *output = weakSelf.session.outputs.firstObject;
                                                         output.rectOfInterest = [weakSelf.previewLayer metadataOutputRectOfInterestForRect:weakSelf.scanerView.scanAreaRect];
                                                    
                                                     }
                                                 }];
    
    //开始扫码
    [self.session startRunning];
}



#pragma mark - AVCaptureMetadataOutputObjects Delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus > 0) {
        
        [self.session stopRunning];
        //扫描成功后移除扫描线
        if (self.scanerView.qrLine) {
            [self.scanerView.qrLine removeFromSuperview];
        }
        
        
        if (metadataObjects != nil && [metadataObjects count] > 0) {
            AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
            if ([metadataObj.type isEqualToString:AVMetadataObjectTypeQRCode]) {
                NSLog(@"%@",metadataObj.stringValue);
                NSLog(@"!!!!!!!!!!!!!!!!!!!%@", metadataObj.corners);
                
                //            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示"
                //                                                        message:metadataObj.stringValue
                //                                                       delegate:self
            //                                              cancelButtonTitle:@"OK"
            //                                              otherButtonTitles: nil];
            //
            //            [av show];
            
        }
    }
        
        NSString *result;
        //解决中文乱码
        for (AVMetadataMachineReadableCodeObject *metadata in metadataObjects) {
            if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
                [self.session stopRunning];
                
                NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                NSData *data = [metadata.stringValue dataUsingEncoding:NSUTF8StringEncoding];
                
                NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
                if (retStr) {
                    NSInteger max = [metadata.stringValue length];
                    char *nbytes = malloc(max + 1);
                    for (int i = 0; i < max; i++) {
                        unichar ch = [metadata.stringValue characterAtIndex:i];
                        nbytes[i] = (char)ch;
                    }
                    nbytes[max] = '\0';
                    result = [NSString stringWithCString:nbytes
                                                encoding:enc];
                    NSLog(@"%@",result);
                }
                
                //判断是否是yioks的二维码
                NSString *str = metadata.stringValue;
                str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                
                
                if ([str containsString:@"&yioksCode"]) {
                    NSRange range = [str rangeOfString:@"yioksCode"];
                    NSString *str1 = [str substringWithRange:NSMakeRange(range.location + 9, str.length - range.location - 9)];
                    [self analysisResult:str1];
                }else {
                    [self handleResult:str];
                }
                
                break;
            }else{
            }
        }
    }
}

#pragma mark - 处理结果

- (void)alertMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (self.session) {
                //添加镜头盖开启动画
                CATransition *animation = [CATransition animation];
                animation.duration = 0.5;
                animation.type = @"cameraIrisHollowOpen";
                animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
                animation.delegate = self;
                [self.view.layer addAnimation:animation forKey:@"animation"];
                [self.scanerView startMoveLine];
                [self.session startRunning];
                //调整摄像头取景区域
                CGRect rect = self.view.bounds;
                rect.origin.y = self.navigationController.navigationBarHidden ? 0 : 64;
                self.previewLayer.frame = rect;
            }else {
                
            }
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

//将一个键值用“:”分开的字符创转化为字典

-(void)analysisResult:(NSString *)message {
    
    
    _scanModel = [[ScanModel alloc]init];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (!error) {
        //a:版本//1校园版，2俱乐部版,0空表示不限
        if ([dic[@"a"] isEqualToString:@"2"]) {
            [self alertMessage:@"该教案不适用本版本"];
            return;
        }else {

        }
        //b:有效时间戳//空表示永不超时
        if (![dic[@"b"] isEqualToString:@""]) {
            //时间戳
            NSDate *localDate = [NSDate date]; //当前时间
            long timeSp = (long)[localDate timeIntervalSince1970];
            if ([dic[@"b"] longLongValue] < timeSp) {
                [self alertMessage:@"该教案已过期"];
                return;
            }
            
        }else {
            
        }
        
        //c:平台//henan.yioks.cn,shandong.yioks.cn空表示不限
        if (![dic[@"c"] isEqualToString:[UserInfoSaveManager dataOfUserDefaultKeyed:YIOKS_USER_DEFAULT_SERVER_HOME]]) {
            //弹框提示不是本平台教案
            [self alertMessage:@"该平台的教案不是本平台的教案"];
            return;
        }else {
            
        }
        
        if (dic[@"z"]) {
            _scanModel = [[ScanModel alloc]init];
            _scanModel.scanType = [dic[@"z"] objectForKey:@"a"];
            _scanModel.scanInfo1 = [dic[@"z"] objectForKey:@"b"];
            _scanModel.scanInfo2 = [dic[@"z"] objectForKey:@"c"];
            _scanModel.scanInfo3 = [dic[@"z"] objectForKey:@"d"];
            _scanModel.scanInfo4 = [dic[@"z"] objectForKey:@"e"];
            _scanModel.scanInfo5 = [dic[@"z"] objectForKey:@"f"];
        }
        
        if (_scanModel) {
            [self handleModel];
        }
        
    }else {
        
        
        
        
    }
    
    
}

- (NSString *)textFromBase64String:(NSString *)base64
{
    if (base64 && ![base64 isEqualToString:@""]) {
        //取项目的bundleIdentifier作为KEY   改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [[NSData alloc]initWithBase64EncodedString:base64 options:0];
        
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return nil;
    }
}

- (NSString *)textFromDecodeBase64String:(NSString *)decodeString {
    return nil;
}

- (void)handleResult:(NSString*)message {
    [APIClient networkForScanResultWithToken:[UserInfoSaveManager dataOfUserDefaultKeyed:YIOKS_USER_TOKEN] scanInfo:message scanInfoKey:@"" success:^(NSDictionary *successResult) {
        
        NSError *error = nil;
        
        _scanModel = [[ScanModel alloc]initWithDictionary:successResult[@"dataInfo"] error:&error];
        if (_scanModel && !error) {
            [self handleModel];
        }
        
        
    } failure:^(id failResult) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示"
                                                    message:@"不能识别的二维码"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
        
        [av show];
        
    }];
}


//根据结果做出相应的相应
- (void)handleModel {
    if([_scanModel.scanType isEqualToString:@"0"]){
        //文本
        //文本内容=scanInfo1
        [self handleTextModel];
        
    }else if([_scanModel.scanType isEqualToString:@"1"]){
        //网址
        //网址=scanInfo1;
        
        [self handleNetModel];
        
        
    }else if([_scanModel.scanType isEqualToString:@"2"]){
        //打开应用
        //应用标示=scanInfo1;
        //应用参数=scanInfo2;
        [self handleModelByAnotherApp];
        
    }else if([_scanModel.scanType isEqualToString:@"10"]){
        //打开3D技术教案
        //图片地址=scanInfo1;
        //文件地址=scanInfo2;
        [self handleTeachPlanTechnologyModel];
        
    }else if([_scanModel.scanType isEqualToString:@"11"]){
        //打开3D战术教案
        //战术图片地址=scanInfo1;
        //战术XML地址=scanInfo2;
        //战术介绍=scanInfo3;
        //战术章节=scanInfo4;//默认值0
        [self handleTeachPlanTacticalModel];
        
    }else if([_scanModel.scanType isEqualToString:@"12"]){
        //打开教学课程
        //教学课程ID=scanInfo1;
        //调用 教案详情API，打开课程教案
        [self handleTeachPlanModel];
        
        
    }else if([_scanModel.scanType isEqualToString:@"13"]){
        //打开视频
        //视频图片地址=scanInfo1;
        //视频地址=scanInfo2;
        //视频介绍=scanInfo3;
        [self handleVideoModel];
        
    }
}

- (void)handleTextModel {
    [self performSegueWithIdentifier:GO_SCAN_RESULT sender:nil];
}

- (void)handleNetModel {
    NoticeWebViewController *webVC = [[NoticeWebViewController alloc]init];
    webVC.noticeUrl = _scanModel.scanInfo1;
    webVC.noticeTitle = @"打开网址";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)handleModelByAnotherApp {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:_scanModel.scanInfo1]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", _scanModel.scanInfo1, _scanModel.scanInfo2]]];
    }
}

- (void)handleTeachPlanTechnologyModel {
    Teach3DViewController *vc = [[Teach3DViewController alloc]init];
    vc.type = TeachPlanTypeTechnology;
    Teach3DModel *model = [[Teach3DModel alloc]init];
    model.teachID = _scanModel.scanInfo2;
    model.teachName = @"";
    model.xml_url = [NSString stringWithFormat:@"%@/uploads/technique/video/ios/%@.assetbundle", k3DImgServer, _scanModel.scanInfo2];
    vc.teach3DModel = model;
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)handleTeachPlanTacticalModel {
    Teach3DViewController *vc = [[Teach3DViewController alloc]init];
    Teach3DModel *model = [[Teach3DModel alloc]init];
    
    NSString *dataID = [_scanModel.scanInfo2 componentsSeparatedByString:@"tactical_id="][1];
    
    model.teachID = dataID;
    model.teachName = @"";
    model.xml_url = _scanModel.scanInfo2;
    vc.teach3DModel = model;
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)handleTeachPlanModel {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TeachPlanInfoViewController *vc = [storyboard instantiateViewControllerWithIdentifier:TEACH_PLAN_INFO_VC];
    LessonListModel *model = [[LessonListModel alloc]init];
    model.ID = _scanModel.scanInfo1;
    vc.listModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleVideoModel {
    CustomMovieViewController *vc = [[CustomMovieViewController alloc]initWithContentURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kVideoServer, _scanModel.scanInfo2]]];
    NSLog(@"%@", [NSString stringWithFormat:@"%@%@", kVideoServer, _scanModel.scanInfo2]);
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:GO_SCAN_RESULT]) {
        ScanResultViewController *vc = segue.destinationViewController;
        vc.scanModel = _scanModel;
    }
}


@end
