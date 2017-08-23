//
//  DBStoreTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/8/22.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBStoreTableViewCell.h"

@implementation DBStoreTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    DBStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell iconimageView];
    [cell nameLabel];
    [cell moneyLabel];
    
    return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    
    [_iconimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        make.left.equalTo(self.contentView.mas_right).offset(30);
        make.width.mas_equalTo(@(60));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconimageView.mas_top).offset(10);
        make.left.equalTo(self.iconimageView.mas_right).offset(30);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(@(20));
    }];
    
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.nameLabel.mas_right);
        make.height.mas_equalTo(@(20));
    }];
    
    
    [super updateConstraints];
}

#pragma mark - 懒加载视图
-(UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds=YES;
        imgView.backgroundColor = [UIColor redColor];
        imgView.layer.masksToBounds = YES;
        imgView.layer.cornerRadius = 30;
        imgView.image = [UIImage imageNamed:@"aiqianglogo"];
        [self.contentView addSubview:imgView];
        _iconimageView = imgView;
    }
    return _iconimageView;
}
-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor=[UIColor blackColor];
        titleLabel.font = DBMaxFont;
        titleLabel.text = @"优酷月度黄金会员";
        [self.contentView addSubview:titleLabel];
        _nameLabel= titleLabel;
    }
    return _nameLabel;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.font = DBMidFont;
        label.textColor = [UIColor redColor];
        label.text = @"500 积分";
        [self.contentView addSubview:label];
        _moneyLabel = label;
    }
    return _moneyLabel;
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
