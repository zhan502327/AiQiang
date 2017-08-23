//
//  DBStoreTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/8/22.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBStoreTableViewCell : UITableViewCell

//@property (nonatomic, strong) <#ModelClass#> *model;

@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *moneyLabel;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
