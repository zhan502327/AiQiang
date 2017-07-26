//
//  MySettingTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/18.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySettingTool : NSObject

//修改密码
+ (void)configPasswordWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *num))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//验证短信验证码
+ (void)chectoutMessageCodeWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *num))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


@end
