//
//  DBStoreTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/9/29.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBStoreTool.h"
#import "DBStoreListModel.h"

@implementation DBStoreTool

//商城首页列表
+ (void)storeListWithParam:(NSDictionary *)param successBlock:(void(^)(NSArray *modelArray, NSString *msg, NSNumber *status))successBlock errorBlcok:(void(^)(NSError *error))errorBlock{
    
    [[NetworkManager new] postWithURL:StoreMainListURL parameter:param success:^(NSDictionary  *responseObject) {
  
        
        NSArray *array = responseObject[@"data"];
        NSString *msg = responseObject[@"msg"];
        NSNumber *status = responseObject[@"status"];
        
        NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *modelDic in array) {
            DBStoreListModel *model = [[DBStoreListModel alloc] init];
            [model setValuesForKeysWithDictionary:modelDic];
            [modelArray addObject:model];
        }
        
        
        if (successBlock) {
            successBlock(modelArray, msg, status);
        }

    } fail:^(NSError *error){
        if (errorBlock) {
            errorBlock(error);
        }
    }];

    
}

@end
