//
//  SystemMessageTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/16.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemMessageTool : NSObject

//获取系统消息
+ (void)systemMessageListWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray * array , NSNumber *status, NSString *msg))successBlock errorBlock:(void(^)(NSError *error))errorBlock;



@end
