//
//  FriendsCheckListTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/6.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsCheckListModel.h"


@interface FriendsCheckListTableViewCell : UITableViewCell

@property (nonatomic, strong) FriendsCheckListModel *model;

@property (nonatomic, weak) UIImageView *iconimageView;

@property (nonatomic, weak) UILabel *nameLaebl;

@property (nonatomic, weak) UILabel *msgLabel;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
