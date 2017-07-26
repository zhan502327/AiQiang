//
//  CircleDetailViewController.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/24.
//  Copyright © 2017年 zhandb. All rights reserved.


#import <UIKit/UIKit.h>
#import "Discover.h"

@interface CircleDetailViewController : UIViewController

@property (nonatomic, strong) Discover *discoverModel;
@property (nonatomic, copy) NSString *cid;

@property (nonatomic, copy) void(^deleteDiscoverReloadDataBlock)();
@end
