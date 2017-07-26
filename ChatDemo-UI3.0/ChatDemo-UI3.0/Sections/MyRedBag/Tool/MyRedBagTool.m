//
//  MyRedBagTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/11.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyRedBagTool.h"
#import "MyRedBagListModel.h"
#import "MyRedBagOverListModel.h"

@implementation MyRedBagTool

//获取我的红包列表
+ (void)myRedBagListWithParam:(NSDictionary *)param successBlock:(void (^)(MyRedBagListResult *))successBlock errorBlock:(void (^)(NSError *))errorBlock{
    
    [[NetworkManager new] postWithURL:MyRedBagListURL parameter:param success:^(id obj) {
        MyRedBagListResult *result = [[MyRedBagListResult alloc] init];
        result.status = obj[@"status"];
        if ([result.status isEqualToNumber:@1]) {
            result.msg = obj[@"msg"];
            result.total_page = obj[@"total_page"];
            NSArray *array = obj[@"data"];
            NSMutableArray *resultArray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                MyRedBagListModel *model = [[MyRedBagListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [resultArray addObject:model];
            }
            result.modelArray = resultArray;
        }else{
            result.msg = obj[@"msg"];
        }
        
        if (successBlock) {
            successBlock(result);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//获取我的红包被抢列表
+ (void)myRedBagOverListWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *modelArray, NSString *msg, NSNumber *status))successblock errorBlock:(void(^)(NSError *))errorBlock{
    
    [[NetworkManager new] postWithURL:MyRedBagOverListURL parameter:param success:^(id obj) {
        NSLog(@"%@",obj);
        NSArray *array = obj[@"data"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            MyRedBagOverListModel *model = [[MyRedBagOverListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [modelArray addObject:model];
        }
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        if (successblock) {
            successblock(modelArray, msg, status);
        }
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//获取红包信息
+ (void)getAllManRedBagInfoWithParam:(NSDictionary *)param successBlock:(void(^)(MyRedBagInfoModel *model, NSString *msg, NSNumber *status))successblock errorBlock:(void(^)(NSError *))errorBlock{
    
    
    [[NetworkManager new] postWithURL:GetAllManRedBagInfoURL parameter:param success:^(id obj) {
        NSLog(@"%@",obj);
        
        NSString *msg = obj[@"msg"];
        NSNumber *status = obj[@"status"];
        NSDictionary *dic = obj[@"data"];
        
        MyRedBagInfoModel *model = [[MyRedBagInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
    
        NSMutableArray *imageUrlArray = [NSMutableArray array];
        
        for (NSDictionary *dic in model.img) {
            NSString *imageUrl = dic[@"url"];
            [imageUrlArray addObject:imageUrl];
        }
        
        model.img = (NSArray *)imageUrlArray;
        
        if (successblock) {
            successblock(model, msg, status);
        }
    
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//重发全民红包
+ (void)resendAllManRedBagWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successblock errorBlock:(void(^)(NSError *error))errorBlock{
    
    [[NetworkManager new] postWithURL:ReSendAllManRedbagERL parameter:param success:^(id obj) {
        NSLog(@"%@",obj);
        
        NSString *msg = obj[@"msg"];
        NSNumber *status = obj[@"status"];
        
        if (successblock) {
            successblock(msg,status);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
}

@end
