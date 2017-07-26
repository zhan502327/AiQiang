//
//  MyCollectionListModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/10.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCollectionListModel : NSObject
/*
 id: "13",
 rid: "14",
 create_time: "1492997512",
 type: "1",
 title: "测试6",
 description: "111111111111111",
 img: "/Uploads/Picture/2017-03-27/58d882cd16a5e.jpg"
 */

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *rid;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *img;


@end
