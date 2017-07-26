//
//  SellerRedBagListModel.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/20.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "SellerRedBagListModel.h"

@implementation SellerRedBagListModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
