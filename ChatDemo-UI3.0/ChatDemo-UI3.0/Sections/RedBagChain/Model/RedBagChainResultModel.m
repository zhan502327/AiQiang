//
//  RedBagChainResultModel.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/31.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "RedBagChainResultModel.h"
#import "RedBagChainResultListModel.h"

@implementation RedBagChainResultModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"self"]) {
        self.myself = value;
    }
    if ([key isEqualToString:@"list"]) {
        NSArray *array = value;
        NSMutableArray *resultArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            
            RedBagChainResultListModel *model = [[RedBagChainResultListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [resultArray addObject:model];
        }
        self.modelListArray = (NSArray *)resultArray;
        
        
    }
    
    
}


@end
