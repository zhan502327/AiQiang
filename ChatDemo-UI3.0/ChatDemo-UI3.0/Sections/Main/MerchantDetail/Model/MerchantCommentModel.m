//
//  MerchantCommentModel.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/25.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "MerchantCommentModel.h"

@implementation MerchantCommentModel

- (id)initWithDic:(NSDictionary *)dictionary {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
        if (_headimg) {
            _headimg = [NSString stringWithFormat:@"%@%@", www, _headimg];
        }
        if (_create_time) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
            
            //设置时区,这个对于时间的处理有时很重要
            [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
            _create_time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[_create_time integerValue]]];
        }
       
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


@end
