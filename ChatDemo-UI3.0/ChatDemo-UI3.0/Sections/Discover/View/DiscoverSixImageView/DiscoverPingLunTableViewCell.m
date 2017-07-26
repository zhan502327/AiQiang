//
//  DiscoverPingLunTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/25.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DiscoverPingLunTableViewCell.h"

#define GAP 10

@implementation DiscoverPingLunTableViewCell



+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    DiscoverPingLunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell bgView];
    [cell iconimageView];
    [cell nameLabel];
    [cell timeLabel];
    [cell contentLabel];
    
    return cell;
}

#pragma mark - 懒加载视图

- (UIView *)bgView{
    if (_bgView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView sd_addSubviews:@[view]];
        _bgView = view;
    }
    return _bgView;
}

- (UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 15;
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewTap)];
        [imageView addGestureRecognizer:tap];
        [self.contentView addSubview:imageView];
        _iconimageView = imageView;
    }
    return _iconimageView;
}

- (void)iconImageViewTap{
    if (_iconImageViewVBlock) {
        _iconImageViewVBlock();
    }
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        
        _nameLabel = label;
        
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = DBGrayColor;
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}
#pragma mark -数据处理
- (void)setModel:(DiscoverDetailPinglunModel *)model{
    _model = model;
    NSString *imageURL = [NSString stringWithFormat:@"%@%@",www,model.headimg];
    [self.iconimageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil];
    self.nameLabel.text = model.nickname;
    
    
    //设置创建时间
    NSString *timeStr=model.create_time;
    //将时间戳转换成标准时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStr.doubleValue];
    NSLog(@"%@",date);
    //格式化时间数据
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    
    NSString *strDate=[dateFormatter stringFromDate:date];

    self.timeLabel.text = strDate;
    self.contentLabel.text = model.content;
    [self configerFrame];

    
}

- (void)configerFrame{
    
    NSArray *array = @[self.iconimageView,self.nameLabel,self.timeLabel,self.contentLabel];
    [self.contentView sd_addSubviews:array];
    self.bgView.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView);
 
    self.iconimageView.sd_layout
    .topSpaceToView(self.contentView,GAP)
    .leftSpaceToView(self.contentView,GAP)
    .widthIs(30)
    .heightIs(30);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.contentView,15)
    .leftSpaceToView(self.iconimageView,GAP)
    .widthIs(100)
    .heightIs(20);
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.contentView,15)
    .rightSpaceToView(self.contentView,GAP)
    .widthIs(150)
    .heightIs(20);
    
    self.contentLabel.sd_layout
    .topSpaceToView(self.iconimageView,GAP)
    .leftEqualToView(self.nameLabel)
    .rightSpaceToView(self.contentView,GAP)
    .autoHeightRatio(0);
    
    
    [self.bgView setupAutoWidthWithRightView:self.contentLabel rightMargin:GAP];
    
}
@end
