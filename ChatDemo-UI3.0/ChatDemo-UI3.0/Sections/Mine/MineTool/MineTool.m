//
//  MineTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MineTool.h"
#import "MyRecommendListModel.h"

@implementation MineTool

//获取用户信息
+ (void)userInfoWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(UserInfoModel *model))successBlock errorBlock:(void(^)(NSError *error))errorBlock{

    [[NetworkManager new] postWithURL:UesrInfoUrl parameter:param success:^(NSDictionary  *responseObject) {
        //获取JSON
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        
        NSDictionary *dic = responseObject[@"data"];
        UserInfoModel *model = [[UserInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        
        
        if (successBlock) {
            successBlock(model);
        }
    } fail:^(NSError *error){
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

+ (void)userMoneyWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(NSString *rmb, NSString *balance))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:UserMoneyURL parameter:param success:^(NSDictionary  *responseObject) {
        //获取JSON
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        
        NSDictionary *dic = responseObject[@"data"];
        
        NSString *rmb = dic[@"rmb"];//现金余额
        
        NSString *balance = dic[@"balance"];//红包余额
        
        if (successBlock) {
            successBlock(rmb, balance);
        }
    } fail:^(NSError *error){
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


//推荐的人列表
+ (void)getRecommendListWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *modelArray, NSString *msg, NSNumber *status, NSString *code))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:GetRecommendListURL parameter:param success:^(NSDictionary  *responseObject) {
        //获取JSON
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);

        NSString *code = responseObject[@"code"];
        NSString *msg = responseObject[@"msg"];
        NSNumber *status = responseObject[@"status"];
        NSMutableArray *modelArray = [NSMutableArray array];

        if ([responseObject[@"data"] isKindOfClass:[NSArray class]]) {
         
            NSArray *data = responseObject[@"data"];
            for (NSDictionary *dic in data) {
                MyRecommendListModel *model = [[MyRecommendListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [modelArray addObject:model];
            }
        }
        
        if (successBlock) {
            successBlock(modelArray,msg, status, code);
        }
    } fail:^(NSError *error){
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
    
}


@end
