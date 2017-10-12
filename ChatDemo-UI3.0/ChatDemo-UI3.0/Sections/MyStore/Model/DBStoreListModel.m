//
//  DBStoreListModel.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/9/29.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBStoreListModel.h"

@implementation DBStoreListModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        value = self.productID;
    }
}

@end
