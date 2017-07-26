//
//  RebBagFirstTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/1.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "RebBagFirstTableViewCell.h"

@implementation RebBagFirstTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    RebBagFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell nameLabel];
    [cell rightLabel];
    [cell textField];

    return cell;
}


#pragma mark - 懒加载视图
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.frame = CGRectMake(10, 10, 100, 30);
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(SCREEN_WIDTH - 10 - 30, 10, 30, 30);
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [self.contentView addSubview:label];
        _rightLabel = label;
    }
    return _rightLabel;
}

- (UITextField *)textField{
    if (_textField == nil) {
        UITextField *textField  = [[UITextField alloc] init];
        textField.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame), 10, CGRectGetMinX(self.rightLabel.frame) - CGRectGetMaxX(self.nameLabel.frame), 30);
        textField.backgroundColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentRight;
        textField.font = [UIFont systemFontOfSize:14];
        textField.textColor = [UIColor blackColor];
        textField.keyboardType =UIKeyboardTypeNumberPad;
        [self.contentView addSubview:textField];
        _textField = textField;
    }
    return _textField;
}




#pragma mark -数据处理
//- (void)setModel:(<#ModelClass#> *)model
//{
//    _model = model;
//    
//    [_imgView ideago_setImageWithURL:model.img placeholderImage:[UIImage imageNamed:@"placeholder1"]];
//    _titleLabel.text = model.title;
//    
//}
@end
