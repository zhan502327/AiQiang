//
//  ChooseSexView.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/20.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseSexView : UIView


@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UILabel *topTipLabel;
@property (nonatomic, weak) UIButton *manButton;
@property (nonatomic, weak) UIButton *womanButton;
@property (nonatomic, weak) UILabel *bottomTipLabel;
@property (nonatomic, weak) UIButton *leftButton;
@property (nonatomic, weak) UIButton *rightButton;
@property (nonatomic, weak) UIView *topLineView;
@property (nonatomic, weak) UIView *centerView;

@property (nonatomic, copy) void(^manButtonBlock)();
@property (nonatomic, copy) void(^womanButtonBlock)();
@property (nonatomic, copy) void(^leftButtonBlock)();
@property (nonatomic, copy) void(^rightButtonBlock)();

+ (ChooseSexView *)viewWithFrame:(CGRect)frame;


@end
