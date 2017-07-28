//
//  FriendsListTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/8.
//  Copyright © 2017年 zhandb. All rights reserved.
//
#import "FriendsListModel.h"
#import "FriendsListTool.h"
#import "FriendsCheckListModel.h"


@implementation FriendsListTool


//根据环信id  从自己服务器上获取好友列表信息
+ (void)friendsListWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *modelArray, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:FriendsListInfoURL parameter:param success:^(id obj) {
        //获取JSON
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        
        NSArray *array=obj[@"data"];
        NSNumber *status = obj[@"status"];
        
        NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dis in array) {
            FriendsListModel *model = [[FriendsListModel alloc] init];
            [model setValuesForKeysWithDictionary:dis];
            [modelArray addObject:model];
        }
        if (successBlock) {
            successBlock(modelArray.copy, status);
        }
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}
//偷红包
+(void)stealRedbagWithParam:(NSDictionary *)param successBlock:(void (^)(NSString *, NSNumber *))successBlock errorBlock:(void (^)(NSError *))errorBlock{
    [[NetworkManager new] postWithURL:StealRedbagURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        if ([status isEqualToNumber:@1]) {
            NSDictionary *data = obj[@"data"];
            NSString *money = data[@"amount"];
            if (successBlock) {
                successBlock(money,status);
            }
        }else{
            NSString *msg = obj[@"msg"];
            if (successBlock) {
                successBlock(msg,status);
            }
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
}

//根据手机号和爱抢号查找用户信息
+ (void)searchUserInfoWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status, UserInfoModel *model))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:SearchUserInfo parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        if ([status isEqualToNumber:@1]) {
            NSDictionary *data = obj[@"data"];
            
            UserInfoModel *model = [[UserInfoModel alloc] init];
            [model setValuesForKeysWithDictionary:data];
            
            if (successBlock) {
                successBlock(msg,status,model);
            }
        }else{
            if (successBlock) {
                successBlock(msg,status,nil);
            }
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];

}

//发送好友验证
+ (void)sendFriendCheckWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:FriendSendCheck parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];

        if (successBlock) {
            successBlock(msg,status);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//查询保护期
+ (void)chectoutProtectTimeWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *start_time, NSString *end_time, NSString *else_time,NSString *msg, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:CheckProtectTimeURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        NSString *end_time = @"";
        NSString *else_time = @"";
        NSString *start_time = @"";
        
        if ([obj[@"data"] isKindOfClass:[NSDictionary class]]) {
            end_time = obj[@"data"][@"end_time"];
            else_time = obj[@"data"][@"else_time"];
            start_time = obj[@"data"][@"start_time"];
        }
        

        
        if (successBlock) {
            successBlock(start_time,end_time,else_time,msg,status);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//重置保护期
+ (void)resetProtectTimeWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successblock errorblock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:ResetProtectTimeURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        
        if (successblock) {
            successblock(msg,status);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//推荐好友
+ (void)recommendFriendWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *modelArray, NSString *msg, NSNumber *status))successBlock errorblock:(void(^)(NSError *error))errorBlock{
    
    
    [[NetworkManager new] postWithURL:RecommendFriendURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        NSArray *array = obj[@"data"];
        
        NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            UserInfoModel *model = [[UserInfoModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [modelArray addObject:model];
            
            
        }
        if (successBlock) {
            successBlock(modelArray, msg, status);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
}


//好友验证列表
+ (void)checklistWithParam:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *modelArray, NSString *msg, NSNumber *status))successBlock errorblock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:FriendsCheckListURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        NSArray *array = obj[@"data"];
        
        NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            FriendsCheckListModel *model = [[FriendsCheckListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [modelArray addObject:model];
            
            
        }
        if (successBlock) {
            successBlock(modelArray, msg, status);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//同意好友验证
+ (void)agreeFriendApplyWithParam:(NSDictionary *)param successBlock:(void(^)( NSString *msg, NSNumber *status))successBlock errorblock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:AgreeFriendApplyURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
    
        if (successBlock) {
            successBlock( msg, status);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


//删除好友验证
+ (void)deleteCheckWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))successBlock errorblock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:DeleteCheckURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        
        if (successBlock) {
            successBlock( msg, status);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

@end
