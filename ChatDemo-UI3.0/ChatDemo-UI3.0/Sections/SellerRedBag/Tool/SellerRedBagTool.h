//
//  SellerRedBagTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/23.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StealRedBagResult.h"
#import "AllManRedPacketPingLunListResult.h"

@interface SellerRedBagTool : NSObject

//获取商家红包列表
+ (void)sellerRedBagWithParam:(NSDictionary *)param successBlock:(void(^)(NSArray *modelArray))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


//获取商家红包详情
+ (void)sellerRedBagDetailWithParam:(NSDictionary *)param successBlock:(void(^)(NSArray *modelArray))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//偷取商家红包
+ (void)stealSellerRedBagWirthParam:(NSDictionary *)param successBlock:(void(^)(StealRedBagResult *result))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//商家红包收藏
+ (void)sellerRedBagCollectionWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg))successBlcok errorBlock:(void(^)(NSError *error))errorBlock;

//商家红包点赞
+ (void)sellerRedBagSetLikedWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg))successBlcok errorBlock:(void(^)(NSError *error))errorBlock;

//商家红包发表评论
+ (void)selletRedBagSendCommnetWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg,NSNumber *num))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//商家红包评论列表
+ (void)sellerRedBagCommentListWithParam:(NSDictionary *)param successBlock:(void (^)(AllManRedPacketPingLunListResult *))successBlock errorBlock:(void (^)(NSError *))errorBlock;


@end
