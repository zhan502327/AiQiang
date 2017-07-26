//
//  MyCollectionTool.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/10.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCollectionListResult.h"

@interface MyCollectionTool : NSObject


//获取我的收藏列表
+ (void)mycollectionListWithParam:(NSDictionary *)param successBlock:(void(^)(MyCollectionListResult *))successBlock errorBlock:(void(^)(NSError *))erroeBlcok;
@end
