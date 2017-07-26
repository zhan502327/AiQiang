//
//  RedBagTextFieldTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/9.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "RedBagTextFieldTableViewCell.h"

#define GAP 10

@implementation RedBagTextFieldTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    RedBagTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell nameLabel];
    [cell textField];
    [cell rightLabel];
    
    return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.equalTo(self.contentView.mas_top).offset(GAP);
        make.left.equalTo(self.contentView.mas_left).offset(GAP);
        make.width.mas_equalTo(@(130));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-GAP);
        
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top).offset(GAP);
        make.right.equalTo(self.contentView.mas_right).offset(-GAP);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-GAP);
        make.width.mas_equalTo(@(20));
        
    }];
    
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top).offset(GAP);
        make.left.equalTo(self.nameLabel.mas_right).offset(GAP);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-GAP);
        make.right.equalTo(self.rightLabel.mas_left);
    }];
    
    [super updateConstraints];
}

#pragma mark - 懒加载视图

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = DBBlackColor;
        label.font = DBMaxFont;
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UITextField *)textField{
    if (_textField == nil) {
        UITextField *textField = [[UITextField alloc] init];
        textField.font = DBMaxFont;
        textField.textAlignment = NSTextAlignmentRight;
        textField.textColor = DBBlackColor;
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        [self.contentView addSubview:textField];
        _textField = textField;
    }
    return _textField;
}

- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = DBBlackColor;
        label.font = DBMaxFont;
        [self.contentView addSubview:label];
        _rightLabel = label;
    }
    return _rightLabel;
}

#pragma mark -数据处理


@end
