//
//  AllManRedPacketDetailModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllManRedPacketDetailModel : NSObject
//全民红包
/*
- id: "3",
 uid: "23",
 create_time: "1492571943",
- liked: "0",
- is_liked: "0",
 -followed: "0",
- is_followed: "0",
 ---comment: "0",----
 ---description: "<!DOCTYPE html><head><meta charset="utf-8"><meta name ="viewport" content ="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no"><style>body{word-wrap:break-word}img{width:100%;}</style></head><body><h3 style='text-align: center'>这个男的抢</h3><div>？！！！！？？high啦啦啦啦啦救济救济黄111？1好厉害啊八菱科技可口可乐了了酷兔兔---
 */

//商家红包
/*
-comment = 0;---
-description = "<!DOCTYPE html><head><meta charset=\"utf-8\"><meta name =\"viewport\" content =\"width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no\"><style>body{word-wrap:break-word}img{width:100%;}</style></head><body><img src=\"http://192.168.1.88/aq/Uploads/Editor/2017-05-19/591e5dbac490a.png\" alt=\"\" /><img src=\"http://192.168.1.88/aq/Uploads/Editor/2017-05-19/591e5dbaeb41a.png\" alt=\"\" /><img src=\"http://192.168.1.88/aq/Uploads/Editor/2017-05-19/591e5dbb14c4b.png\" alt=\"\" /><img src=\"http://192.168.1.88/aq/Uploads/Editor/2017-05-19/591e5dbb416fe.png\" alt=\"\" /><img src=\"http://192.168.1.88/aq/Uploads/Editor/2017-05-19/591e5dbb61dc9.png\" alt=\"\" /></body></html>";---
-followed = 0;
-id = 17;
img = "/Uploads/Picture/2017-05-19/591e5d7cbbd16.png";
-"is_followed" = 0;
-"is_liked" = 0;
-liked = 1;
title = "\U6d4b\U8bd5\U6d4b\U8bd51";
*/



@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *liked;
@property (nonatomic, copy) NSString *is_liked;
@property (nonatomic, copy) NSString *followed;
@property (nonatomic, copy) NSString *is_followed;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;



@end
