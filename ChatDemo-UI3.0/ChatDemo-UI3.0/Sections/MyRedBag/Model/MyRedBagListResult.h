//
//  MyRedBagListResult.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/11.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRedBagListResult : NSObject


@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *total_page;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSMutableArray *modelArray;

@end
