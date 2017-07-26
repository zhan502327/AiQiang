//
//  MyRecommendTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/11.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRecommendListModel.h"

@interface MyRecommendTableViewCell : UITableViewCell

@property (nonatomic, strong) MyRecommendListModel *model;

@property (nonatomic, weak) UILabel *phoneLabel;
@property (nonatomic, weak) UILabel *timeLabel;
+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
