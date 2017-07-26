//
//  FriendsListModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/8.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsListModel : NSObject


/*
 "is_stealed" : 1,// 1--能偷   0--不能偷
 "uid" : "25",
 "nickname" : "18501017873",
 "headimg" : "\/Uploads\/Headimg\/2017-04-28\/5902f5f4c059b.png",
 "balance" : "99032.00"
 -----------------------
 "is_stealed" : 0,
 "uid" : "38",
 "nickname" : "大雨哥",
 "headimg" : "\/Uploads\/Headimg\/2017-06-03\/59324c391a736.png",
 "remark" : "dfgdfgsd"
 */
@property (nonatomic ,copy) NSNumber *is_stealed;
@property (nonatomic ,copy) NSString *uid;
@property (nonatomic ,copy) NSString *nickname;
@property (nonatomic ,copy) NSString *headimg;
@property (nonatomic ,copy) NSString *remark;


@end
