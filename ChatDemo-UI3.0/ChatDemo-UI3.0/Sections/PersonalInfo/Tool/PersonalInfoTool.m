//
//  PersonalInfoTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/19.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "PersonalInfoTool.h"

@implementation PersonalInfoTool


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

+ (void)configUserInfoWithParam:(NSDictionary *)param successBlock:(void (^)(NSString *))successBlock errorBlock:(void (^)(NSError *))errorBlock{
    
    [[NetworkManager new] postWithURL:ConfigUserInfoURL parameter:param success:^(NSDictionary  *responseObject) {
        //获取JSON
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        

        NSString *msg = responseObject[@"msg"];
        
        
        if (successBlock) {
            successBlock(msg);
        }
    } fail:^(NSError *error){
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
    
}

//设置好友备注
+ (void)setRemarkWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg , NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:SetRemarkURL parameter:param success:^(NSDictionary  *responseObject) {
        //获取JSON
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        
        
        NSString *msg = responseObject[@"msg"];
        NSNumber *status = responseObject[@"status"];
        
        if (successBlock) {
            successBlock(msg,status);
        }
    } fail:^(NSError *error){
        if (errorBlock) {
            errorBlock(error);
        }
    }];

}










@end
