//
//  MyReplyTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyReplyModel.h"

@interface MyReplyTableViewCell : UITableViewCell

@property (nonatomic, strong) MyReplyModel *model;

@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIImageView *leftImageView;
@property (nonatomic, weak) UILabel *discoverLabel;

@property (nonatomic, copy) void(^detailBlock)();

@property (nonatomic, copy) void(^iconImageViewBlock)();

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
