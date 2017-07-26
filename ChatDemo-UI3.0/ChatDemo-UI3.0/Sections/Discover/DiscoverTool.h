//
//  DiscoverTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/27.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverTool : NSObject

//回复评论
+ (void)replyPinglunWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *array,NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


//发布圈子
+ (void)publishDiscoverWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *array))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


//圈子点赞
+ (void)circleSetLikedWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//删除个人动态
+ (void)deleteDiscoverWith:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

@end
