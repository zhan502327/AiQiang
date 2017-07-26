//
//  TixianListModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/16.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TixianListModel : NSObject


/*
 "id": "2",
 "uid": "11",
 "type": "1",
 "to": "rmb",
 "total_amount": "1.00",
 "status": "1",
 "create_time": "1497511698"
 */
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *to;
@property (nonatomic, copy) NSString *total_amount;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *create_time;



@end
