//
//  MyDiscoverTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyDiscoverTool.h"
#import "MyReplyModel.h"

@implementation MyDiscoverTool
//获取我的动态
+ (void)myDiscoverWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(MyDiscoverListResult *result))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:MyDiscoverListURL parameter:param success:^(NSDictionary  *responseObject) {
        //获取JSON
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        
        MyDiscoverListResult *result = [[MyDiscoverListResult alloc] init];
        result.total_page = responseObject[@"total_page"];
        result.msg = responseObject[@"msg"];
        result.status = responseObject[@"status"];
        NSArray *array=responseObject[@"data"];
        NSMutableArray *subArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            
            
            Discover *model = [Discover messageWithDic:dic];
            [subArray addObject:model];
            
        }
        
        result.modelArray = subArray;
        if (successBlock) {
            successBlock(result);
        }
    } fail:^(NSError *error){
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//与我相关
+ (void)relateMeWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *modelArray, NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    
    [[NetworkManager new] postWithURL:RelateMeURL parameter:param success:^(NSDictionary  *responseObject) {

        NSLog(@"%@",responseObject);
        
        NSString *msg = responseObject[@"msg"];
        NSNumber *status = responseObject[@"status"];
        NSArray *array = responseObject[@"data"];
        NSMutableArray *modelArray = [NSMutableArray array];
    
        
        for (NSDictionary *dic in array) {
            MyReplyModel *model = [[MyReplyModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
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


//获取圈子单个信息
+ (void)oneCircleWithParam:(NSDictionary *)param successBlock:(void(^)(Discover *model, NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:OneCircleURL parameter:param success:^(NSDictionary  *responseObject) {
    
        NSLog(@"%@",responseObject);
        
        NSString *msg = responseObject[@"msg"];
        NSNumber *status = responseObject[@"status"];
        NSArray *array = responseObject[@"data"];
        
        NSDictionary *dic = array[0];
        Discover *model = [Discover messageWithDic:dic];
        if (successBlock) {
            successBlock(model, msg, status);
        }
    } fail:^(NSError *error){
        if (errorBlock) {
            errorBlock(error);
        }
    }];

}


@end
