//
//  MyRedBagInfoModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/13.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRedBagInfoModel : NSObject

/*
 desc = "T ";
 img =         (
 );
 num = 2;
 rid = 59;
 sex = 0;
 title = T;
 "total_amount" = "2.00";
 */

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSArray *img;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *rid;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *total_amount;


@end
