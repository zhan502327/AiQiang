//
//  ChooseSexView.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/20.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "ChooseSexView.h"
#import "UIButton+ImageTitleSpacing.h"

@implementation ChooseSexView



+ (ChooseSexView *)viewWithFrame:(CGRect)frame{
    
    ChooseSexView *view = [[ChooseSexView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.userInteractionEnabled = YES;
    view.layer.cornerRadius = 5;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view titleLabel];
    [view lineView];
    [view topTipLabel];
    [view manButton];
    [view womanButton];
    [view bottomTipLabel];
    [view leftButton];
    [view rightButton];
    [view centerView];
    [view topLineView];
    
    return view;
}


- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, self.frame.size.width, 49.5);
        label.text = @"请选择自己的性别";
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}


- (UIView *)lineView{
    if (_lineView == nil) {
        UIView *view = [[UIView alloc] init];
        view.frame =CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.frame.size.width, 0.5);
        view.backgroundColor = [UIColor redColor];
        [self addSubview:view];
        _lineView = view;
        
    }
    return _lineView;
}

- (UILabel *)topTipLabel{
    if (_topTipLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), self.frame.size.width, 50);
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"选择性别之后才能抢红包哦";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
        _topTipLabel = label;
    }
    return _topTipLabel;
}

- (UIButton *)manButton{
    if (_manButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(self.frame.size.width/2 - 90, CGRectGetMaxY(self.topTipLabel.frame) + 10, 80, 80);
        button.tag = 100 + 1;
        [button setImage:[UIImage imageNamed:@"man"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"manSelexted"] forState:UIControlStateSelected];
        [button setTitle:@"男" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:20];
        [self addSubview:button];
        _manButton = button;
    }
    return _manButton;
}

- (UIButton *)womanButton{
    if (_womanButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(CGRectGetMaxX(self.manButton.frame) + 20, CGRectGetMaxY(self.topTipLabel.frame) + 10, 80, 80);
        button.tag = 100 + 2;
        [button setImage:[UIImage imageNamed:@"woman"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"womanSelected"] forState:UIControlStateSelected];
        [button setTitle:@"女" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:20];
        [self addSubview:button];
        _womanButton = button;
    }
    return _womanButton;
}


- (UILabel *)bottomTipLabel{
    if (_bottomTipLabel == nil) {
        UILabel *label =[[UILabel alloc] init];
        label.frame = CGRectMake(0, CGRectGetMaxY(self.manButton.frame) + 10, self.frame.size.width, 50);
    
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"请选择真实信息，一旦选定将不可更改";
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        _bottomTipLabel = label;
    
    }
    return _bottomTipLabel;
}

- (UIView *)topLineView{
    if (_topLineView == nil) {
        UIView *view =[[UIView alloc] init];
        view.frame = CGRectMake(0, CGRectGetMaxY(self.bottomTipLabel.frame), self.frame.size.width, 0.5);
        
        view.backgroundColor = [UIColor grayColor];
        [self addSubview:view];
        _topLineView = view;
    }
    return _topLineView;
}

- (UIButton *)leftButton{
    if (_leftButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0, CGRectGetMaxY(self.topLineView.frame), (self.frame.size.width -0.5)/2, 49.5);
        button.tag = 100 + 3;
        [button setTitle:@"退出" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _leftButton = button;
    }
    return _leftButton;
}

- (UIView *)centerView{
    if (_centerView == nil) {
        UIView *view =[[UIView alloc] init];
        view.frame = CGRectMake(CGRectGetMaxX(self.leftButton.frame), CGRectGetMaxY(self.bottomTipLabel.frame), 0.5, 50);
        
        view.backgroundColor = [UIColor grayColor];
        [self addSubview:view];
        _centerView = view;
    }
    return _centerView;
}

- (UIButton *)rightButton{
    if (_rightButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(CGRectGetMaxX(self.leftButton.frame) + 0.5, CGRectGetMaxY(self.topLineView.frame) , (self.frame.size.width -0.5)/2, 49.5);
        button.tag = 100 + 4;

        [button setTitle:@"确认" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _rightButton = button;
    }
    return _rightButton;
}

- (void)buttonClicked:(UIButton *)button{
    switch (button.tag) {
        case 101:
            if (_manButtonBlock) {
                _manButtonBlock();
            }
            break;
        case 102:
            if (_womanButtonBlock) {
                _womanButtonBlock();
            }
            break;
        case 103:
            if (_leftButtonBlock) {
                _leftButtonBlock();
            }
            break;
        case 104:
            if (_rightButtonBlock) {
                _rightButtonBlock();
            }
            break;
   
        default:
            break;
    }
}



@end
