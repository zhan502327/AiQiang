//
//  FriendsCheckListModel.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/6.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "FriendsCheckListModel.h"

@implementation FriendsCheckListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"from_headimg"]) {
        NSString *heading = [NSString stringWithFormat:@"%@%@",www,value];
        self.from_headimg = [heading stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    if ([key isEqualToString:@"to_headimg"]) {
        NSString *heading = [NSString stringWithFormat:@"%@%@",www,value];
        self.to_headimg = [heading stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }

    

}

@end
