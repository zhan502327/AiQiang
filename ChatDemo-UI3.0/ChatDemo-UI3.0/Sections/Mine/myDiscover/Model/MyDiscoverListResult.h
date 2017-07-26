//
//  MyDiscoverListResult.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDiscoverListResult : NSObject
@property (nonatomic, copy) NSString *total_page;
@property (nonatomic, strong) NSArray *modelArray;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *status;

@end
