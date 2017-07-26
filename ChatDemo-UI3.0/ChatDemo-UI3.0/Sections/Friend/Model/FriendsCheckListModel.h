//
//  FriendsCheckListModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/6.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsCheckListModel : NSObject

/*
 "create_time" = 1494208347;
 "from_headimg" = "/Uploads/Headimg/2017-05-24/592536946fdf2.png";
 "from_nickname" = 7788;
 "from_uid" = 28;
 id = 7;
 msg = "\U6211\U662f18501017788";
 status = 1;
 "to_headimg" = "/Uploads/Headimg/2017-06-19/5947342152892.png";
 "to_nickname" = 7873;
 "to_uid" = 25;
 */


@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *from_headimg;
@property (nonatomic, copy) NSString *from_nickname;
@property (nonatomic, copy) NSString *from_uid;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *to_headimg;
@property (nonatomic, copy) NSString *to_nickname;
@property (nonatomic, copy) NSString *to_uid;

@end
