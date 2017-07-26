//
//  AllManRedPacketListModel.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/28.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "AllManRedPacketListModel.h"

@implementation AllManRedPacketListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}


- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"sex"]) {
        if ([value intValue] == 0) {
            self.limitText = @"全民可抢";
        }
        
        if ([value intValue] == 1) {
            self.limitText = @"男性可抢";
        }
        
        if ([value intValue] == 2) {
            self.limitText = @"女性可抢";
        }
        
        
    }
}

@end
