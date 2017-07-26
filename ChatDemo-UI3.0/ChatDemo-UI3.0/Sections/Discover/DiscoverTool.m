//
//  DiscoverTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/27.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DiscoverTool.h"

@implementation DiscoverTool

//回复评论
+ (void)replyPinglunWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *array,NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:CircleReplyURL parameter:param success:^(NSDictionary  *responseObject) {
        //获取JSON
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        NSString *msg= responseObject[@"msg"];
        NSNumber *status = responseObject[@"status"];
        NSArray *array=responseObject[@"data"];
        
        
        if (successBlock) {
            successBlock((NSMutableArray *)array,msg,status);
        }
    } fail:^(NSError *error){
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//发表圈子
+ (void)publishDiscoverWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *array))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    
    [[NetworkManager new] postWithURL:PublishDiscoverURL parameter:param success:^(NSDictionary  *responseObject) {
        //获取JSON
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        
        NSArray *array=responseObject[@"data"];

        if (successBlock) {
            successBlock(array);
        }
    } fail:^(NSError *error){
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


//圈子点赞
+ (void)circleSetLikedWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    
    [[NetworkManager new] postWithURL:CircleSetLikedURL parameter:param success:^(NSDictionary  *responseObject) {
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

//删除个人动态
+ (void)deleteDiscoverWith:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:DeleteDiscoverURL parameter:param success:^(NSDictionary  *responseObject) {
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
