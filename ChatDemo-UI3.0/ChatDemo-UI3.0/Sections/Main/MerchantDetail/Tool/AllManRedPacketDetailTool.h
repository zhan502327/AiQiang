//
//  AllManRedPacketDetailTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllManRedPacketDetailModel.h"

@interface AllManRedPacketDetailTool : NSObject

//获取全民红包的详情页
+ (void)getRedPacketDetailWithSuccessBlockWithPram:(NSDictionary *)param andRedBagType:(NSString *)redBagtype successBlock:(void(^)(AllManRedPacketDetailModel *model))successBlock errorBlock:(void(^)(NSError *error))errorBlock;



@end
