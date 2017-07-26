//
//  LoginTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginTool : NSObject


//发送短信
+ (void)sendMessageWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *stasus))successBlcok errorBlcok:(void(^)(NSError *))errorBlock;


//找回密码
+ (void)getPasswordWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *stasus))successBlcok errorBlcok:(void(^)(NSError *error))errorBlock;

@end
