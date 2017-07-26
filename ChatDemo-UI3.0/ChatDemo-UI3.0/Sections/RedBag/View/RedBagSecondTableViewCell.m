//
//  RedBagSecondTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/1.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "RedBagSecondTableViewCell.h"

@implementation RedBagSecondTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    RedBagSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell textField];
    [cell freshButton];
    
    return cell;
}


#pragma mark - 懒加载视图
- (UITextField *)textField{
    if (_textField == nil) {
        UITextField *textfield = [[UITextField alloc] init];
        textfield.backgroundColor = [UIColor whiteColor];
        textfield.textAlignment = NSTextAlignmentLeft;
        textfield.textColor = [UIColor blackColor];
        textfield.frame = CGRectMake(10, 10, SCREEN_WIDTH - 50, 30);
        textfield.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:textfield];
        _textField = textfield;
    }
    return _textField;
}

- (UIButton *)freshButton{
    if (_freshButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor whiteColor];
        button.frame =CGRectMake(CGRectGetMaxX(self.textField.frame), 10, 30, 30);
        [button addTarget:self action:@selector(buttonclicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _freshButton = button;
        
    }
    return _freshButton;
}

- (void)buttonclicked{
    if (_buttonBlock) {
        _buttonBlock();
    }
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
