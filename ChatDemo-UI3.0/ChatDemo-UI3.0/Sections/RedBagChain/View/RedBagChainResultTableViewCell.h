//
//  RedBagChainResultTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/31.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedBagChainResultListModel.h"

@interface RedBagChainResultTableViewCell : UITableViewCell

@property (nonatomic, strong) RedBagChainResultListModel *model;

@property (nonatomic, weak) UIImageView *iconimageView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *moneyLabel;

@property (nonatomic, weak) UILabel *goodLabel;


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
