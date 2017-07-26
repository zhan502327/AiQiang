//
//  AllManRedPacketListModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/28.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllManRedPacketListModel : NSObject
/*
 headimg = "/Uploads/Headimg/2017-04-07/58e73b73ebbed.png";
 id = 20;
 nickname = "\U4f60\U662f\U8c01";
 num = 10;
 "over_num" = 0;
 "total_amount" = "100.00";
 */



@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *over_num;
@property (nonatomic, copy) NSString *total_amount;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *limitText;

@end
