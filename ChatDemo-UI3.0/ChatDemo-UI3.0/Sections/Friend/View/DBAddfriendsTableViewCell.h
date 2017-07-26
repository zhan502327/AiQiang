//
//  DBAddfriendsTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/21.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "UserInfoModel.h"

@interface DBAddfriendsTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UserInfoModel *model;

@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *descLabel;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
