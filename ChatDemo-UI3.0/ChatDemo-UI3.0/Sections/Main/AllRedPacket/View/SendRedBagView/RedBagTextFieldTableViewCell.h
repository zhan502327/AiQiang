//
//  RedBagTextFieldTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/9.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedBagTextFieldTableViewCell : UITableViewCell

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UILabel *rightLabel;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
