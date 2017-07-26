//
//  MyRedBagTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/11.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyRedBagListResult.h"
#import "MyRedBagInfoModel.h"

@interface MyRedBagTool : NSObject


//获取我的红包列表
+ (void)myRedBagListWithParam:(NSDictionary *)param successBlock:(void(^)(MyRedBagListResult *))successBlock errorBlock:(void(^)(NSError *))errorBlock;


//获取我的红包被抢列表
+ (void)myRedBagOverListWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *modelArray, NSString *msg, NSNumber *status))successblock errorBlock:(void(^)(NSError *))errorBlock;

//获取红包信息
+ (void)getAllManRedBagInfoWithParam:(NSDictionary *)param successBlock:(void(^)(MyRedBagInfoModel *model, NSString *msg, NSNumber *status))successblock errorBlock:(void(^)(NSError *))errorBlock;

//重发全民红包
+ (void)resendAllManRedBagWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successblock errorBlock:(void(^)(NSError *error))errorBlock;

@end
