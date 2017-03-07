//
//  ColorManager.swift
//  UnityFootball
//
//  Created by Yioks-Mac on 17/2/20.
//  Copyright © 2017年 Yioks. All rights reserved.
//

import UIKit

class ColorManager: NSObject {
    
    //主页颜色
    class func getHomePageBgColor() -> UIColor {
        return UIColor.init(red: 0.94, green: 0.94, blue: 0.94, alpha: 1);
    }
    //第一组颜色
    class func getHomeCollectionCellPicTintColor1() -> UIColor {
        return UIColor.white;
    }
    
    class func getHomeCollectionCellPicBgColor1() -> UIColor {
        return UIColor.init(red: 0.47, green: 0.75, blue: 0.43, alpha: 1);
    }
    //第二组颜色
    class func getHomeCollectionCellPicTintColor2() -> UIColor {
        return UIColor.white;
    }
    
    class func getHomeCollectionCellPicBgColor2() -> UIColor {
        return UIColor.init(red: 0.37, green: 0.81, blue: 0.54, alpha: 1);
    }
    
    //分割线颜色
    class func getHomeSeparatorColor() -> UIColor {
        return UIColor.init(red: 0.94, green: 0.94, blue: 0.94, alpha: 1);
    }
    
    //tableView组头颜色设置
    class func getHomeTableViewSectionColor1() -> UIColor {
        return UIColor.init(red: 0.99, green: 0.41, blue: 0.21, alpha: 1);
    }
    
    class func getHomeTableViewSectionColor2() -> UIColor {
        return UIColor.init(red: 0.17, green: 0.73, blue: 0.89, alpha: 1);
    }
    
    class func getHomeTableViewSectionColor3() -> UIColor {
        return UIColor.init(red: 0.36, green: 0.81, blue: 0.53, alpha: 1);
    }
    
    //课程教案
    //列表
    class func getTeachPlanListHeaderBtnSelectedTextColor() -> UIColor {
        return UIColor.init(red: 0.22, green: 0.52, blue: 0.29, alpha: 1);
    }
    
    class func getTeachPlanListHeaderBtnNormalTextColor() -> UIColor {
        return UIColor.black;
    }
    
    class func getTeachPlanListHeaderBtnIndicatorViewColor() -> UIColor {
        return UIColor.init(red: 0.22, green: 0.52, blue: 0.29, alpha: 1);
    }
    
    //章节详情
    class func getTeachPlanInfoTableViewSectionColor() -> UIColor {
        return UIColor.init(red: 0.99, green: 0.41, blue: 0.21, alpha: 1);
    }
    
    class func getTeachPlanDetailBtnCanUseColor() -> UIColor {
        return UIColor.init(red: 0.59, green: 0.80, blue: 0.20, alpha: 1);
    }
    
    class func getTeachPlanDetailBtnCannotUseColor() -> UIColor {
        return UIColor.init(red: 0.52, green: 0.73, blue: 0.15, alpha: 1);
    }
    
    class func getTeachPlanDescribePlayBtnColor() -> UIColor {
        return UIColor.init(red: 0.52, green: 0.73, blue: 0.15, alpha: 1);
    }
    
    class func getTeachPlanDescribeTextViewBgColor() -> UIColor {
        return UIColor.init(red: 0.96, green: 0.96, blue: 0.96, alpha: 1);
    }
    
    //搜索
    class func getTeachPlanSearchSeparatorLineViewColor() -> UIColor {
        return UIColor.init(red: 0.87, green: 0.87, blue: 0.87, alpha: 1);
    }
    
    class func getTeachPlanSearchTypeBtnBorderColor() -> CGColor {
        return UIColor.init(red: 0.91, green: 0.91, blue: 0.91, alpha: 1).cgColor;
    }
    
    class func getTeachPlanSearchTypeBtnSelectedColor() -> UIColor {
        return UIColor.init(red: 0.43, green: 0.71, blue: 0.43, alpha: 1);
    }
    
    class func getTeachPlanSearchTypeBtnNormalColor() -> UIColor {
        return UIColor.init(red: 0.43, green: 0.71, blue: 0.43, alpha: 1);
    }
    
    class func getTeachPlanSearchTypeBtnGrayBgView() -> UIColor {
        return UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1);
    }
    
    class func getTeachPlanSearchTypeBtnLeftRightLineView() -> UIColor {
        return UIColor.init(red: 0.91, green: 0.91, blue: 0.91, alpha: 1);
    }
    
    class func getTeachPlanSearchTypeLoadingIndicatorColor() -> UIColor {
        return UIColor.init(hexString: yioks_0x_green_important);
    }
    
    class func getTeachPlanSearchClearBtnTitleColor() -> UIColor {
        return UIColor.init(red: 0.63, green: 0.63, blue: 0.63, alpha: 1);
    }
    
    //已读通知
    class func getNoticeAlreadyReadColor() -> UIColor {
        return UIColor.init(red: 0.66, green: 0.66, blue: 0.66, alpha: 1);
    }
    
    class func getNoticeNoReadColor() -> UIColor {
        return UIColor.black;
    }
    
    
    
    class func getOneBallColor() -> UIColor {
        return UIColor.green;
    }
    
    class func getTwoBallColor() -> UIColor {
        return UIColor.red;
    }
    
    class func getCustomBorderColor() -> CGColor {
        return UIColor.lightGray.cgColor;
    }
    
    class func getGameListCellBgColor() -> UIColor {
        return UIColor.init(red: 0.94, green: 0.95, blue: 0.95, alpha: 1);
    }

}
