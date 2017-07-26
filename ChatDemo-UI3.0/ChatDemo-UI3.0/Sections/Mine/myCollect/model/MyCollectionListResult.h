//
//  MyCollectionListResult.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/10.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCollectionListResult : NSObject

@property (nonatomic, strong) NSNumber *total_page;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSNumber *status;

@end
