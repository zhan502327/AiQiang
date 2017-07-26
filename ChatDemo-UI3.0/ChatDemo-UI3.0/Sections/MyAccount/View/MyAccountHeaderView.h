//
//  MyAccountHeaderView.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/15.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountHeaderView : UIView
@property (nonatomic, weak) UIButton *leftButton;
@property (nonatomic, weak) UIButton *rightButton;
@property (nonatomic, weak) UILabel *accountLabel;
@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, copy) void(^leftButtonBlock)();
@property (nonatomic, copy) void(^rightButtonBlock)();

+ (MyAccountHeaderView *)createViewWithFrame:(CGRect)frame;

@end
