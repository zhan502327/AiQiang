//
//  AllManRedPacketResult.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/28.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllManRedPacketResult : NSObject

@property (nonatomic, strong) NSArray *maxModelArray;
@property (nonatomic, strong) NSArray *minModelArray;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSNumber *total_page;
@end
