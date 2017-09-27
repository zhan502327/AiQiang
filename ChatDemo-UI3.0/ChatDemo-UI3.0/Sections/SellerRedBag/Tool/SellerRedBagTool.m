//
//  SellerRedBagTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/23.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "SellerRedBagTool.h"
#import "SellerRedBagListModel.h"
#import "AllManRedPacketPingLunModel.h"
@implementation SellerRedBagTool

//商家红包列表
+ (void)sellerRedBagWithParam:(NSDictionary *)param successBlock:(void(^)(NSArray *modelArray))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    
    [[NetworkManager new] postWithURL:SellerRedBagListURL parameter:param success:^(id obj) {
        NSArray *dataarray = obj[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic  in dataarray) {
            SellerRedBagListModel *model = [[SellerRedBagListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        if (successBlock) {
            successBlock(array);
        }
        
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


//获取商家红包详情
+ (void)sellerRedBagDetailWithParam:(NSDictionary *)param successBlock:(void (^)(NSArray *))successBlock errorBlock:(void (^)(NSError *))errorBlock{
    [[NetworkManager new] postWithURL:SellerRedBagDetailURL parameter:param success:^(id obj) {
        if (successBlock) {
        }
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//偷取商家红包
+ (void)stealSellerRedBagWirthParam:(NSDictionary *)param successBlock:(void(^)(StealRedBagResult *result))successBlock errorBlock:(void(^)(NSError *error))errorBlock{

    [[NetworkManager new] postWithURL:StealSellerRedBagURL parameter:param success:^(id obj) {
        
        StealRedBagResult *result = [[StealRedBagResult alloc] init];
        
        NSNumber *status = obj[@"status"];
        NSString *msg = obj[@"msg"];
        result.status = status;
        result.msg = msg;

        if ([status isEqualToNumber:@1]) {
            NSString *moneyStr = obj[@"data"][@"price"];
            result.monsyStr = moneyStr;
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

//商家红包点赞
+ (void)sellerRedBagSetLikedWithParam:(NSDictionary *)param successBlock:(void (^)(NSString *))successBlcok errorBlock:(void (^)(NSError *))errorBlock{
    [[NetworkManager new] postWithURL:SellerRedBagSetLikedURL parameter:param success:^(id obj) {
        
        NSString *msg = obj[@"msg"];
        if (successBlcok) {
            successBlcok(msg);
        }
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];

}

//商家红包收藏
+ (void)sellerRedBagCollectionWithParam:(NSDictionary *)param successBlock:(void (^)(NSString *))successBlcok errorBlock:(void (^)(NSError *))errorBlock{
    
    [[NetworkManager new] postWithURL:SellerRedBagSetFollowedURL parameter:param success:^(id obj) {
        
        NSString *msg = obj[@"msg"];
        if (successBlcok) {
            successBlcok(msg);
        }
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//商家红包发表评论
+ (void)selletRedBagSendCommnetWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg,NSNumber *num))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:SellerRedBagSendCommentURL parameter:param success:^(id obj) {
        
        NSString *msg = obj[@"msg"];
        NSNumber *num = obj[@"status"];
        if (successBlock) {
            successBlock(msg,num);
        }
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

//商家红包评论列表
+ (void)sellerRedBagCommentListWithParam:(NSDictionary *)param successBlock:(void (^)(AllManRedPacketPingLunListResult *))successBlock errorBlock:(void (^)(NSError *))errorBlock{
    
    [[NetworkManager new] postWithURL:SellerRedBagCommnetListURL parameter:param success:^(id obj) {
        AllManRedPacketPingLunListResult *result = [[AllManRedPacketPingLunListResult alloc] init];
        result.msg = obj[@"msg"];
        result.total_page = obj[@"total_page"];
        result.status = obj[@"status"];
        
        NSArray *array = obj[@"data"];
        NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            AllManRedPacketPingLunModel *model = [[AllManRedPacketPingLunModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [resultArray addObject:model];
        }
        
        result.modelArray = resultArray;
        
        if (successBlock) {
            successBlock(result);
        }
    } fail:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}



@end
