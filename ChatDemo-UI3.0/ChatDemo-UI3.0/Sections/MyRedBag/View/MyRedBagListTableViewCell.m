//
//  MyRedBagListTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/11.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyRedBagListTableViewCell.h"
#import "BaseTool.h"

#define GAP 10

@implementation MyRedBagListTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    MyRedBagListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=ColorTableViewBg;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell topView];
    [cell iconimageView];
    [cell nameLabel];
    [cell timeImageView];
    [cell timeLabel];
    [cell overImageView];
    [cell overLabel];
    [cell moneyLabel];
    [cell leftButton];
    [cell rightButton];
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    UIColor *originColor = _topView.backgroundColor;
    
    [super setSelected:selected animated:animated];
    
    _topView.backgroundColor = originColor;
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    UIColor *originColor = _topView.backgroundColor;
    
    [super setHighlighted:highlighted animated:animated];
    
    _topView.backgroundColor = originColor;
    
}


- (UIImageView *)topView{
    if (_topView == nil) {
        UIImageView *view = [[UIImageView alloc] init];
        view.frame = CGRectMake(GAP, GAP, SCREEN_WIDTH - 2*GAP, 90);
        view.image = [UIImage imageNamed:@"myRedBagTopBgView"];
        view.userInteractionEnabled = YES;
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5,5)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = view.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        view.layer.mask = maskLayer;
        [self.contentView addSubview:view];
        _topView = view;

    }
    return _topView;
}


//- (UIView *)bottomView{
//    if (_bottomView == nil) {
//        UIView *view = [[UIView alloc] init];
//        view.frame = CGRectMake(GAP, CGRectGetMaxY(self.topView.frame), SCREEN_WIDTH - 2*GAP, 40);
//        view.backgroundColor = [UIColor redColor];
//        view.userInteractionEnabled = YES;
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5,5)];
//        
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        
//        maskLayer.frame = view.bounds;
//        
//        maskLayer.path = maskPath.CGPath;
//        
//        view.layer.mask = maskLayer;
//        [self.contentView addSubview:view];
//        _bottomView = view;
//        
//    }
//    return _bottomView;
//}

- (UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(GAP, GAP, 20, 20);
        imageView.image = [UIImage imageNamed:@"redbagTitle"];
        [self.topView addSubview:imageView];
        _iconimageView = imageView;
    }
    return _iconimageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(self.iconimageView.frame) + GAP, GAP, CGRectGetMaxX(self.topView.frame) - CGRectGetMaxX(self.iconimageView.frame), 20);
        label.textColor = [UIColor whiteColor];
        label.font = DBNameLabelFont;
        label.textAlignment = NSTextAlignmentLeft;
        [self.topView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UIImageView *)timeImageView{
    if (_timeImageView == nil) {
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.frame = CGRectMake(CGRectGetMaxX(self.iconimageView.frame), CGRectGetMaxY(self.nameLabel.frame) + GAP, 15, 15);
        imageview.image = [UIImage imageNamed:@"time"];
        [self.topView addSubview:imageview];
        _timeImageView = imageview;
    }
    return _timeImageView;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(self.timeImageView.frame) + 5, CGRectGetMinY(self.timeImageView.frame), 150, self.timeImageView.frame.size.height);
        label.font = DBMidFont;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self.topView addSubview:label];
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UIImageView *)overImageView{
    if (_overImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(CGRectGetMinX(self.timeImageView.frame), CGRectGetMaxY(self.timeImageView.frame) + GAP, 15, 15);
        imageView.image = [UIImage imageNamed:@"overRedbag"];
        [self.topView addSubview:imageView];
        _overImageView = imageView;
    }
    return _overImageView;
}

- (UILabel *)overLabel{
    if (_overLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(self.overImageView.frame) + 5, CGRectGetMinY(self.overImageView.frame), 130, self.overImageView.frame.size.height);
        label.font = DBMinFont;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self.topView addSubview:label];
        _overLabel = label;
    }
    return _overLabel;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame), CGRectGetMinY(self.timeImageView.frame), CGRectGetMaxX(self.topView.frame) - GAP - CGRectGetMaxX(self.timeLabel.frame), CGRectGetMaxY(self.overImageView.frame) - CGRectGetMinY(self.timeImageView.frame));
        label.textAlignment = NSTextAlignmentRight;
        [self.topView addSubview:label];
        _moneyLabel = label;
    }
    return _moneyLabel;
}

- (UIButton *)leftButton{
    if (_leftButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(CGRectGetMinX(self.topView.frame), CGRectGetMaxY(self.topView.frame), (self.topView.frame.size.width - 1)/2, 40);
        [button setTitle:@"已抢列表" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerBottomLeft  cornerRadii:CGSizeMake(5,5)];
        button.titleLabel.font = DBMidFont;
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = button.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        button.layer.mask = maskLayer;
        [button addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _leftButton = button;
    }
    return _leftButton;
}

- (void)leftButtonClicked{
    if (_leftButtonBlock) {
        _leftButtonBlock();
    }
}

- (UIButton *)rightButton{
    if (_rightButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.frame =CGRectMake(CGRectGetMaxX(self.leftButton.frame) + 1, CGRectGetMaxY(self.topView.frame), (self.topView.frame.size.width - 1)/2, 40);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];

        [button setTitle:@"重发红包" forState:UIControlStateNormal];
        button.titleLabel.font = DBMidFont;
        button.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerBottomRight  cornerRadii:CGSizeMake(5,5)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = button.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        button.layer.mask = maskLayer;
        [self.contentView addSubview:button];
        _rightButton = button;
    }
    return _rightButton;
}

- (void)rightButtonClicked{
    if (_rightButtonBlock) {
        _rightButtonBlock();
    }
}
#pragma mark -数据处理
- (void)setModel:(MyRedBagListModel *)model
{
    _model = model;

    _nameLabel.text = model.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    model.create_time = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.create_time integerValue]]];
    _timeLabel.text = model.create_time;
    
    NSString *overStr = [NSString stringWithFormat:@"%@/%@",model.over_num,model.num];
    _overLabel.text = overStr;
    
    

    NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:@"¥ "];
    NSDictionary * firstAttributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor],};
    [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
    
    NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",model.total_amount]];
    NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:33],NSForegroundColorAttributeName:[BaseTool colorFromHexRGB:@"DAA520"],};
    [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
    
    NSMutableAttributedString *thirdPart = [[NSMutableAttributedString alloc] initWithString:@" 元"];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]};
    [thirdPart setAttributes:dic range:NSMakeRange(0, thirdPart.length)];
    [firstPart appendAttributedString:secondPart];
    [firstPart appendAttributedString:thirdPart];
    
    _moneyLabel.attributedText = firstPart;
    
}

@end
