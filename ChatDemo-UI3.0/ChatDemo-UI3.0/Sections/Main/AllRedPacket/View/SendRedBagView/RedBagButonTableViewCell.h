//
//  RedBagButonTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/9.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedBagButonTableViewCell : UITableViewCell


@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIButton *firstButton;
@property (nonatomic, weak) UIButton *secondButton;
@property (nonatomic, weak) UIButton *thirdButton;

@property (nonatomic,copy) void(^firstBlcok)();
@property (nonatomic,copy) void(^secongBlock)();
@property (nonatomic,copy) void(^thirdBlock)();


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
