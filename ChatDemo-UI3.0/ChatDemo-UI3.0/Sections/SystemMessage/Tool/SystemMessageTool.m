//
//  SystemMessageTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/16.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "SystemMessageTool.h"
#import "SystemMessageListModel.h"

@implementation SystemMessageTool

//获取系统消息
+ (void)systemMessageListWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray * array , NSNumber *status, NSString *msg))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    
    [[NetworkManager new] postWithURL:GetSystemMessageURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        NSArray *array = obj[@"data"];
        NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *dic in array) {
            SystemMessageListModel *model = [[SystemMessageListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [modelArray addObject:model];
        }
        
        if (successBlock) {
            successBlock(modelArray, status, msg);
        }
        
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

@end
