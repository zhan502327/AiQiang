//
//  MyCollectionTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/10.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyCollectionTool.h"
#import "MyCollectionListResult.h"
#import "MyCollectionListModel.h"

@implementation MyCollectionTool

+ (void)mycollectionListWithParam:(NSDictionary *)param successBlock:(void (^)(MyCollectionListResult *))successBlock errorBlock:(void (^)(NSError *))erroeBlcok{
    
    [[NetworkManager new] postWithURL:MyCollectionListUrl parameter:param success:^(id obj) {
        
        MyCollectionListResult *result = [[MyCollectionListResult alloc] init];
        result.status = obj[@"status"];
        result.total_page = obj[@"total_page"];
        result.msg = obj[@"msg"];
        NSArray *array = obj[@"data"];
        NSMutableArray *resultarray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            MyCollectionListModel *model = [[MyCollectionListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [resultarray addObject:model];
        }
        
        result.modelArray = resultarray;
        if (successBlock) {
            successBlock(result);
        }
    } fail:^(NSError *error) {
        if (erroeBlcok) {
            erroeBlcok(error);
        }
    }];
    
    
}


@end
