//
//  StealRedBagView.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/27.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StealRedBagView : UIView


@property (nonatomic, weak) UIImageView *resultImageView;
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *resultFirstLabel;
@property (nonatomic, weak) UILabel *resultSecondLabel;
@property (nonatomic, weak) UILabel *resultthirdLabel;
@property (nonatomic, weak) UILabel *shareLabel;


- (instancetype)init;

- (void)configViewWithStatus:(int) status Moeny:(NSString *)money andNickName:(NSString *)nickName andImageName:(NSString *)imageName;

@end
