//
//  MyRedBagListModel.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/11.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyRedBagListModel.h"

@implementation MyRedBagListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
