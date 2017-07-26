//
//  TiXianListTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/16.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "TiXianListTableViewCell.h"

@implementation TiXianListTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    TiXianListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell timeLabel];
    [cell moneyLabel];
    [cell timeLabel];
    [cell statusLabel];
    
    return cell;
}

#pragma mark - 懒加载视图
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 10, 200, 20);
        label.textColor = DBBlackColor;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = DBMaxFont;
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 10, SCREEN_WIDTH - CGRectGetMaxX(self.titleLabel.frame) - 10, 20);
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        _moneyLabel = label;
    }
    return _moneyLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame) + 5, 200, 20);
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)statusLabel{
    if (_statusLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame), CGRectGetMaxY(self.moneyLabel.frame) + 5, SCREEN_WIDTH - 10 - CGRectGetMaxX(self.timeLabel.frame), 20);
        label.textColor = [UIColor orangeColor];
        
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        _statusLabel = label;
    }
    return _statusLabel;
}

#pragma mark -数据处理
- (void)setModel:(TixianListModel *)model{
    _model = model;
    
    if ([model.type isEqualToString:@"1"]) {//提现到现金余额
        self.titleLabel.text = @"提现到现金余额";
    }
    
    if ([model.type isEqualToString:@"2"]) {//提现到支付宝
        self.titleLabel.text = @"提现到支付宝";
    }
    
    if ([model.type isEqualToString:@"3"]) {//提现到微信
        self.titleLabel.text = @"提现到微信";
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    model.create_time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.create_time integerValue]]];

    self.timeLabel.text = model.create_time;
    
    self.moneyLabel.text = self.model.total_amount;
    
    if ([model.status intValue] == 1) {
        self.statusLabel.text = @"已到账";
    }
    
    if ([model.status intValue] == 0) {
        self.statusLabel.text = @"未到账";
    
    }
}

@end
