//
//  MyRedBagListTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/11.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRedBagListModel.h"

@interface MyRedBagListTableViewCell : UITableViewCell

@property (nonatomic, strong) MyRedBagListModel *model;
@property (nonatomic, weak) UIImageView *topView;
@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *timeImageView;
@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UIImageView *overImageView;
@property (nonatomic, weak) UILabel *overLabel;

@property (nonatomic, weak) UILabel *moneyLabel;

@property (nonatomic, weak) UIButton *leftButton;
@property (nonatomic, weak) UIButton *rightButton;
@property (nonatomic, copy) void(^leftButtonBlock)();
@property (nonatomic, copy) void(^rightButtonBlock)();

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
