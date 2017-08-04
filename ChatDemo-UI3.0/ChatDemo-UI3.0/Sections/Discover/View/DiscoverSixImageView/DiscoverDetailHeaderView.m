//
//  DiscoverDetailHeaderView.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/24.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DiscoverDetailHeaderView.h"
#import "SDAutoLayout.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define GAP 10
#define imageGAP 2
#define viewwidth self.contentImageView.frame.size.width
#define viewHeght self.contentImageView.frame.size.height
@implementation DiscoverDetailHeaderView

+ (instancetype)customViewWithFrame{
    
    DiscoverDetailHeaderView *view = [[DiscoverDetailHeaderView alloc] init];
    view.userInteractionEnabled = YES;
    [view iconImageView];
    [view nameLabel];
    [view timeLabel];
    [view contentLabel];
    [view contentImageView];
    [view zanButton];
    [view pinglunButton];
    [view shareButton];
//    [view pinglunLabel];
    
//    [view imageView1];
//    [view imageView2];
//    [view imageView3];
//    [view imageView4];
//    [view imageView5];
//    [view imageView6];
    return view;
}




- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        //设置头像的圆角
        imageView.layer.masksToBounds=YES;
        imageView.layer.cornerRadius=25;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(IconImageViewTap)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (void)IconImageViewTap{
    if (_icomImageViewTapblock) {
        _icomImageViewTapblock();
    }
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = DBBlackColor;
        label.font = DBMaxFont;
        [self addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = DBGrayColor;
        label.font = DBMinFont;
        [self addSubview:label];
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = DBBlackColor;
        label.font = DBMaxFont;
        [self addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UIView *)contentImageView{
    if (_contentImageView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];

        [self addSubview:view];
        _contentImageView = view;
    }
    return _contentImageView;
}

- (UIImageView *)imageView1{
    if (_imageView1 == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.tag = 100+ 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClocked:)];
        [imageView addGestureRecognizer:tap];
        
        [self.contentImageView addSubview:imageView];
        _imageView1 = imageView;
    }
    return _imageView1;
}

- (UIImageView *)imageView2{
    if (_imageView2 == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.tag = 100+ 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClocked:)];
        [imageView addGestureRecognizer:tap];
        [self.contentImageView addSubview:imageView];
        _imageView2 = imageView;
    }
    return _imageView2;
}

- (UIImageView *)imageView3{
    if (_imageView3 == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.tag = 100+ 2;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClocked:)];
        [imageView addGestureRecognizer:tap];
        [self.contentImageView addSubview:imageView];
        _imageView3 = imageView;
    }
    return _imageView3;
}

- (UIImageView *)imageView4{
    if (_imageView4 == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.tag = 100+ 3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClocked:)];
        [imageView addGestureRecognizer:tap];
        [self.contentImageView addSubview:imageView];
        _imageView4 = imageView;
    }
    return _imageView4;
}

- (UIImageView *)imageView5{
    if (_imageView5 == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.tag = 100+ 4;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClocked:)];
        [imageView addGestureRecognizer:tap];
        [self.contentImageView addSubview:imageView];
        _imageView5 = imageView;
    }
    return _imageView5;
}

- (UIImageView *)imageView6{
    if (_imageView6 == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100+ 5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClocked:)];
        [imageView addGestureRecognizer:tap];
        imageView.layer.masksToBounds = YES;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        [self.contentImageView addSubview:imageView];
        _imageView6 = imageView;
    }
    return _imageView6;
}

- (void)imageViewClocked:(UITapGestureRecognizer *)tap{
    
    UIImageView *view = (UIImageView *)tap.view;
    NSInteger tag = view.tag;
    NSInteger index = tag - 100;
    
    NSMutableArray *imageViewArray = [NSMutableArray arrayWithCapacity:0];
    
    NSLog(@"self.imageCount------%ld",self.imageCount);
    if (self.imageCount == 1) {
        [imageViewArray addObject:self.imageView1];
        
    }
    
    if (self.imageCount == 2) {
        [imageViewArray addObject:self.imageView1];
        [imageViewArray addObject:self.imageView2];
    }
    
    if (self.imageCount == 3) {
        [imageViewArray addObject:self.imageView1];
        [imageViewArray addObject:self.imageView2];
        [imageViewArray addObject:self.imageView3];

    }
    
    if (self.imageCount == 4) {
        [imageViewArray addObject:self.imageView1];
        [imageViewArray addObject:self.imageView2];
        [imageViewArray addObject:self.imageView3];
        [imageViewArray addObject:self.imageView4];

    }
    
    if (self.imageCount == 5) {
        [imageViewArray addObject:self.imageView1];
        [imageViewArray addObject:self.imageView2];
        [imageViewArray addObject:self.imageView3];
        [imageViewArray addObject:self.imageView4];
        [imageViewArray addObject:self.imageView5];

    }
    
    if (self.imageCount == 6) {
        [imageViewArray addObject:self.imageView1];
        [imageViewArray addObject:self.imageView2];
        [imageViewArray addObject:self.imageView3];
        [imageViewArray addObject:self.imageView4];
        [imageViewArray addObject:self.imageView5];
        [imageViewArray addObject:self.imageView6];

    }
    
    if (_contentImageViewTapBlock) {
        _contentImageViewTapBlock(index ,view,imageViewArray);
    }
    
}

- (UIButton *)zanButton{
    if (_zanButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"discover_zan_selected"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:button];
        _zanButton = button;
    }
    return _zanButton;
}

- (UIButton *)pinglunButton{
    if (_pinglunButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"discover_comment"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"discover_comment"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:button];
        _pinglunButton = button;
    }
    return _pinglunButton;
}

- (UIButton *)shareButton{
    if (_shareButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"share"] forState:UIControlStateSelected];
        [self addSubview:button];
        _shareButton = button;
    }
    return _shareButton;
}

//- (UILabel *)pinglunLabel{
//    if (_pinglunLabel == nil) {
//        UILabel *label = [[UILabel alloc] init];
//        label.text = @" 评论";
//        label.layer.masksToBounds = YES;
//        label.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        label.layer.borderWidth = 0.5;
//        label.layer.cornerRadius = 5;
//        label.font = [UIFont systemFontOfSize:13];
//        label.textColor = [UIColor grayColor];
//        label.hidden = YES;
//        label.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:label];
//        _pinglunLabel = label;
//    }
//    return _pinglunLabel;
//}

- (void)setImageCount:(NSInteger)imageCount{
    NSLog(@"imageCount------%ld",imageCount);
    _imageCount = imageCount;
}




@end
