//
//  HomeCollectionViewCell.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/13.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (UIImageView *)brandImageView {
    if (!_brandImageView) {
        self.brandImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, self.contentView.frame.size.width - 40, self.contentView.frame.size.width - 40)];
        _brandImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _brandImageView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.contentView.frame.size.width - 30, self.contentView.frame.size.width - 40, 30)];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor colorWithRed:0.478 green:0.000 blue:0.012 alpha:1.000];
        _timeLabel.font = [UIFont systemFontOfSize:18];
    }
    return _timeLabel;
}

- (void)setModel:(MerchantRedPacket *)model {
    if (_model != model) {
        _model = model;
        _second = model.time / 1000;
        if (_second <= 0) {
            self.timeLabel.text = @"开抢红包";
        } else {
            if (_timer) {
                [_timer invalidate];
            }
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(less) userInfo:nil repeats:YES];
            self.timeLabel.text = [NSString stringWithFormat:@"%ld : %ld : %ld", _second / 3600, _second % 3600 / 60, _second % 3600 % 60 ];
        }
        [self.brandImageView sd_setImageWithURL:[NSURL URLWithString:model.imageURL]];
    }
}

- (void)less {
    _second--;
    _timeLabel.text = [NSString stringWithFormat:@"%ld : %ld : %ld", _second / 3600, _second % 3600 / 60, _second % 3600 % 60 ];
    if (_second <= 0) {
        [self.timer invalidate];
        _timeLabel.text = @"开抢红包";
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.brandImageView];
        [self.contentView addSubview:self.timeLabel];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width, 0, 0.5, self.contentView.frame.size.width)];
        view.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:view];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.width, self.contentView.frame.size.width, 0.5)];
        view1.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:view1];
    }
    return self;
}


@end
