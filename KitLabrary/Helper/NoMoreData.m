//
//  NoMoreData.m
//  YioksFootball-Test
//
//  Created by PingXuhui on 16/8/20.
//  Copyright © 2016年 PingXuhui. All rights reserved.
//

#import "NoMoreData.h"

@implementation NoMoreData

+ (void)noMoreDataWithTableView:(UITableView *)tableview{
    [tableview.mj_header endRefreshing];
    [tableview.mj_footer endRefreshing];
}

+ (void)noMoreDataWithTableView:(UITableView *)tableview dataArray:(NSArray *)array{
    /**
     *  总条数 % 每页显示的条数 != 0
     */
    if (array.count % 10 != 0 || array.count == 0) {
        [tableview.mj_header endRefreshing];
        [tableview.mj_footer endRefreshingWithNoMoreData];
    }
    else {
        [tableview.mj_header endRefreshing];
        [tableview.mj_footer endRefreshing];
    }

}

@end
