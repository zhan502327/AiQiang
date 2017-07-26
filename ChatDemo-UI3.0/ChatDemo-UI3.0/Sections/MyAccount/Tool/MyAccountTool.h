//
//  MyAccountTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/16.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAccountTool : NSObject

//设置支付密码
+ (void)setupPasswordWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


//支付宝充值
+ (void)aliPayChongzhiWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSString *data, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


//提现记录
+ (void)tixianListWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSMutableArray *modelArray, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


//现金余额 提现
+ (void)rmbWithDrawWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//红包余额 提现到 现金余额
+ (void)redBagTixainToRMBWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

@end
