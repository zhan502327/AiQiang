//
//  AllManRedPacketDetailTool.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "AllManRedPacketDetailTool.h"
#import "SellerRedBagDetailModel.h"

@implementation AllManRedPacketDetailTool


+ (void)getRedPacketDetailWithSuccessBlockWithPram:(NSDictionary *)param andRedBagType:(NSString *)redBagtype successBlock:(void(^)(AllManRedPacketDetailModel *model))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    NSString *urlStr = @"";
    if ([redBagtype isEqualToString:Seller_RedBagType]) {//商家红包
        urlStr = SellerRedBagDetailURL;
    }else{
        urlStr = AllManRedPacketDetailURL;
        
    }
    [[NetworkManager new] postWithURL:urlStr parameter:param success:^(id obj) {
    
        NSDictionary *dataDic = obj[@"data"];
        
        AllManRedPacketDetailModel *model = [[AllManRedPacketDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:dataDic];
        if (successBlock) {
        
            successBlock(model);
        }
        
    } fail:^(NSError *error) {
        
        
        
        
    }];

    
    
}
@end
