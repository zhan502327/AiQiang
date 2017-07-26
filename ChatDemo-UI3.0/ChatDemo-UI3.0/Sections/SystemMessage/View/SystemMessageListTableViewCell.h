//
//  SystemMessageListTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemMessageListModel.h"
@interface SystemMessageListTableViewCell : UITableViewCell

@property (nonatomic, strong) SystemMessageListModel *model;

@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *descLabel;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
