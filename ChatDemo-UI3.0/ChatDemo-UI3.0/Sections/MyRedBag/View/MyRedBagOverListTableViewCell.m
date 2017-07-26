//
//  MyRedBagOverListTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/13.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyRedBagOverListTableViewCell.h"

@implementation MyRedBagOverListTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    MyRedBagOverListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell iconimageView];
    [cell timeLabel];
    [cell moneyLabel];

    [cell nameLabel];
    [cell sexAndAgeLabel];
    
    
    return cell;
}

#pragma mark - 懒加载视图
- (UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, 10, 50, 50);
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 25;
        [self.contentView addSubview:imageView];
        _iconimageView = imageView;
    }
    return _iconimageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(self.iconimageView.frame) + 10, CGRectGetMinY(self.iconimageView.frame) + 5, CGRectGetMinX(self.timeLabel.frame) - CGRectGetMaxX(self.iconimageView.frame), 20);
        label.textColor = DBNameLabelColor;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = DBNameLabelFont;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)sexAndAgeLabel{
    if (_sexAndAgeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame) + 5, self.nameLabel.frame.size.width, 20);
        label.font = DBMidFont;
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = DBGrayColor;
        [self.contentView addSubview:label];
        _sexAndAgeLabel = label;
    }
    return _sexAndAgeLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(SCREEN_WIDTH - 10 - 150, CGRectGetMinX(self.iconimageView.frame) + 5, 150, 20);
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = DBGrayColor;
        label.font = DBMidFont;
        [self.contentView addSubview:label];
        _timeLabel = label;
        
    }
    return _timeLabel;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMinX(self.timeLabel.frame), CGRectGetMaxY(self.timeLabel.frame) + 5, 150, 20);
        label.textAlignment = NSTextAlignmentRight;
        label.font = DBMidFont;
        label.textColor = DBGrayColor;
        [self.contentView addSubview:label];
        _moneyLabel = label;
    }
    return _moneyLabel;
}


#pragma mark -数据处理

- (void)setModel:(MyRedBagOverListModel *)model{
    _model = model;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    model.create_time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.create_time integerValue]]];
    
    self.timeLabel.text = model.create_time;
    
    [self.iconimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",www,model.headimg]]];
    
    self.nameLabel.text = model.nickname;
    NSString *sex = @"";
    if ([model.sex isEqualToString:@"1"]) {
        sex = @"男";
    }
    
    if ([model.sex isEqualToString:@"2"]) {
        sex = @"女";
    }
    
    NSString *age = [NSString stringWithFormat:@"%@",model.birthdy];
    if (age.length > 0) {
        NSString *str = [NSString stringWithFormat:@"%@岁  %@",model.birthdy,sex];
        self.sexAndAgeLabel.text = str;

    }else{
        NSString *str = [NSString stringWithFormat:@"%@",sex];
        self.sexAndAgeLabel.text = str;
    }

    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",model.amount];
    
}


@end
