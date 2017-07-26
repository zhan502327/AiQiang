//
//  DiscoverPingLunTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/25.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverDetailPinglunModel.h"

@interface DiscoverPingLunTableViewCell : UITableViewCell
@property (nonatomic, strong) DiscoverDetailPinglunModel *model;


@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, copy) void(^iconImageViewVBlock)();


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
