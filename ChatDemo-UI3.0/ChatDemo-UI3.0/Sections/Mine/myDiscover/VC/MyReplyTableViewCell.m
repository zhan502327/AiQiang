//
//  MyReplyTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyReplyTableViewCell.h"

@implementation MyReplyTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    MyReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell iconimageView];
    [cell nameLabel];
    [cell timeLabel];
    [cell contentLabel];
    [cell leftImageView];
    [cell discoverLabel];
    
    return cell;
}


#pragma mark - 懒加载视图
- (UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, 10, 50, 50);
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 25;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewclicked)];
        [imageView addGestureRecognizer:tap];
        [self.contentView addSubview:imageView];
        _iconimageView = imageView;
    }
    return _iconimageView;
}

- (void)iconImageViewclicked{
    if (_iconImageViewBlock) {
        _iconImageViewBlock();
    }
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(self.iconimageView.frame) + 5, CGRectGetMinY(self.iconimageView.frame) + 5, 250, 20);
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = DBBlackColor;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = DBMaxFont;
        [self.contentView addSubview:label];
        _nameLabel = label;
        
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = DBGrayColor;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = DBMidFont;
        label.frame = CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame) + 5, 250, 20);
        [self.contentView addSubview:label];
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, CGRectGetMaxY(self.iconimageView.frame)+ 20, SCREEN_WIDTH - 20, 100);
        label.textColor = DBBlackColor;
        label.font = DBMaxFont;
        [self.contentView addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        UIImageView *imaeView = [[UIImageView alloc] init];
        imaeView.frame = CGRectMake(10, CGRectGetMaxY(self.contentLabel.frame)+20, 80, 80);
        [self.contentView addSubview:imaeView];
        imaeView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(discoverDetailClick)];
        [imaeView addGestureRecognizer:tap];
        
        _leftImageView = imaeView;
    }
    return _leftImageView;
}

- (UILabel *)discoverLabel{
    if (_discoverLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.userInteractionEnabled = YES;
        label.backgroundColor = ColorTableViewBg;
        label.textColor = DBBlackColor;
        label.font = DBMidFont;
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(discoverDetailClick)];
        [label addGestureRecognizer:tap];
        label.frame = CGRectMake(CGRectGetMaxX(self.leftImageView.frame), CGRectGetMinY(self.leftImageView.frame), SCREEN_WIDTH - 10 - CGRectGetMaxX(self.leftImageView.frame), CGRectGetHeight(self.leftImageView.frame));
        [self.contentView addSubview:label];
        _discoverLabel = label;
    }
    return _discoverLabel;
}

- (void)discoverDetailClick{
    if (_detailBlock) {
        _detailBlock();
    }
}


#pragma mark -数据处理
- (void)setModel:(MyReplyModel *)model
{
    _model = model;
    
    [_iconimageView sd_setImageWithURL:[NSURL URLWithString:model.headimg]];
    _nameLabel.attributedText = model.nickname;
    _timeLabel.text = model.create_time;
    _contentLabel.text = model.content;
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.url]];
    _discoverLabel.text = model.circle_content;
    
    self.contentLabel.frame = CGRectMake(10, CGRectGetMaxY(self.iconimageView.frame)+ 20, SCREEN_WIDTH - 20, model.contentLabelHeight);

    self.leftImageView.frame = CGRectMake(10, CGRectGetMaxY(self.contentLabel.frame)+20, 80, 80);
    
    self.discoverLabel.frame = CGRectMake(CGRectGetMaxX(self.leftImageView.frame), CGRectGetMinY(self.leftImageView.frame), SCREEN_WIDTH - 10 - CGRectGetMaxX(self.leftImageView.frame), CGRectGetHeight(self.leftImageView.frame));
    
    
}

@end
