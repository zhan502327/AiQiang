//
//  MineHeaderView.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/17.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@interface MineHeaderView : UIView
@property (nonatomic, strong) UserInfoModel *userModel;
@property (nonatomic, assign) BOOL hiddenSettingButton;

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIButton *settingButton;

@property (nonatomic, copy) void(^iconImageViewBlock)();
@property (nonatomic, copy) void(^settingButtonBlock)();
+ (MineHeaderView *)viewWithFrame:(CGRect)frame;

@end
