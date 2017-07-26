//
//  MyAccountHeaderView.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/15.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyAccountHeaderView.h"

@implementation MyAccountHeaderView


+ (MyAccountHeaderView *)createViewWithFrame:(CGRect)frame{
    MyAccountHeaderView *view = [[MyAccountHeaderView alloc] init];
    view.frame = frame;
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *topview = [[UIView alloc] init];
    topview.frame = CGRectMake(0, 0, frame.size.width, frame.size.height * 3/4);
    topview.backgroundColor = [UIColor redColor];
    [view addSubview:topview];
    
    [view accountLabel];
    [view leftButton];
    [view rightButton];
    return view;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"账户余额（元）";
        label.textColor = [UIColor whiteColor];
        label.frame = CGRectMake(0, 50, self.frame.size.width, 30);
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)accountLabel{
    if (_accountLabel == nil) {
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame) + 30, SCREEN_WIDTH, 60);
        label.font = [UIFont systemFontOfSize:40];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _accountLabel = label;
    }
    return _accountLabel;
}

- (UIButton *)leftButton{
    if (_leftButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0, self.frame.size.height *3/4 , (self.frame.size.width )/2, 50);
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor redColor];
//        [button addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
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
        button.frame = CGRectMake(self.leftButton.frame.size.width , self.frame.size.height *3/4, self.leftButton.frame.size.width, 50);
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor redColor];
//        [button addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:button];
        _rightButton = button;
    }
    return _rightButton;
}

- (void)rightButtonClicked{
    if (_rightButtonBlock) {
        _rightButtonBlock();
    }
}

@end
