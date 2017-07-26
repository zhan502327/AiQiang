//
//  DBBillTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/17.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillModel.h"

@interface DBBillTableViewCell : UITableViewCell
@property (nonatomic, strong) BillModel *model;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *moneyLabel;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
