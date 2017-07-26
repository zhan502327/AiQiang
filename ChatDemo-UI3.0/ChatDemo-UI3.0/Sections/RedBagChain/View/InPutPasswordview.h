//
//  InPutPasswordview.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/24.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPasswordView.h"

@interface InPutPasswordview : UIView

@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIView *lineview;
@property (nonatomic, weak) UILabel *tipsLabel;
@property (nonatomic, weak) UILabel *moneyLabel;
@property (nonatomic, weak) SYPasswordView *passwordView;

@property (nonatomic, copy) void(^cancelButtonBlock)();

+ (InPutPasswordview *)viewWithFrame:(CGRect)frame;

@end
