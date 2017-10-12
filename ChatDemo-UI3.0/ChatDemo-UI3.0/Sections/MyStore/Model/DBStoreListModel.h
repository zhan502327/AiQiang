//
//  DBStoreListModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/9/29.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBStoreListModel : NSObject

/*
 "total_page":1
 "data":[{"id":"1","name":"ceshi ",
 "img":"4","amount":"10","num":"1"}],
 "msg":"\u6210\u529f",
 "status":1}
 
 
 
 "id": "1",
 "name": "ceshi ",
 "img": "4",
 "amount": "10",
 "num": "1"
 
 */


@property (nonatomic, copy) NSString *productID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *num;

@end
