//
//  UITableView+EmptyData.h
//  YioksFootball-Test
//
//  Created by PingXuhui on 16/8/22.
//  Copyright © 2016年 PingXuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmptyData)

/**
 tableView 结束刷新
 */
- (void)tableView_endRefresh;


/**
 判断 tableView 数据没有更多
 
 @param dataArray <#dataArray description#>
 */
- (void)tableView_noMoreEndRefreshDataWithArray:(NSArray *)dataArray;

- (void)tableViewDisplayMessage:(NSString *)msg ifNecessaryForRowCount:(NSUInteger)rowCount;


- (void)tableViewDisplayWithImage:(UIImage *)image message:(NSString *)msg ifNecessaryForRowCount:(NSUInteger)rowCount;

@end
