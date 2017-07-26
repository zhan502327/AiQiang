//
//  AllManRedPacketPingLunListResult.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllManRedPacketPingLunListResult : NSObject


@property (nonatomic, strong) NSArray *modelArray;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSNumber *total_page;

@end
