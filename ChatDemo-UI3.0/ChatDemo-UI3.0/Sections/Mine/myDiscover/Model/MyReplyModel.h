//
//  MyReplyModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyReplyModel : NSObject

/*
 cid = 244;
 "circle_content" = Gkjhkhkhl;
 content = asfasjfio;
 "create_time" = 1499240732;
 headimg = "/Uploads/Headimg/2017-06-19/5947342152892.png";
 nickname = 7873;
 uid = 25;
 url = "/Uploads/default.png";
 */

@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *circle_content;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSMutableAttributedString *nickname;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) CGFloat contentLabelHeight;


@end
