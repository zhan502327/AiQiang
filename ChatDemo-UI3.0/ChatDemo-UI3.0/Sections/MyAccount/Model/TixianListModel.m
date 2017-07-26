//
//  TixianListModel.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/16.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "TixianListModel.h"

@implementation TixianListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
