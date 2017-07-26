//
//  FriendsListTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/8.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface FriendsListTool : NSObject


//根据环信id  从自己服务器上获取好友列表信息
+ (void)friendsListWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


//偷好友红包
+ (void)stealRedbagWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//根据手机号和爱抢号查找用户信息
+ (void)searchUserInfoWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status, UserInfoModel *model))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//发送好友验证
+ (void)sendFriendCheckWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


//查询保护期
+ (void)chectoutProtectTimeWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *start_time, NSString *end_time, NSString *else_time,NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//重置保护期
+ (void)resetProtectTimeWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successblock errorblock:(void(^)(NSError *error))errorBlock;

//推荐好友
+ (void)recommendFriendWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *modelArray, NSString *msg, NSNumber *status))successBlock errorblock:(void(^)(NSError *error))errorBlock;


//好友验证列表
+ (void)checklistWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *modelArray, NSString *msg, NSNumber *status))successBlock errorblock:(void(^)(NSError *error))errorBlock;


//同意好友验证
+ (void)agreeFriendApplyWithParam:(NSDictionary *)param successBlock:(void(^)( NSString *msg, NSNumber *status))successBlock errorblock:(void(^)(NSError *error))errorBlock;

//删除好友验证
+ (void)deleteCheckWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successBlock errorblock:(void(^)(NSError *error))errorBlock;

@end
