//
//  MyDiscoverTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyDiscoverListResult.h"
#import "Discover.h"

@interface MyDiscoverTool : NSObject
//获取我的动态
+ (void)myDiscoverWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(MyDiscoverListResult *result))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


//与我相关
+ (void)relateMeWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *modelArray, NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

//获取圈子单个信息
+ (void)oneCircleWithParam:(NSDictionary *)param successBlock:(void(^)(Discover *model, NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

@end
