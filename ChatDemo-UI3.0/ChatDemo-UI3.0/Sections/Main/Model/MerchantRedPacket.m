//
//  MerchantRedPacket.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/13.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "MerchantRedPacket.h"

@implementation MerchantRedPacket

- (id)initWithDic:(NSDictionary *)dictionary {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
        if (!_imageURL) {
            _imageURL = [NSString stringWithFormat:@"%@%@", www, _img];
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.redPacketID = value;
    }
    if ([key isEqualToString:@"count_down"]) {
        self.time = [value integerValue];
    }
}

@end
