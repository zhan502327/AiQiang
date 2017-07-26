//
//  MySettingTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/18.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MySettingTool.h"

@implementation MySettingTool

//修改密码
+ (void)configPasswordWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *num))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:ConfigPasswordURL parameter:param success:^(id obj) {
        
        NSString *msg = obj[@"msg"];
        NSNumber *num = obj[@"status"];
        if (successBlock) {
            successBlock(msg,num);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//验证短信验证码
+ (void)chectoutMessageCodeWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *num))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    
    [[NetworkManager new] postWithURL:ChectoutMessageCodeURL parameter:param success:^(id obj) {
        
        NSString *msg = obj[@"msg"];
        NSNumber *num = obj[@"status"];
        if (successBlock) {
            successBlock(msg,num);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
    
}

@end
