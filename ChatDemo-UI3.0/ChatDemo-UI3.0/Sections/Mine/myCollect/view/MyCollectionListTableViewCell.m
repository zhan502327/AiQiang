//
//  MyCollectionListTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/10.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyCollectionListTableViewCell.h"
#import "BaseTool.h"
#define GAP 10

@implementation MyCollectionListTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    MyCollectionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell iconimageView];
    [cell nameLabel];
    [cell timeLabel];
    [cell contentLabel];
    [cell rightImageView];
    
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
        make.width.mas_equalTo(@(40));
        make.height.mas_equalTo(@(40));
    }];
    
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.iconimageView.mas_bottom).offset(-GAP);
        make.left.equalTo(self.iconimageView.mas_right).offset(GAP);
        make.height.mas_equalTo(@(20));
        make.width.mas_equalTo(@(120));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-GAP);
        make.width.mas_equalTo(@(150));
        make.bottom.equalTo(self.nameLabel.mas_bottom);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.iconimageView.mas_bottom).offset(GAP);
        make.left.equalTo(self.nameLabel.mas_left);
        make.bottom.equalTo(self.rightImageView.mas_bottom);
        make.right.equalTo(self.rightImageView.mas_left);
    }];
    
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentLabel.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-GAP);
        make.width.mas_equalTo(@(80));
        make.height.mas_equalTo(@(80));
        
    }];
    
    [super updateConstraints];
}

#pragma mark - 懒加载视图
- (UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *view = [[UIImageView alloc] init];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 20;
        [self.contentView addSubview:view];
        _iconimageView = view;
    }
    return _iconimageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
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
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = DBGrayColor;
        label.font = DBMinFont;
        [self.contentView addSubview:label];

        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = DBContentLabelColor;
        label.font = DBContentLabelFont;
        label.numberOfLines = 3;
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [BaseTool colorFromHexRGB:@"EEB4B4"];
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        _rightImageView = imageView;
    }
    return _rightImageView;
}


#pragma mark -数据处理
- (void)setModel:(MyCollectionListModel *)model
{
    _model = model;
    
    if ([model.type isEqualToString:@"1"]) {//商家红包
        _iconimageView.image = [UIImage imageNamed:@"icon-3"];
    }else{
        _iconimageView.image = [UIImage imageNamed:@"icon-1"];
    }
    
    
    _nameLabel.text = model.title;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    model.create_time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.create_time integerValue]]];
    
    _timeLabel.text = model.create_time;
    _contentLabel.text = model.desc;
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",www,model.img]]];

}

@end
