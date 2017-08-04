//
//  DBCycleModel.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/8/3.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBCycleModel.h"

@implementation DBCycleModel

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end


