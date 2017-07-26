//
//  PublishChatRedBagViewController.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/1.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishChatRedBagViewController : UIViewController

@property (nonatomic, copy) NSString *redbagType;
@property (nonatomic, copy) void(^sendGroupChatRedBagBlock)(NSString *rid, NSString *redBagtype);

@end
