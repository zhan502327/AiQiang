//
//  NormalTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/18.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalTableViewCell : UITableViewCell

//@property (nonatomic, strong) <#ModelClass#> *model;

@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UILabel *titleLabel;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
