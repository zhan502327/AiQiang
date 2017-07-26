//
//  AllRedPacketTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/22.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllManRedPacketListModel.h"

@interface AllRedPacketTableViewCell : UITableViewCell

@property (nonatomic, strong) AllManRedPacketListModel *model;

@property (nonatomic, copy) void(^iconImageViewBlock)();
@property (nonatomic, copy) void(^robRedBagBlock)();
@end
