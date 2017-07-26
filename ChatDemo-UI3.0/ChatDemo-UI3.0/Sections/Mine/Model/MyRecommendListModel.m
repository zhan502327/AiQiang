//
//  MyRecommendListModel.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/11.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyRecommendListModel.h"

@implementation MyRecommendListModel

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"reg_time"]) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        
        //设置时区,这个对于时间的处理有时很重要
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
        self.reg_time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[value integerValue]]];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
