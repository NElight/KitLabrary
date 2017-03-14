//
//  signView.m
//  手写签名
//
//  Created by Yioks-Mac on 16/11/2.
//  Copyright © 2016年 Yioks-Mac. All rights reserved.
//

#import "SignView.h"
#import <CoreGraphics/CoreGraphics.h>

CGPoint midpoint (CGPoint p0, CGPoint p1) {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}

@interface SignView (){
    UIBezierPath *_path;
    CGPoint previousPoint;
    CGContextRef context;
}

@end

@implementation SignView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    context = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] setStroke];
    [_path stroke];
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _path = [UIBezierPath bezierPath];
        _path.lineWidth = 5;

        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;
        [self addGestureRecognizer:pan];
    }
    return self;
}


- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint currentPoint = [pan locationInView:self];
    CGPoint midPoint = midpoint(previousPoint, currentPoint);
    if (pan.state == UIGestureRecognizerStateBegan) {
        [_path moveToPoint:currentPoint];
    }else if (pan.state == UIGestureRecognizerStateChanged) {
//        [_path addLineToPoint:currentPoint];
        [_path addQuadCurveToPoint:midPoint controlPoint:previousPoint];
    }
    previousPoint = currentPoint;
    
    [self setNeedsDisplay];
}

- (UIImage *)imageFromUserWrite {
//    UIGraphicsBeginImageContext(self.bounds.size);
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
//    image = [[self class] imageToTransparent:image];
    return image;
}

/** 颜色变化 */
void ProviderReleaseData (void *info, const void *data, size_t size)
{
    free((void*)data);
}


//颜色替换
+ (UIImage*) imageToTransparent:(UIImage*) image
{
    // 分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
//    int pixelNum = imageWidth * imageHeight;
//    uint32_t* pCurPtr = rgbImageBuf;
//    for (int i = 0; i < pixelNum; i++, pCurPtr++)
//    {
//        //把绿色变成黑色，把背景色变成透明
//        if ((*pCurPtr & 0x65815A00) == 0x65815a00)    // 将背景变成透明
//        {
//            uint8_t* ptr = (uint8_t*)pCurPtr;
//            ptr[0] = 0;
//        }
//        else if ((*pCurPtr & 0x00FF0000) == 0x00ff0000)    // 将绿色变成黑�?
//        {
//            uint8_t* ptr = (uint8_t*)pCurPtr;
//        ptr[3] = 0; //0~255
//        ptr[2] = 0;
//        ptr[1] = 0;
//        }
//        else if ((*pCurPtr & 0xFFFFFF00) == 0xffffff00)    // 将白色变成透明
//        {
//        uint8_t* ptr = (uint8_t*)pCurPtr;
//        ptr[0] = 0;
//        }
//        else
//        {
//        // 改成下面的代码，会将图片转成想要的颜�?
//        uint8_t* ptr = (uint8_t*)pCurPtr;
//        ptr[3] = 0; //0~255
//        ptr[2] = 0;
//        ptr[1] = 0;
//        }
//    }
    
    // 将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    // free(rgbImageBuf) 创建dataProvider时已提供释放函数，这里不用free
    
    return resultUIImage;
}


- (void)clearPath {
    [_path removeAllPoints];
    [self setNeedsDisplay];
}


@end
