//
//  UITableView+EmptyData.m
//  YioksFootball-Test
//
//  Created by PingXuhui on 16/8/22.
//  Copyright © 2016年 PingXuhui. All rights reserved.
//

#import "UITableView+EmptyData.h"

@implementation UITableView (EmptyData)

- (void)tableView_endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)tableView_noMoreEndRefreshDataWithArray:(NSArray *)dataArray {
    
    /**
     *  总条数 % 每页显示的条数 != 0
     */
    if (dataArray.count % 10 != 0 || dataArray.count == 0) {
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshingWithNoMoreData];
    }
    else {
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
    }
}

- (void)tableViewDisplayWithImage:(UIImage *)image message:(NSString *)msg ifNecessaryForRowCount:(NSUInteger)rowCount {
    if (rowCount == 0) {
        
//        UIView * view = [UIView new];
        
//        view.backgroundColor = [UIColor clearColor];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80.0 / 448 * 804)];
//        imageView.image = [UIImage imageNamed:@"找不着数据"];
        imageView.image = [[UIImage imageNamed:@"组1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        imageView.contentMode = UIViewContentModeCenter;
//        [view addSubview:imageView];
//        
//        // 没有数据的时候，UILabel的显示样式
//        UILabel *messageLabel = [UILabel new];
//        
//        messageLabel.text = @"哪儿呢哪儿呢？我找不到数据了~";
//        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
//        messageLabel.textColor = [UIColor lightGrayColor];
//        messageLabel.textAlignment = NSTextAlignmentCenter;
//        messageLabel.adjustsFontSizeToFitWidth = YES;
//        messageLabel.numberOfLines = 2;
//        [messageLabel sizeToFit];
//        //        messageLabel.frame = CGRectMake(0, 0, 100, 20);
//        [view addSubview:messageLabel];
//        //        view.backgroundColor = [UIColor redColor];
        self.backgroundView = imageView;
        
//        imageView.center = view.center;
//        messageLabel.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y + imageView.frame.size.height + 15, 200, 20);
//        messageLabel.center = CGPointMake(imageView.center.x, messageLabel.center.y);
//        NSLog(@"!!!!!!!!!%@", NSStringFromCGRect(view.frame));
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

- (void)tableViewDisplayMessage:(NSString *)msg ifNecessaryForRowCount:(NSUInteger)rowCount {
    if (rowCount == 0) {
        
        
        UILabel *msgLabel = [UILabel new];
        msgLabel.text = msg;
        msgLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        msgLabel.textColor = [UIColor lightGrayColor];
        msgLabel.textAlignment = NSTextAlignmentCenter;
        msgLabel.adjustsFontSizeToFitWidth = YES;
        msgLabel.numberOfLines = 2;
        [msgLabel sizeToFit];
        
        self.backgroundView = msgLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

@end
