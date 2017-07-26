//
//  MineFirstTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/17.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineFirstTableViewCell : UITableViewCell

@property (nonatomic, weak) UIView *redView;

@property (nonatomic, weak) UIButton *firstButton;
@property (nonatomic, weak) UIButton *secondButton;
@property (nonatomic, weak) UIButton *thirdButton;
@property (nonatomic, copy) void(^firstButtonBlock)();
@property (nonatomic, copy) void(^secondButtonBlock)();
@property (nonatomic, copy) void(^thirdButtonBlock)();



+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
