//
//  TwoButtonView.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/10/12.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoButtonView : UIView

//@property (nonatomic, strong) <#ModelClass#> *model;

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, copy) void(^buttonBlock)(NSInteger tag);

+ (instancetype)customViewWithFrame:(CGRect)frame;


@end
