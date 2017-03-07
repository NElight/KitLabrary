//
//  FectoryUI.h
//  
//
//  Created by light on 16/8/5.
//  Copyright © 2016年 light. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FectoryUI : NSObject

//UIView
+(UIView*)createViewWithFrame:(CGRect)frame;

//UILabel
+(UILabel*)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor font:(UIFont*)font textAliment:(NSTextAlignment)textAliment;

//UIButton
+(UIButton*)createButtonWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)titleColor backgroundColor:(UIColor*)backgroundColor type:(UIButtonType)type target:(id)target action:(SEL)action;

//UIImageView
+(UIImageView*)createImageViewWithFrame:(CGRect)frame imageName:(NSString*)imageName;

//UITextField
+(UITextField*)createTextFieldWithFrame:(CGRect)frame text:(NSString*)text placeholder:(NSString*)placeholder;

//UITabelView
+(UITableView*)createTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle scrollEnable:(BOOL)scrollEnable borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor;

+(id)loadViewWithNibName:(NSString*)nibName;

@end
