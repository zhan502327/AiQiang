//
//  MyCollectionListModel.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/10.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyCollectionListModel.h"

@implementation MyCollectionListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
    if ([key isEqualToString:@"description"]) {
        self.desc = value;
    }
}



@end
