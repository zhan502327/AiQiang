//
//  SystemMessageListModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/19.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemMessageListModel : NSObject


//[1]	(null)	@"title" : @"您的红包被偷了"
//[2]	(null)	@"uid" : @"25"
//[3]	(null)	@"msg" : @"您的红包被8888偷了6.44元"
//[4]	(null)	@"create_time" : @"1496471123"
//[5]	(null)	@"ext" : @"{\"act\":\"steal\",\"uid\":\"29\"}"
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *ext;


@end
