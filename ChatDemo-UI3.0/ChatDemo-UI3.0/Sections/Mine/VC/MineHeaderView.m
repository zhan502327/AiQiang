//
//  MineHeaderView.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/17.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView


+ (MineHeaderView *)viewWithFrame:(CGRect)frame{
    MineHeaderView *view = [[MineHeaderView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame = frame;
    imageview.image = [UIImage imageNamed:@"mineBgView"];
    imageview.userInteractionEnabled = YES;
    [view addSubview:imageview];
    
    
    [view iconImageView];
    [view nameLabel];
//    [view settingButton];
    return view;
}

- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        UIImageView *view = [[UIImageView alloc] init];
        view.frame = CGRectMake(self.frame.size.width/2 - 40, 30, 80, 80);
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 40;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewTap)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
        _iconImageView = view;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 120, self.frame.size.width, 40);
        label.text = @"name";
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

//- (UIButton *)settingButton{
//    if (_settingButton == nil) {
//        UIButton *button = [[UIButton alloc] init];;
//        button.frame = CGRectMake(self.frame.size.width - 50, 10, 40, 30);
//        [button setTitle:@"设置" forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(settingButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//        button.titleLabel.font = [UIFont systemFontOfSize:14];
//        [self addSubview:button];
//        _settingButton = button;
//    }
//    return _settingButton;
//}

- (void)settingButtonClicked{
    if (_settingButtonBlock) {
        _settingButtonBlock();
    }
}

- (void)iconImageViewTap{
    if (_iconImageViewBlock) {
        _iconImageViewBlock();
    }
}

- (void)setUserModel:(UserInfoModel *)userModel{
    _userModel = userModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",www,userModel.headimg]] placeholderImage:[UIImage imageNamed:@"head_placeholder"]];
    _nameLabel.text = userModel.nickname;

}

@end
