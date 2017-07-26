//
//  RedBagChainResultHeaderView.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/31.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "RedBagChainResultHeaderView.h"

@implementation RedBagChainResultHeaderView


+ (RedBagChainResultHeaderView *)viewWithFrame:(CGRect)frame{
    
    RedBagChainResultHeaderView *view = [[RedBagChainResultHeaderView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    [view bgTopImageView];
    [view iconImageView];
    [view fromLabel];
    [view greetingLabel];
    [view moneyLabel];
    [view tipLabel];
    
    return view;
}

- (UIImageView *)bgTopImageView{
    if (_bgTopImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, self.frame.size.width, 80);
        imageView.image = [UIImage imageNamed:@"redbagDetail_header"];
        [self addSubview:imageView];
        _bgTopImageView = imageView;
    }
    return _bgTopImageView;
}

- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.frame = CGRectMake(self.frame.size.width/2 - 30, CGRectGetMaxY(self.bgTopImageView.frame) - 30, 60, 60);
        imageview.backgroundColor = [UIColor yellowColor];
        imageview.layer.masksToBounds = YES;
        imageview.layer.cornerRadius = 30;
        [self addSubview:imageview];
        _iconImageView = imageview;
    }
    return _iconImageView;
}

- (UILabel *)fromLabel{
    if (_fromLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame)+ 10, self.frame.size.width, 30);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13];
        [self addSubview:label];
        _fromLabel = label;
    }
    return _fromLabel;
}

- (UILabel *)greetingLabel{
    if (_greetingLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, CGRectGetMaxY(self.fromLabel.frame), self.frame.size.width, 30);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
        _greetingLabel = label;
    }
    return _greetingLabel;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame =CGRectMake(0, CGRectGetMaxY(self.greetingLabel.frame), self.frame.size.width, 40);
        label.font = [UIFont systemFontOfSize:30];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _moneyLabel = label;
    }
    return _moneyLabel;
}

- (UILabel *)tipLabel{
    if (_tipLabel == nil) {
        UILabel *label =[[UILabel alloc] init];
        label.text = @"已存入零钱，可用于发红包或提现";
        label.textColor = [UIColor grayColor];
        label.frame = CGRectMake( 0,CGRectGetMaxY( self.moneyLabel.frame), self.frame.size.width, 30);
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _tipLabel = label;
    }
    return _tipLabel;
}

- (void)setResultModel:(RedBagChainResultModel *)resultModel{
    _resultModel = resultModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",www,resultModel.headimg]]];
    
    self.fromLabel.text = [NSString stringWithFormat:@"%@ 的红包",resultModel.nickname];
    
    self.greetingLabel.text = resultModel.desc;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",resultModel.myself];

    
    
    
}



@end
