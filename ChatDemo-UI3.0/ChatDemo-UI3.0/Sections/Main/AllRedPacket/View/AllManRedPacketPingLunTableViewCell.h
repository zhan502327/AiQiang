//
//  AllManRedPacketPingLunTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllManRedPacketPingLunModel.h"

@interface AllManRedPacketPingLunTableViewCell : UITableViewCell


@property (nonatomic, strong) AllManRedPacketPingLunModel *model;

@property (nonatomic, weak) UIImageView *iconimageView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *commnetLabel;

@property (nonatomic, weak) UIView *lineView;

@property (nonatomic, copy) void(^iconImageViewBlock)();

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
