//
//  MyBillTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/21.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBillTool : NSObject

//我的账单
+ (void)myBillListWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSMutableArray *modelArray, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;
@end
