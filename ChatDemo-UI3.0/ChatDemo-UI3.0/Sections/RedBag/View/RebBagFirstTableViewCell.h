//
//  RebBagFirstTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/1.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RebBagFirstTableViewCell : UITableViewCell

//@property (nonatomic, strong) <#ModelClass#> *model;

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *rightLabel;
@property (nonatomic, weak) UITextField *textField;


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
