//
//  AllManRedPacketPingLunTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "AllManRedPacketPingLunTableViewCell.h"
#define GAP 10

@implementation AllManRedPacketPingLunTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    AllManRedPacketPingLunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell iconimageView];
    [cell nameLabel];
    [cell timeLabel];
    [cell commnetLabel];
    
    return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    
    [_iconimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(GAP);
        make.left.equalTo(self.contentView.mas_left).offset(GAP);
        make.height.mas_equalTo(@(40));
        make.width.mas_equalTo(@(40));
        
    }];
    
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.iconimageView.mas_top);
        make.left.equalTo(self.iconimageView.mas_right).offset(GAP);
        make.height.mas_equalTo(@(20));
        make.width.mas_equalTo(@(200));
    }];
    
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.left.equalTo(self.nameLabel.mas_left);
        make.height.mas_equalTo(@(20));
        make.width.mas_equalTo(@(250));
        
    }];
    
    
    [_commnetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.iconimageView.mas_bottom).offset(GAP);
        make.left.equalTo(self.timeLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(GAP);
        make.height.mas_equalTo(@(50));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commnetLabel.mas_bottom).offset(GAP);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@(0.5));
        
        
    }];
    [super updateConstraints];
}

#pragma mark - 懒加载视图

- (UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.layer.masksToBounds = YES;
        imageview.layer.cornerRadius = 20;
        imageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewClick)];
        [imageview addGestureRecognizer:tap];
        [self.contentView addSubview:imageview];
        _iconimageView = imageview;
    }
    return _iconimageView;
}

- (void)iconImageViewClick{
    if (_iconImageViewBlock) {
        _iconImageViewBlock();
    }
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = DBNameLabelFont;
        label.textColor = DBNameLabelColor;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = DBTitleLabelFont;
        label.textColor = DBTimeLabelColor;
        [self.contentView addSubview:label];
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)commnetLabel{
    if (_commnetLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor blackColor];
        [self.contentView addSubview:label];
        _commnetLabel = label;
    }
    return _commnetLabel;
}


- (UIView *)lineView{
    if (_lineView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:view];
        _lineView = view;
    }
    return _lineView;
}
#pragma mark -数据处理

- (void)setModel:(AllManRedPacketPingLunModel *)model{
    _model = model;
    
    NSString *str = [NSString stringWithFormat:@"%@%@",www,model.headimg];
    [self.iconimageView sd_setImageWithURL:[NSURL URLWithString:str]];
    
    self.nameLabel.text = model.nickname;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    model.create_time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.create_time integerValue]]];
    
    self.timeLabel.text = model.create_time;
    
    self.commnetLabel.text = model.comment;
    
    CGRect rect = [model.comment boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} context:nil];
    
    CGFloat height = rect.size.height;
    
    [_commnetLabel mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(@(height));

    }];
    
    
}

@end
