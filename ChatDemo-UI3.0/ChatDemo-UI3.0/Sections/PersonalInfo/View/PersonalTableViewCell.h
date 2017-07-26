//
//  PersonalTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/19.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalTableViewCell : UITableViewCell

//@property (nonatomic, strong) <#ModelClass#> *model;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UILabel *resultLabel;




+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
