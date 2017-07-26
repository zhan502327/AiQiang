//
//  MyReplyModel.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyReplyModel.h"

@implementation MyReplyModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
  
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"content"]) {
        
        CGRect rect = [value boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :DBMaxFont} context:nil];
        
        CGFloat height = rect.size.height;
        self.contentLabelHeight = height;
    }
    
    if ([key isEqualToString:@"create_time"]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        
        //设置时区,这个对于时间的处理有时很重要
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
        self.create_time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[value integerValue]]];
        
    }
    
    if ([key isEqualToString:@"headimg"]) {
        NSString *heading = [[NSString stringWithFormat:@"%@%@",www,value] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        self.headimg = heading;
    }
    
    if ([key isEqualToString:@"nickname"]) {
        
        NSString *text = [NSString stringWithFormat:@"%@  提到我：",value];
        

        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
        
        [str addAttributes:@{NSForegroundColorAttributeName : DBGrayColor} range:NSMakeRange(text.length - 4, 4)];
        
        self.nickname = str;
        
    }
    
    if ([key isEqualToString:@"url"]) {
        
        NSString *heading = [[NSString stringWithFormat:@"%@%@",www,value] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        self.url = heading;
    }

    
    
}

@end
