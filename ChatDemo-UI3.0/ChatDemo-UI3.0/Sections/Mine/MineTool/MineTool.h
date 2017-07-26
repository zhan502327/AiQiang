//
//  MineTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface MineTool : NSObject


//获取个人信息
+ (void)userInfoWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(UserInfoModel *model))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//获取账户余额
+ (void)userMoneyWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(NSString *rmb, NSString *balance))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//推荐的人列表
+ (void)getRecommendListWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *modelArray, NSString *msg, NSNumber *status, NSString *code))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

@end
