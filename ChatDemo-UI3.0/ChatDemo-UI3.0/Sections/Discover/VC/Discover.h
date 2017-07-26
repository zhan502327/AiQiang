//
//  Discover.h
//  ChatDemo-UI3.0
//
//  Created by 常豪野 on 2017/4/13.
//  Copyright © 2017年 常豪野. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Discover : NSObject

/*
 "content" : "Dd",
 "img" : [],
 "id" : "69",
 "nickname" : "18501017873",
 "headimg" : "\/Uploads\/Headimg\/2017-04-28\/5902f5f4c059b.png",
 "create_time" : "1493370088",
 "liked" : "0",
 "is_liked" : "0"
 comment = 2;
 uid = 25;
 
 
 */
@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *uid;
//正文
@property (nonatomic,copy)NSString *content;
@property (nonatomic, copy) NSString *discoverID;
//昵称
@property (nonatomic,copy)NSString *nickname;
//图片
@property (nonatomic,copy)NSArray *img;
//头像
@property (nonatomic,copy)NSString *headimg;
//创建时间
@property (nonatomic,copy)NSString *create_time;

@property (nonatomic, copy) NSString *liked;

@property (nonatomic, copy) NSString *is_liked;

@property (nonatomic, assign) CGFloat labelHeight;

//
+ (instancetype)messageWithDic:(NSDictionary *)dic;

//发送异步请求，获取数据，字典转模型
+ (void)messageListWithSuccessBlock:(void(^)(NSMutableArray *array))successBlock errorBlock:(void(^)(NSError *error))errorBlock;

+ (void)discoverLIstWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSMutableArray *modelArray, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock;


@end
