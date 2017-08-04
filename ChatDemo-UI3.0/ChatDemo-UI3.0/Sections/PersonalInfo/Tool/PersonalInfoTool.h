//
//  PersonalInfoTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/19.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface PersonalInfoTool : NSObject

//获取个人信息
+ (void)userInfoWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(UserInfoModel *model))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//更改用户资料
+ (void)configUserInfoWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//设置好友备注
+ (void)setRemarkWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg , NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


@end
