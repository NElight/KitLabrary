//
//  ScanVideo3DViewController.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/8/25.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "ScanVideo3DViewController.h"
#import "MyVideoViewController.h"

#import "Teach3DViewController.h"
#import "AppDelegate.h"

@interface ScanVideo3DViewController (){
    UIView *_navView;
}

@property (strong, nonatomic) UIImageView *picView;

@property (strong, nonatomic) UIButton *playBtn;


@property (strong, nonatomic) UITextView *descriptionTextView;

@end

@implementation ScanVideo3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self createNav];
        [self createUI];
    }
    return self;
}

#pragma mark - 创建假导航
- (void)createNav {
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_HEIGHT, 44)];
    _navView.backgroundColor = [UIColor colorWithHexString:yioks_0x_green_main];
    [self.view addSubview:_navView];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 5, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
}

- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createUI {
    self.picView = [[UIImageView alloc]init];
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.descriptionTextView = [[UITextView alloc]init];
    
    //    self.picView.backgroundColor = [UIColor clearColor];
    self.playBtn.backgroundColor = [UIColor colorWithRed:0.52 green:0.73 blue:0.15 alpha:1.00];
    [self.playBtn setImage:[[UIImage imageNamed:@"视频库"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    self.playBtn.layer.cornerRadius = Btn_CornerRadius;
    self.playBtn.clipsToBounds = YES;
    _playBtn.titleLabel.font = UIFont_Font(k2FontSize);
    
    self.descriptionTextView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    self.descriptionTextView.text = @"";
    self.descriptionTextView.editable = NO;
    
    [self.playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.picView];
    [self.view addSubview:self.playBtn];
    [self.view addSubview:self.descriptionTextView];
    
    ZGWeakSelf(self);
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        ZGStrongSelf(self);
        make.top.equalTo(_navView.mas_bottom).offset = 20;
        make.left.equalTo(self.view.mas_left).offset = 20;
        make.right.equalTo(self.view.mas_centerX);
        make.height.equalTo(self.picView.mas_width).multipliedBy(9.0 / 16.0);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        ZGStrongSelf(self);
        make.top.equalTo(self.picView.mas_bottom).offset = 30;
        make.left.equalTo(self.picView.mas_left);
        make.width.equalTo(self.picView.mas_width);
        make.height.mas_equalTo(30);
    }];
    
    [self.descriptionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        ZGStrongSelf(self);
        make.top.equalTo(_navView.mas_bottom);
        make.left.equalTo(self.view.mas_centerX).offset = 20;
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setModel:(LessonItemModel *)model{
    _model = model;
    [self.picView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kPriServer, self.model.lessonItemInfo1]] placeholderImage:PLACEHOLDER_IMAGE];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:UIFont_Font(k2FontSize),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    if (self.model.lessonItemInfo3) {
        self.descriptionTextView.attributedText = [[NSAttributedString alloc] initWithString:self.model.lessonItemInfo3 attributes:attributes];
    }
    
    //    self.descriptionTextView.text = self.model.lessonItemInfo3;
    if ([model.lessonItemType isEqualToString:@"1"]) {
        [self.playBtn setTitle:@"播放视频" forState:UIControlStateNormal];
    }else if ([model.lessonItemType isEqualToString:@"2"]){
        [self.playBtn setTitle:@"打开3D战术" forState:UIControlStateNormal];
    }
}


//- (void)playBtnClick:(UIButton*)sender {
//    
//    if ([self.model.lessonItemType isEqualToString:@"1"]) {
//        //打开视频
//        CustomMovieViewController *vc = [[CustomMovieViewController alloc]initWithContentURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.mp4", kVideoServer, self.model.lessonItemInfo2]]];
//        [self presentViewController:vc animated:YES completion:nil];
//    }else if ([self.model.lessonItemType isEqualToString:@"2"]) {
//        NSString *xmlURL = [NSString stringWithFormat:@"%@%@",k3DServer, self.model.lessonItemInfo2];
//        Teach3DViewController *teachVc = [[Teach3DViewController alloc] init];
//        teachVc.xml_url = xmlURL;
//        teachVc.tacticalId = self.model.lessonItemId;
//        teachVc.sectionLessonId = self.model.lessonItemInfo4;
//        [self presentViewController:teachVc animated:YES completion:nil];    }
//    
//}

- (BOOL)shouldAutorotate {
    return  NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

