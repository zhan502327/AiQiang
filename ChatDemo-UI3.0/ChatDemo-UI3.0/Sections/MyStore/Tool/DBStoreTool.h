//
//  DBStoreTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/9/29.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBStoreTool : NSObject


//商城首页列表
+ (void)storeListWithParam:(NSDictionary *)param successBlock:(void(^)(NSArray *modelArray, NSString *msg, NSNumber *status))successBlock errorBlcok:(void(^)(NSError *error))errorBlock;

@end
