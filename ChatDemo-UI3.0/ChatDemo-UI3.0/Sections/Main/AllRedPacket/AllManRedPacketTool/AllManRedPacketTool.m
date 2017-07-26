//
//  AllManRedPacketTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/28.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "AllManRedPacketTool.h"
#import "AllManRedPacketListModel.h"
#import "AllManRedPacketPingLunModel.h"
#import "AllManRedPacketPingLunListResult.h"


@implementation AllManRedPacketTool

//获取全民红包的列表页
+ (void)getAllManRedPacketListWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *maxarray,NSMutableArray *minArray,AllManRedPacketResult *result))successBlock errorBlock:(void(^)(NSError *error))errorBlock{

    [[NetworkManager new] postWithURL:AllManRedPacketListURL parameter:param success:^(id obj) {
        
        AllManRedPacketResult *result = [[AllManRedPacketResult alloc] init];
        result.total_page = obj[@"total_page"];
        result.msg = obj[@"msg"];
        result.status = obj[@"status"];
        
        if ([obj[@"data"] isKindOfClass:[NSDictionary class]]) {
            NSArray *maxDataArray = obj[@"data"][@"max"];
            NSArray *minDataArray = obj[@"data"][@"data"];
            NSMutableArray *maxModelarray = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray *minModelArray = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *dic in maxDataArray) {
                AllManRedPacketListModel *model = [[AllManRedPacketListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [maxModelarray addObject:model];
            }
            
            for (NSDictionary *dic in minDataArray) {
                AllManRedPacketListModel *model = [[AllManRedPacketListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [minModelArray addObject:model];
            }
            
            result.maxModelArray = maxModelarray;
            result.minModelArray = minModelArray;
            if (successBlock) {
                successBlock(result.maxModelArray.mutableCopy, result.minModelArray.mutableCopy,result);
            }
        }else{
            NSArray *array = obj[@"data"];
            NSMutableArray *minModelArray = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *dic in array) {
                AllManRedPacketListModel *model = [[AllManRedPacketListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [minModelArray addObject:model];
            }
            result.minModelArray = minModelArray;
            if (successBlock) {
                successBlock(result.maxModelArray.mutableCopy, result.minModelArray.mutableCopy,result);
            }
            
        }
        
    } fail:^(NSError *error) {
        
        
        
        
    }];
}

//获取红包评论列表
+ (void)getAllManRedPacketPinglunListWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void (^)(AllManRedPacketPingLunListResult *))successBlock errorBlock:(void (^)(NSError *))errorBlock{
    [[NetworkManager new] postWithURL:AllManRedPacketPinglunListURL parameter:param success:^(id obj) {
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

//红包点赞
+ (void)redBagClickZanWithParam:(NSDictionary *)param andRedBagType:(NSString *)redBagType successBlock:(void(^)(NSString *msg))successBlock errorBlock:(void(^)(NSError *erreo))errorBlock{
    NSString *urlStr;
    if ([redBagType isEqualToString:AllMan_RedBagType]) {
        urlStr = AllManRedPacketDianZanURL;
    }else{
        urlStr = SellerRedBagSetLikedURL;
    }

    [[NetworkManager new] postWithURL:urlStr parameter:param success:^(id obj) {
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


//红包收藏
+ (void)collectionRedBagWithParam:(NSDictionary *)param andRedBagType:(NSString *)redBagType successBlock:(void(^)(NSString *msg))successBlcok errorBlock:(void(^)(NSError *error))errorBlock{

    NSString *urlStr;
    if ([redBagType isEqualToString:AllMan_RedBagType]) {
        urlStr = AllManRedPacketShoucangURL;
    }else{
        urlStr = SellerRedBagSetFollowedURL;
    }
    [[NetworkManager new] postWithURL:urlStr parameter:param success:^(id obj) {
        
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

//发布红包
+ (void)publishRedBagWithParam:(NSDictionary *)param successBlock:(void (^)(NSString *))successBlock errorBlock:(void (^)(NSError *))errorBlock{
    
    [[NetworkManager new] postWithURL:AllManRedBagPublishRedBagURL parameter:param success:^(id obj) {
        
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

//更改用户性别
+ (void)configSexWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg,NSNumber *num))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:ConfigUserSexURL parameter:param success:^(id obj) {
        
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

//偷全民红包
+ (void)stealAllManRedBagWithParam:(NSDictionary *)param successBlock:(void(^)(StealRedBagResult *result))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    
    [[NetworkManager new] postWithURL:StealAllManRedBagURL parameter:param success:^(id obj) {
        
        NSString *msg = obj[@"msg"];
        NSNumber *status = obj[@"status"];
        StealRedBagResult *result = [[StealRedBagResult alloc] init];
        result.msg = msg;
        result.status = status;
        if ([status intValue] == 1) {
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

//全民红包发表评论
+ (void)allManRedBagSendCommentWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg,NSNumber *num))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    [[NetworkManager new] postWithURL:AllManRedBagSendComment parameter:param success:^(id obj) {
        
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




@end
