//
//  MerchantDetailViewController.h
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/14.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllManRedPacketListModel.h"

@interface MerchantDetailViewController : UIViewController

@property (nonatomic, strong) NSString *redPacketID;
@property (nonatomic, strong) AllManRedPacketListModel *model;

@end
