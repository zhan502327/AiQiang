//
//  RedBagChainResultListModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/31.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedBagChainResultListModel : NSObject

/*
 "nickname": "海阔天空",
 "headimg": "/Uploads/Headimg/2017-03-28/58da171d06f74.png",
 "amount": "0.91",
 "create_time": "1495868784",
 "max": 1
 */

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, strong) NSNumber *max;


@end
