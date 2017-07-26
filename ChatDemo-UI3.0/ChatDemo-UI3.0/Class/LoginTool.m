//
//  LoginTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "LoginTool.h"

@implementation LoginTool

//发送短信
+ (void)sendMessageWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *stasus))successBlcok errorBlcok:(void(^)(NSError *))errorBlock{
    
    [[NetworkManager new] postWithURL:SendMessageURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        if (successBlcok) {
            successBlcok(msg,status);
        }
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


//找回密码
+ (void)getPasswordWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *stasus))successBlcok errorBlcok:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:GetPasswordURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        if (successBlcok) {
            successBlcok(msg,status);
        }
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

@end
