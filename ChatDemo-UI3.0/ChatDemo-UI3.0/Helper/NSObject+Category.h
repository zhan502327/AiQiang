//
//  NSObject+Category.h
//  PianKe
//
//  Created by 闫世宗 on 16/1/8.
//  Copyright © 2016年 YSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;

@interface NSObject (Category)

- (id)initWithDic:(NSDictionary *)dictionary;

- (void)alertShowWithTitle:(NSString *)title Message:(NSString *)message Onebutton:(NSString *)button;

- (void)gotoLoginFromVC:(UIViewController *)vc;

@end
