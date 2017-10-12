//
//  DBExchangeListTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/9/27.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBExchangeListTableViewCell : UITableViewCell


//@property (nonatomic, strong) <#ModelClass#> *model;

@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *timeLabel;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;



@end
