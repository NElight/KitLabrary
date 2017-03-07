//
//  ScanResultViewController.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/8/24.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "ScanResultViewController.h"

@interface ScanResultViewController ()


@property (weak, nonatomic) IBOutlet UITextView *messageTextView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;


@end

@implementation ScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
}

- (void)initData {
    self.messageTextView.text = self.scanModel.scanInfo1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
