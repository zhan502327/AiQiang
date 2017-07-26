//
//  SystemMessageListTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "SystemMessageListTableViewCell.h"

@implementation SystemMessageListTableViewCell
+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    SystemMessageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell iconimageView];
    [cell titleLabel];
    [cell timeLabel];
    [cell descLabel];
    return cell;
}

- (UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, 10, 20, 20);
        imageView.image = [UIImage imageNamed:@"systemMessage"];
        [self.contentView addSubview:imageView];
        _iconimageView = imageView;
    }
    return _iconimageView;
}


- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame =CGRectMake(CGRectGetMaxX(self.iconimageView.frame) + 5, 10, 180, 20);
        label.text = @"您的红包被偷了";
        label.textColor = DBBlackColor;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = DBMidFont;
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 10, SCREEN_WIDTH - 10 - CGRectGetMaxX(self.titleLabel.frame), 20);
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = DBGrayColor;
        label.font = DBMinFont;
        [self.contentView addSubview:label];
        _timeLabel = label;
    }
    
    return _timeLabel;
}

- (UILabel *)descLabel{
    if (_descLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 15, SCREEN_WIDTH - 10 - CGRectGetMinX(self.titleLabel.frame), 20);
        label.font = DBMidFont;
        label.textColor = DBBlackColor;
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _descLabel = label;
    }
    return _descLabel;
}

- (void)setModel:(SystemMessageListModel *)model{
    _model = model;
    
    self.titleLabel.text = model.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    
    model.create_time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.create_time integerValue]]];
    
    self.timeLabel.text = model.create_time;

    NSData *data = [model.ext dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSString *nickName = dic[@"nickname"];
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:model.msg];
    
    NSDictionary *attDic = @{NSForegroundColorAttributeName : [UIColor orangeColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
    [attributeStr setAttributes:attDic range:NSMakeRange(5, nickName.length)];
    
    self.descLabel.attributedText = attributeStr;
    
    
    
}

@end
