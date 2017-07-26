//
//  UserInfoModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
/*
 "address" : "上海普陀",
 "uid" : "28",
 "location" : "河南省郑州市",
 "nickname" : "18501017788",
 "birthdy" : "2017-05-10",
 "age" : 0,
 "headimg" : "\/Uploads\/Headimg\/2017-05-24\/592527fe609c0.png",
 "sex" : "1",
 "aq_id" : "21468773"
 
 "uid": "21",
 "aq_id": "21468766",
 "nickname": "15538108253",
 "headimg": "/Uploads/headimg.png",
 "sex": "0",
 "birthdy": "",
 "address": "",
 "location": ""

 "address" : "河南省郑州市",
 "uid" : "38",
 "location" : "河南省郑州市",
 "nickname" : "大雨哥",
 "birthdy" : "1992-02-04",
 "remark" : null,
 "age" : 25,
 "headimg" : "\/Uploads\/Headimg\/2017-06-03\/59324c391a736.png",
 "sex" : "1",
 "aq_id" : "21468783"
 
*/

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *birthdy;

@property (nonatomic, strong) NSNumber *age;

@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *aq_id;
@property (nonatomic, copy) NSString *remark;

@end
