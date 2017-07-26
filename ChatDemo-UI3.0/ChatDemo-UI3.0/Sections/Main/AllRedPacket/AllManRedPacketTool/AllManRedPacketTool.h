//
//  AllManRedPacketTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/28.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllManRedPacketPingLunListResult.h"
#import "AllManRedPacketResult.h"
#import "StealRedBagResult.h"

@interface AllManRedPacketTool : NSObject

//获取全民红包的列表页
+ (void)getAllManRedPacketListWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *maxarray,NSMutableArray *minArray,AllManRedPacketResult *result))successBlock errorBlock:(void(^)(NSError *error))errorBlock;



//获取红包详情评论
+ (void)getAllManRedPacketPinglunListWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(AllManRedPacketPingLunListResult *))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


//红包点赞
+ (void)redBagClickZanWithParam:(NSDictionary *)param andRedBagType:(NSString *)redBagType successBlock:(void(^)(NSString *msg))successBlock errorBlock:(void(^)(NSError *erreo))errorBlock;

//红包收藏
+ (void)collectionRedBagWithParam:(NSDictionary *)param andRedBagType:(NSString *)redBagType successBlock:(void(^)(NSString *msg))successBlcok errorBlock:(void(^)(NSError *error))errorBlock;

//发布红包
+ (void)publishRedBagWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


//更改用户性别
+ (void)configSexWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg,NSNumber *num))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//偷全民红包
+ (void)stealAllManRedBagWithParam:(NSDictionary *)param successBlock:(void(^)(StealRedBagResult *result))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//全民红包发表评论
+ (void)allManRedBagSendCommentWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg,NSNumber *num))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


@end
