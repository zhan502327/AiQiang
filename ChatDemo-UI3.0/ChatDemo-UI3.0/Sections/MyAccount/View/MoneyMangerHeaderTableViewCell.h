//
//  MoneyMangerHeaderTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/16.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyMangerHeaderTableViewCell : UITableViewCell

@property (nonatomic, assign) int type;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) UIImageView *rightImageView;
@property (nonatomic, weak) UILabel *nameLable;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
