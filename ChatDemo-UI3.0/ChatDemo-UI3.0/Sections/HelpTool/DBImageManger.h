//
//  DBImageManger.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/14.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBImageManger : NSObject

//压缩图片 --- 方法一
+ (NSData *)imageMangerWithImage:(UIImage *)image andMaxSize:(NSInteger)maxSize;

//压缩图片 --- 方法二
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize forImage:(UIImage *)originImage;

@end
