//
//  DiscoverDetailHeaderView.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/24.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DiscoverDetailHeaderView : UIView



@property (nonatomic, weak) UIImageView *iconImageView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *timeLabel;


@property (nonatomic, weak) UILabel *contentLabel;

@property (nonatomic, weak) UIView *contentImageView;

@property (nonatomic, weak) UIButton *zanButton;

@property (nonatomic, weak) UIButton *pinglunButton;

@property (nonatomic, weak) UIButton *shareButton;

//@property (nonatomic, weak) UILabel *pinglunLabel;

@property (nonatomic, assign) NSInteger imageCount ;

@property (nonatomic, weak) UIImageView *imageView1;
@property (nonatomic, weak) UIImageView *imageView2;
@property (nonatomic, weak) UIImageView *imageView3;
@property (nonatomic, weak) UIImageView *imageView4;
@property (nonatomic, weak) UIImageView *imageView5;
@property (nonatomic, weak) UIImageView *imageView6;

@property (nonatomic, copy) void(^icomImageViewTapblock)();
@property (nonatomic, copy) void(^contentImageViewTapBlock)(NSInteger index, UIImageView *view, NSMutableArray *imageViewsArray);

@property (nonatomic, strong) NSMutableArray *imageArray;

+ (instancetype)customViewWithFrame;


@end
