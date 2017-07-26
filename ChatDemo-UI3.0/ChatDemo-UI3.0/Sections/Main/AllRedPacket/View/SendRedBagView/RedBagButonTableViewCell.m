//
//  RedBagButonTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/9.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "RedBagButonTableViewCell.h"
#define GAP 10
@implementation RedBagButonTableViewCell



+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    RedBagButonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell nameLabel];
    [cell firstButton];
    [cell secondButton];
    [cell thirdButton];
    
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
        make.width.mas_equalTo(@(80));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-GAP);
        
    }];
    
    [_thirdButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top).offset(GAP);
        make.right.equalTo(self.contentView.mas_right).offset(-GAP);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-GAP);
        make.width.mas_equalTo(@(70));
    }];
    
    [_secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top).offset(GAP);
        make.right.equalTo(self.thirdButton.mas_left).offset(-GAP);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-GAP);
        make.width.mas_equalTo(@(50));
        
    }];
    
    
    [_firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top).offset(GAP);
        make.right.equalTo(self.secondButton.mas_left).offset(-GAP);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-GAP);
        make.width.mas_equalTo(@(50));
        
    }];
    [super updateConstraints];
}

#pragma mark - 懒加载视图
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = DBBlackColor;
        label.font = DBMaxFont;
        label.text = @"可抢人：";
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UIButton *)firstButton{
    if (_firstButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = 100;
        [button setImage:[UIImage imageNamed:@"singleButton"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"singleButtonselected"] forState:UIControlStateSelected];
        [button setTitleColor:DBBlackColor forState:UIControlStateNormal];
        [button setTitle:@"男" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(singleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setImageEdgeInsets:UIEdgeInsetsMake(7, 8, 7, 26)];
        button.titleLabel.font = DBMaxFont;
        [self.contentView addSubview:button];
        _firstButton = button;
        
    }
    return _firstButton;
}

- (UIButton *)secondButton{
    if (_secondButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"singleButton"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"singleButtonselected"] forState:UIControlStateSelected];
        [button setTitleColor:DBBlackColor forState:UIControlStateNormal];
        [button setTitle:@"女" forState:UIControlStateNormal];
        button.tag = 101;
        button.titleLabel.font = DBMaxFont;
        [button setImageEdgeInsets:UIEdgeInsetsMake(7, 8, 7, 26)];

        [button addTarget:self action:@selector(singleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _secondButton = button;
    }
    return _secondButton;
}


- (UIButton *)thirdButton{
    if (_thirdButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = 102;
        [button setImage:[UIImage imageNamed:@"singleButton"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"singleButtonselected"] forState:UIControlStateSelected];
        [button setTitleColor:DBBlackColor forState:UIControlStateNormal];
        [button setTitle:@"不限" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(singleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setImageEdgeInsets:UIEdgeInsetsMake(7, 8, 7, 46)];
        button.selected = YES;
        button.titleLabel.font = DBMaxFont;

        [self.contentView addSubview:button];
        _thirdButton = button;
    }
    return _thirdButton;
}

- (void)singleButtonClicked:(UIButton *)btn{

    
    switch (btn.tag) {
        case 100:
            if (_firstBlcok) {
                _firstBlcok();
                self.firstButton.selected = YES;
                self.secondButton.selected = NO;
                self.thirdButton.selected = NO;

            }
            break;
        case 101:
            if (_secongBlock) {
                _secongBlock();
                self.firstButton.selected = NO;
                self.secondButton.selected = YES;
                self.thirdButton.selected = NO;

            }
            break;
        case 102:
            if (_thirdBlock) {
                _thirdBlock();
                self.firstButton.selected = NO;
                self.secondButton.selected = NO;
                self.thirdButton.selected = YES;

            }
            break;

        default:
            break;
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
