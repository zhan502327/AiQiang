//
//  RedBagChainTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/24.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "RedBagChainTool.h"


@implementation RedBagChainTool

//验证支付密码
+ (void)checkPayPasswordWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:CheckPayPasswordURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        if (sucessBlcok) {
            sucessBlcok(msg,status);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
    
    
}

//进群交押金
+ (void)redBagChainPaymentDepositWithParam:(NSDictionary *)param successBlock:(void (^)(NSString *, NSNumber *))sucessBlcok errorBlock:(void (^)(NSError *))errorBlock{
    
    [[NetworkManager new] postWithURL:RedBagChainPaymentDeposit parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        if (sucessBlcok) {
            sucessBlcok(msg,status);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//发接龙红包
+ (void)publishRedBagChainRedbagWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status, NSString *rid))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:PublishChainRedbagURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        NSString *rid = @"";
        if ([status intValue] == 1) {
             rid = obj[@"data"][@"rid"];

        }
        if (sucessBlcok) {
            sucessBlcok(msg,status,rid);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
}

//抢接龙红包
+ (void)doChainRedBagWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status , NSString *price))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:DoChainRedBagURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        NSString *price = @"";
        if ([status intValue] == 1) {
            price = obj[@"data"][@"price"];
        }
        if (sucessBlcok) {
            sucessBlcok(msg,status,price);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

//发群聊红包
+ (void)publishGroupChatRedbagWithWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status, NSString *rid))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:PublishGroupChatRedBag parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        NSString *rid = @"";
        if ([status intValue] == 1) {
            rid = obj[@"data"][@"rid"];
            
        }
        if (sucessBlcok) {
            sucessBlcok(msg,status,rid);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

//抢群聊红包
+ (void)doGroupChatRedbagWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status , NSString *price))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock{
    
    [[NetworkManager new] postWithURL:DoGroupChatURL parameter:param success:^(id obj) {
    NSNumber *status = obj[@"status"];
    NSString *msg = obj[@"msg"];
    NSString *price = @"";
    if ([status intValue] == 1) {
        price = obj[@"data"][@"price"];
    }
    if (sucessBlcok) {
        sucessBlcok(msg,status,price);
    }
    
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//红包记录
+ (void)redBagLogWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status, RedBagChainResultModel *model))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:RedBagGetlogURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        NSDictionary *dic = obj[@"data"];
        RedBagChainResultModel *model = [[RedBagChainResultModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        
        
        if (sucessBlcok) {
            sucessBlcok(msg,status,model);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
}


//抢红包最大的ID
+ (void)checkoutRedBagMaxIDWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status, NSString *uid))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:CheckoutRedBagMaxID parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        NSString *uid=@"";
        if ([status intValue] == 1) {
            uid = obj[@"data"][@"uid"];
        }
        if (sucessBlcok) {
            sucessBlcok(msg,status,uid);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


//退还押金
+ (void)returnDepositWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSNumber *status))sucessBlcok errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:ReturnDepositURL parameter:param success:^(id obj) {
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        if (sucessBlcok) {
            sucessBlcok(msg,status);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}







@end
