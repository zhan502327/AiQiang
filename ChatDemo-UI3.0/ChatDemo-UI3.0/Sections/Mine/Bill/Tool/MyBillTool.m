//
//  MyBillTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/21.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyBillTool.h"
#import "BillModel.h"

@implementation MyBillTool

//我的账单
+ (void)myBillListWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSMutableArray *modelArray, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    
    [[NetworkManager new] postWithURL:MyBillListURL parameter:param success:^(id obj) {
        NSString *msg = obj[@"msg"];
    
        NSArray *array = obj[@"data"];
        
        NSNumber *status = obj[@"status"];
        
        NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            BillModel *model = [[BillModel alloc] initWithDic:dic];
            [modelArray addObject:model];
        }
        
        if (successBlock) {
            successBlock(msg, modelArray, status);
        }
        
       
    } fail:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
}


@end
