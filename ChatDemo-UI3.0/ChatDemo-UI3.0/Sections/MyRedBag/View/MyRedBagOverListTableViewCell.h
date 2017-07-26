//
//  MyRedBagOverListTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/13.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRedBagOverListModel.h"
@interface MyRedBagOverListTableViewCell : UITableViewCell


@property (nonatomic, strong) MyRedBagOverListModel *model;

@property (nonatomic, weak) UIImageView *iconimageView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *sexAndAgeLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *moneyLabel;


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;



@end
