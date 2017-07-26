//
//  RedBagChainTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/24.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedBagChainResultModel.h"
#import "RedBagChainResultListModel.h"

@interface RedBagChainTool : NSObject

//验证支付密码
+ (void)checkPayPasswordWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock;


//红包接龙支付押金
+ (void)redBagChainPaymentDepositWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock;

//发接龙红包
+ (void)publishRedBagChainRedbagWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status, NSString *rid))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock;

//抢接龙红包
+ (void)doChainRedBagWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status , NSString *price))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock;

//发群聊红包
+ (void)publishGroupChatRedbagWithWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status, NSString *rid))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock;

//抢群聊红包
+ (void)doGroupChatRedbagWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status , NSString *price))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock;

//红包记录
+ (void)redBagLogWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status, RedBagChainResultModel *model))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock;

//抢红包最大的ID
+ (void)checkoutRedBagMaxIDWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status, NSString *uid))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock;


//退还押金
+ (void)returnDepositWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock;


@end
