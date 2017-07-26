//
//  MyCollectionListTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/10.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionListModel.h"

@interface MyCollectionListTableViewCell : UITableViewCell

@property (nonatomic, strong) MyCollectionListModel *model;

@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIImageView *rightImageView;



+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
