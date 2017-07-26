//
//  RedBagSecondTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/1.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedBagSecondTableViewCell : UITableViewCell


//@property (nonatomic, strong) <#ModelClass#> *model;

@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIButton *freshButton;
@property (nonatomic, copy) void(^buttonBlock)();

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
