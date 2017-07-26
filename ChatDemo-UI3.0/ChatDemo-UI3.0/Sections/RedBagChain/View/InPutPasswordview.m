//
//  InPutPasswordview.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/24.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "InPutPasswordview.h"

@implementation InPutPasswordview


+ (InPutPasswordview *)viewWithFrame:(CGRect)frame{
    InPutPasswordview *view = [[InPutPasswordview alloc] init];
    view.frame = frame;
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5;
    
    [view cancelButton];
    [view tipsLabel];
    [view lineview];
    [view tipsLabel];
    [view moneyLabel];
    [view passwordView];
    
    
    return view;
}

- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0, 10, 30, 30);
        [button setImage:[UIImage imageNamed:@"closer_1"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _cancelButton = button;
    }
    return _cancelButton;
}

- (void)cancleButtonClick{
    
    if (_cancelButtonBlock) {
        _cancelButtonBlock();
    }
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame), 10, self.frame.size.width - CGRectGetMaxX(self.cancelButton.frame), 30);
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"请输入支付密码";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIView *)lineview{
    if (_lineview == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor grayColor];
        view.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 10, self.frame.size.width, 0.5);
        [self addSubview:view];
        _lineview = view;
    }
    return _lineview;
}

- (UILabel *)tipsLabel{
    if (_tipsLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.text = @"零钱支付";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.frame = CGRectMake(0, CGRectGetMaxY(self.lineview.frame) + 10, self.frame.size.width, 30);
        [self addSubview:label];
        _tipsLabel = label;
    }
    return _tipsLabel;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame =CGRectMake(0, CGRectGetMaxY(self.tipsLabel.frame) , self.frame.size.width, 40);
        label.font= [UIFont boldSystemFontOfSize:25];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _moneyLabel = label;
    }
    return _moneyLabel;
}

- (SYPasswordView *)passwordView{
    if (_passwordView == nil) {
        SYPasswordView *view = [[SYPasswordView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.moneyLabel.frame) + 10, self.frame.size.width - 20, (self.frame.size.width - 20)/6)];
        [self addSubview:view];
        _passwordView = view;
    }
    return _passwordView;
}

@end
