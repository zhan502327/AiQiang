//
//  BillModel.h
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/27.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillModel : NSObject


@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *before;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *billID;
@property (nonatomic, copy) NSString *log;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *which;
@property (nonatomic, strong) NSNumber *amount_after;

@end
