//
//  DBAddfriendsTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/21.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBAddfriendsTableViewCell.h"

@implementation DBAddfriendsTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    DBAddfriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell iconimageView];
    [cell nameLabel];
    [cell descLabel];
    
    return cell;
}


#pragma mark - 懒加载视图

- (UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, 10, 40, 40);
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 20;
        [self.contentView addSubview:imageView];
        _iconimageView = imageView;
    }
    return _iconimageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(self.iconimageView.frame) + 5, 10, 200, 20);
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)descLabel{
    if (_descLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.frame = CGRectMake(CGRectGetMaxX(self.iconimageView.frame) + 5, CGRectGetMaxY(self.nameLabel.frame), SCREEN_WIDTH - 10 - CGRectGetMaxX(self.iconimageView.frame) - 5, 20);
        [self.contentView addSubview:label];
        _descLabel = label;
    }
    return _descLabel;
}

#pragma mark -数据处理

- (void)setModel:(UserInfoModel *)model{
    _model = model;
    [self.iconimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",www, model.headimg]]];
    
    
    self.nameLabel.text = model.nickname;
    
    NSString *sex = @"";
    
    NSString *age = @"";
    
    NSString *adress = @"";
    
    if ([model.sex isEqualToString:@"1"]) {
        sex = @"男";
    }
    
    if ([model.sex isEqualToString:@"2"]) {
        sex = @"女";
    }
    
    if (!(model.age == nil)) {
        age = [NSString stringWithFormat:@"%@岁",model.age];
    }
    
    if (model.address.length > 0) {
        adress = model.address;
    }
    
    NSString *desc;
    
    if (sex.length > 0 && age.length > 0 && adress.length > 0) {
        desc = [NSString stringWithFormat:@"%@  %@  %@",sex, age, adress];
    }
    
    if (sex.length > 0 && age.length > 0 && adress.length == 0) {
        desc = [NSString stringWithFormat:@"%@  %@",sex, age];
    }
    
    if (sex.length > 0 && age.length == 0 && adress.length > 0) {
        desc = [NSString stringWithFormat:@"%@  %@",sex, adress];
    }
    
    if (sex.length > 0 && age.length == 0 && adress.length == 0) {
        desc = [NSString stringWithFormat:@"%@",sex];
    }
    
    if (sex.length == 0 && age.length > 0 && adress.length > 0) {
        desc = [NSString stringWithFormat:@"%@  %@", age, adress];
    }
    
    if (sex.length == 0 && age.length > 0 && adress.length == 0) {
        desc = [NSString stringWithFormat:@"%@",age];
    }
    
    if (sex.length == 0 && age.length == 0 && adress.length > 0) {
        desc = [NSString stringWithFormat:@"%@",adress];
    }
    
    if (sex.length == 0 && age.length == 0 && adress.length == 0) {
        desc = @"";
    }
    
    self.descLabel.text = desc;
    
    
}


@end
