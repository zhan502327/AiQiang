//
//  TiXianListTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/16.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TixianListModel.h"

@interface TiXianListTableViewCell : UITableViewCell

@property (nonatomic, strong) TixianListModel *model;

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *moneyLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *statusLabel;


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
