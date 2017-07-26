//
//  MainTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/20.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MainTool.h"
#import "SellerRedBagListModel.h"
#import "AllManRedPacketListModel.h"

@implementation MainTool



//获取首页红包信息
+ (void)mainRedBagListWithParam:(NSDictionary *)param successBlock:(void (^)(NSArray *))successBlock errorBlock:(void (^)(NSError *))errorBlock
{
    [[NetworkManager new] getWithURL:MainRedBagList success:^(id obj) {

        NSDictionary *dic = obj[@"data"];
        NSArray *redBagsArray = dic[@"redBags"];
        NSArray *userRedbagArray = dic[@"userRedbag"];

        
        NSMutableArray *sellerModelArray = [NSMutableArray array];
        NSMutableArray *allManModelArray = [NSMutableArray array];
        for (NSDictionary *modelDic in redBagsArray) {
            SellerRedBagListModel *model = [[SellerRedBagListModel alloc] init];
            [model setValuesForKeysWithDictionary:modelDic];
            [sellerModelArray addObject:model];
        }
        
        for (NSDictionary *modelDic in userRedbagArray) {
            AllManRedPacketListModel *model = [[AllManRedPacketListModel alloc] init];
            [model setValuesForKeysWithDictionary:modelDic];
            [allManModelArray addObject:model];
        }
        
        NSArray *modelArray = @[sellerModelArray, allManModelArray];
        if (successBlock) {
            successBlock(modelArray);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
    
    
}

@end
