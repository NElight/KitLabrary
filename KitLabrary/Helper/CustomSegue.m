//
//  CustomSegue.m
//  UnityFootball
//
//  Created by PingXuhui on 16/11/22.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "CustomSegue.h"

@implementation CustomSegue

-(void)perform{
    /*
    UIViewController* source = self.sourceViewController;
    
    UIViewController* destination = self.destinationViewController;
    
//    UIGraphicsBeginImageContext(destination.view.bounds.size);
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    [destination.view.layer renderInContext:contextRef];
//    UIImage* desImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    UIImageView* iView = [[UIImageView alloc] initWithImage:desImage];
//    [iView setBackgroundColor:[UIColor grayColor]];
//    iView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    iView.contentMode = UIViewContentModeCenter;
//    
//    [source.parentViewController.view addSubview:iView];
//    
//    CGAffineTransform scaleT = CGAffineTransformMakeScale(0.1, 0.1);
//    
//    CGAffineTransform rotateT = CGAffineTransformMakeRotation(M_PI);
//    
//    //iView.transform = CGAffineTransformConcat(scaleT, rotateT);
//    iView.transform =CGAffineTransformTranslate(CGAffineTransformConcat(scaleT, rotateT), 1, 1);
//    CGPoint originPoint =  iView.center;
//    iView.center = CGPointMake(iView.bounds.size.width, iView.bounds.size.height);
    
    //iView.center = CGPointMake(originPoint.x -iView.bounds.size.width, originPoint.y);
     */
    [UIView animateKeyframesWithDuration:0.8 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
//        iView.transform = CGAffineTransformIdentity;
//        iView.center = originPoint;
        
    }completion:^(BOOL finished) {
        
        
        [self.sourceViewController.navigationController pushViewController:self.destinationViewController animated:NO];
//        [iView removeFromSuperview];
    }];
//    UIViewController *sourceViewController = self.sourceViewController;
//    UIViewController *destinationViewController = self.destinationViewController;
//    
//    // Add the destination view as a subview, temporarily
//    [sourceViewController.view addSubview:destinationViewController.view];
//    
//    // Transformation start scale
//    destinationViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
//    
//    // Store original centre point of the destination view
//    CGPoint originalCenter = destinationViewController.view.center;
//    // Set center to start point of the button
//    destinationViewController.view.center = self.originatingPoint;
//    
//    [UIView animateWithDuration:0.5
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         // Grow!
//                         destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
//                         destinationViewController.view.center = originalCenter;
//                     }
//                     completion:^(BOOL finished){
//                         [destinationViewController.view removeFromSuperview]; // remove from temp super view
//                         [sourceViewController.navigationController pushViewController:destinationViewController animated:NO]; // present VC
//                     }];
    
    }

@end
