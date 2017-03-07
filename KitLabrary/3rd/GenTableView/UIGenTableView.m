//
//  UIGenTableView.m
//  ISSmartHome
//
//  Created by moorgen on 2016/11/9.
//  Copyright © 2016年 dooya. All rights reserved.
//

#import "UIGenTableView.h"

@implementation UIGenTableView

- (id)init
{
    self = [super init];
    if (self)
    {
        self.delaysContentTouches = NO;
        
        // iterate over all the UITableView's subviews
        for (id view in self.subviews)
        {
            // looking for a UITableViewWrapperView
            if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewWrapperView"])
            {
                // this test is necessary for safety and because a "UITableViewWrapperView" is NOT a UIScrollView in iOS7
                if([view isKindOfClass:[UIScrollView class]])
                {
                    // turn OFF delaysContentTouches in the hidden subview
                    UIScrollView *scroll = (UIScrollView *) view;
                    scroll.delaysContentTouches = NO;
                }
                break;
            }
        }
    }
    return self;
}


- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ([view isKindOfClass:[UIButton class]])
    {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
