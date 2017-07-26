//
//  DiscoverHuifuModek.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/26.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverHuifuModek : NSObject

/*
 "re_uid" : "23",
 "uid" : "23",
 "content" : "极为重要作用哦我也用点开听听推荐几款",
 "id" : "13",
 "nickname" : "你是谁",
 "create_time" : "1493087960",
 "re_name" : "你是谁",
 "pid" : "12"
 */

@property (nonatomic, copy) NSString *re_uid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *re_name;
@property (nonatomic, copy) NSString *pid;


@end
