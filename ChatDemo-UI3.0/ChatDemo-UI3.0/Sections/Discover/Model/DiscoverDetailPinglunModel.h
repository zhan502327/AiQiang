//
//  DiscoverDetailPinglunModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/25.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverDetailPinglunModel : NSObject
/*
{
    "uid" : "23",
    "content" : "…路拖具体位置挺悠哉悠哉悠哉悠哉中央音乐学院",
    "id" : "12",
    "nickname" : "你是谁",
    "headimg" : "\/Uploads\/Headimg\/2017-04-07\/58e73b73ebbed.png",
    "create_time" : "1493087947",
    "reply" : [
               {
                   "re_uid" : "23",
                   "uid" : "23",
                   "content" : "极为重要作用哦我也用点开听听推荐几款",
                   "id" : "13",
                   "nickname" : "你是谁",
                   "create_time" : "1493087960",
                   "re_name" : "你是谁",
                   "pid" : "12"
               },
               {
                   "re_uid" : "23",
                   "uid" : "11",
                   "content" : "！！健健康康健健康康拉粑粑",
                   "id" : "14",
                   "nickname" : "海阔天空",
                   "create_time" : "1493088536",
                   "re_name" : "你是谁",
                   "pid" : "13"
               }
               ]
},
*/


@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSMutableArray *reply;

+ (instancetype)messageWithDic:(NSDictionary *)dic;
+ (void)discoverPinglunWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *array, int pageCount))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

@end
