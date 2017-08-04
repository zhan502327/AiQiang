//
//  MyAccountTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/16.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyAccountTool.h"
#import "TixianListModel.h"

@implementation MyAccountTool

//设置支付密码
+ (void)setupPasswordWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg ,NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    
    [[NetworkManager new] postWithURL:SetPayPasswordURL parameter:param success:^(id obj) {
        
        NSString *msg = obj[@"msg"];
        NSNumber *status = obj[@"status"];
        if (successBlock) {
            successBlock(msg,status);
        }
    
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


//支付宝充值
+ (void)aliPayChongzhiWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSString *data, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:AliPayCHongZhiURL parameter:param success:^(id obj) {
        NSLog( @"%@",obj);
        NSString *str = obj[@"data"];
        NSNumber *number = obj[@"status"];
        NSString *msg = obj[@"msg"];
        if (successBlock) {
            successBlock(msg, str, number);
        }
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


//提现记录
+ (void)tixianListWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSMutableArray *modelArray, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:TiXianListURL parameter:param success:^(id obj) {
        NSLog( @"%@",obj);
        NSArray *array = obj[@"data"];
        NSNumber *number = obj[@"status"];
        NSString *msg = obj[@"msg"];
        NSString *page = obj[@"total_page"];
        NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            TixianListModel *model = [[TixianListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [modelArray addObject:model];
        }
        
        
        if (successBlock) {
            successBlock(msg, modelArray, number);
        }
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


//现金余额 提现
+ (void)rmbWithDrawWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    
    [[NetworkManager new] postWithURL:RMBWithDrawURL parameter:param success:^(id obj) {
        
        NSString *msg = obj[@"msg"];
        if (successBlock) {
            successBlock(msg);
        }
        
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//红包余额 提现到 现金余额
+ (void)redBagTixainToRMBWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:RedbagToRmbURL parameter:param success:^(id obj) {
        
        NSString *msg = obj[@"msg"];
        if (successBlock) {
            successBlock(msg);
        }
        
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
}


@end
