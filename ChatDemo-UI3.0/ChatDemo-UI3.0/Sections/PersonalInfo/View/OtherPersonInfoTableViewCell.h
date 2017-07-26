//
//  OtherPersonInfoTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherPersonInfoTableViewCell : UITableViewCell

//@property (nonatomic, strong) <#ModelClass#> *model;

@property (nonatomic, weak) UILabel *descLabel;
@property (nonatomic, weak) UILabel *titleLabel;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
