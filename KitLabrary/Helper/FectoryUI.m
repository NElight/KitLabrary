//
//  FectoryUI.m
//  
//
//  Created by light on 16/8/5.
//  Copyright © 2016年 light. All rights reserved.
//

#import "FectoryUI.h"

@implementation FectoryUI

//UIView
+(UIView*)createViewWithFrame:(CGRect)frame{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    return view;
}

//UILabel
+(UILabel*)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor font:(UIFont*)font textAliment:(NSTextAlignment)textAliment{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.backgroundColor = backgroundColor;
    label.font = font;
    label.textAlignment = textAliment;
    return label;
}

//UIButton
+(UIButton*)createButtonWithFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)titleColor backgroundColor:(UIColor*)backgroundColor type:(UIButtonType)type target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//UIImageView
+(UIImageView*)createImageViewWithFrame:(CGRect)frame imageName:(NSString*)imageName{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

//UITextField
+(UITextField*)createTextFieldWithFrame:(CGRect)frame text:(NSString*)text placeholder:(NSString*)placeholder{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.text = text;
    textField.placeholder = placeholder;
    return textField;
}

//UITableView
+(UITableView*)createTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle scrollEnable:(BOOL)scrollEnable borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:style];
    
    tableView.separatorStyle = separatorStyle;
    tableView.scrollEnabled = scrollEnable;
    tableView.layer.borderWidth = borderWidth;
    tableView.layer.borderColor = borderColor.CGColor;
    
    return tableView;
}

//从nib中加载视图
+(id)loadViewWithNibName:(NSString*)nibName{
    UIView *view = nil;
    @try {
        UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
        NSArray *arr = [nib instantiateWithOwner:self options:nil];
        view = arr[0];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    } @finally {
        
    }
    
    return view;
    
}



@end
