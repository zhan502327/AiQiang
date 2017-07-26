//
//  MainTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/20.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainTool : NSObject




//首页红包列表
+ (void)mainRedBagListWithParam:(NSDictionary *)param successBlock:(void(^)(NSArray *modelArray))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

@end
