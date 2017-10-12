//
//  DBExchangeListTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/9/27.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBExchangeListTableViewCell.h"

@implementation DBExchangeListTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    DBExchangeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell iconimageView];
    [cell titleLabel];
    [cell timeLabel];
    
    return cell;
}


#pragma mark - 懒加载视图
- (UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, 10, 100, 60);
        imageView.image = [UIImage imageNamed:@"exchange7"];
        [self.contentView addSubview:imageView];
        _iconimageView = imageView;
    }
    return _iconimageView;
}

- (UILabel *)titleLabel{
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(self.iconimageView.frame) + 10, 15, SCREEN_HEIGHT - 10 - CGRectGetMaxX(self.iconimageView.frame) - 10, 20);
        label.font = DBMaxFont;
        label.text = @"流量兑换券";
        label.textColor = DBBlackColor;
        label.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = DBGrayColor;
        label.font = DBMidFont;
        label.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 10, CGRectGetWidth(self.titleLabel.frame), 20);
        label.text = @"有效期至： 2017-12-30";
        [self.contentView addSubview:label];
        _timeLabel = label;
    }
    return _timeLabel;
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
