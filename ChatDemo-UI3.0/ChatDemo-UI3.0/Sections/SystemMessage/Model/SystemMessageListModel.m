//
//  SystemMessageListModel.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/19.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "SystemMessageListModel.h"

@implementation SystemMessageListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}



@end
