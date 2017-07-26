//
//  MineSecondTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/17.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineSecondTableViewCell : UITableViewCell

@property (nonatomic, weak) UIView *redView;
@property (nonatomic, weak) UIImageView *rightImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *resultLable;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
