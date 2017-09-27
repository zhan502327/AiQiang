//
//  StealRedBagView.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/27.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "StealRedBagView.h"
#import "DBGtInfo.h"

@implementation StealRedBagView
- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.7;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackViwClicked)];
        [self addGestureRecognizer:tap];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        [self resultImageView];
        [self iconImageView];
        [self resultFirstLabel];
        [self resultSecondLabel];
        [self resultthirdLabel];
        
    }
    
    return self;
}

- (void)setType:(int)type{
    _type = type;
    
    [self shareButton];

}

- (void)setRedBagMoney:(NSString *)redBagMoney{
    _redBagMoney = redBagMoney;
    
}

- (UIImageView *)resultImageView{
    if (_resultImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(50, 100, SCREEN_WIDTH - 100, (SCREEN_WIDTH - 100)*1.44);
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resultImageViewClicked)];
        [imageView addGestureRecognizer:tap];
        [[UIApplication sharedApplication].keyWindow addSubview:imageView];
        _resultImageView = imageView;
    }
    return _resultImageView;
}

- (UIButton *)shareButton{
    if (_shareButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(100, CGRectGetMaxY(self.resultImageView.frame)+ 50, SCREEN_WIDTH - 200, 40);

        [button setTitle:@"分享给好友" forState:UIControlStateNormal];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 4;
        [button addTarget:self action:@selector(shareButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [[UIApplication sharedApplication].keyWindow addSubview:button];
        _shareButton = button;
    }
    return _shareButton;
}

- (DBShareView *)shareView{
    if (_shareView == nil) {
        
        DBShareView *shareView= [DBShareView viewWithFrame:CGRectMake(0, SCREEN_HEIGHT - 120, SCREEN_HEIGHT, 120) andShareType:self.type andMoney:self.redBagMoney];
        
        [[UIApplication sharedApplication].keyWindow addSubview:shareView];
        _shareView = shareView;
    }
    return _shareView;
}

- (void)shareButtonClicked{
    [self.resultImageView removeFromSuperview];
    [self.shareButton removeFromSuperview];

    [self shareView];
}

- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        
        
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat y = 80;
        
        if ([[DBGtInfo iphoneType] isEqualToString:@"iPhone 7 Plus"] || [[DBGtInfo iphoneType] isEqualToString:@"iPhone 6 Plus"] || [[DBGtInfo iphoneType] isEqualToString:@"iPhone 6s Plus"]) {
            y = 80;
        }
        
        if ([[DBGtInfo iphoneType] isEqualToString:@"iPhone 6"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 6s"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 7"] ) {
            y = 68;
        }
        
        if ([[DBGtInfo iphoneType] isEqualToString:@"iPhone 5"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 5c"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 5s"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone SE"]) {
            y = 50;
        }
        
        imageView.frame = CGRectMake(self.resultImageView.frame.size.width/2 - 30, y, 60, 60);
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = imageView.frame.size.width/2;
        [self.resultImageView addSubview:imageView];
        _iconImageView = imageView;
    }
    return _iconImageView;
}
- (void)blackViwClicked{
    [self removeFromSuperview];
    [self.resultImageView removeFromSuperview];
    [self.shareButton removeFromSuperview];
    [self.shareView removeFromSuperview];
}

- (void)resultImageViewClicked{
    [self removeFromSuperview];
    [self.resultImageView removeFromSuperview];
    [self.shareButton removeFromSuperview];
    [self.shareView removeFromSuperview];
}

- (UILabel *)resultFirstLabel{
    if (_resultFirstLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"成功领取现金";
        
        CGFloat y = 230;
        
        if ([[DBGtInfo iphoneType] isEqualToString:@"iPhone 7 Plus"] || [[DBGtInfo iphoneType] isEqualToString:@"iPhone 6 Plus"] || [[DBGtInfo iphoneType] isEqualToString:@"iPhone 6s Plus"]) {
            y = 230;
        }
        
        if ([[DBGtInfo iphoneType] isEqualToString:@"iPhone 6"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 6s"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 7"] ) {
            y = 200;
        }
        
        if ([[DBGtInfo iphoneType] isEqualToString:@"iPhone 5"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 5c"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 5s"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone SE"]) {
            y = 150;
        }
        
        label.frame = CGRectMake(0, y, self.resultImageView.frame.size.width, 40);

//        label.frame = CGRectMake(0, 200, self.resultImageView.frame.size.width, 40);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
        [self.resultImageView addSubview:label];
        _resultFirstLabel = label;
    }
    return _resultFirstLabel;
}

- (UILabel *)resultSecondLabel{
    if (_resultSecondLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        
        
        CGFloat y = 300;
        
        if ([[DBGtInfo iphoneType] isEqualToString:@"iPhone 7 Plus"] || [[DBGtInfo iphoneType] isEqualToString:@"iPhone 6 Plus"] || [[DBGtInfo iphoneType] isEqualToString:@"iPhone 6s Plus"]) {
            y = 300;
        }
        
        if ([[DBGtInfo iphoneType] isEqualToString:@"iPhone 6"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 6s"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 7"] ) {
            y = 260;
        }
        
        if ([[DBGtInfo iphoneType] isEqualToString:@"iPhone 5"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 5c"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 5s"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone SE"]) {
            y = 200;
        }
        label.frame = CGRectMake(0, y, self.resultImageView.frame.size.width, 50);

//        label.frame = CGRectMake(0, CGRectGetMaxY(self.resultFirstLabel.frame) + 10, self.resultImageView.frame.size.width, 50);
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [self.resultImageView addSubview:label];
        _resultSecondLabel = label;
    }
    return _resultSecondLabel;
}

- (UILabel *)resultthirdLabel{
    if (_resultthirdLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        
        CGFloat y = 370;
        
        if ([[DBGtInfo iphoneType] isEqualToString:@"iPhone 7 Plus"] || [[DBGtInfo iphoneType] isEqualToString:@"iPhone 6 Plus"] || [[DBGtInfo iphoneType] isEqualToString:@"iPhone 6s Plus"]) {
            y = 370;
        }
        
        if ([[DBGtInfo iphoneType] isEqualToString:@"iPhone 6"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 6s"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 7"] ) {
            y = 330;
        }
        
        if ([[DBGtInfo iphoneType] isEqualToString:@"iPhone 5"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 5c"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone 5s"] ||
            [[DBGtInfo iphoneType] isEqualToString:@"iPhone SE"]) {
            y = 250;
        }
        label.frame =CGRectMake(0, y, self.resultImageView.frame.size.width, 50);

//        label.frame =CGRectMake(0, CGRectGetMaxY(self.resultImageView.frame) - 180, self.resultImageView.frame.size.width, 50);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
        [self.resultImageView addSubview:label];
        _resultthirdLabel = label;
    }
    return _resultthirdLabel;
}

- (void)configViewWithStatus:(int) status Moeny:(NSString *)money andNickName:(NSString *)nickName andImageName:(NSString *)imageName{

    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString: imageName] placeholderImage:[UIImage imageNamed:@"head_placeholder"]];
    
    if (status == 1) {
        self.resultFirstLabel.hidden = NO;
        self.resultthirdLabel.hidden = NO;
        self.resultSecondLabel.hidden = NO;
        self.shareButton.hidden = NO;

        self.resultImageView.image = [UIImage imageNamed:@"bigRedPacket"];
        NSString *moneyStr = [NSString stringWithFormat:@"%.2f元",[money floatValue]];
        
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:moneyStr];
        [attributeStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:40], NSForegroundColorAttributeName : [UIColor yellowColor]} range:NSMakeRange(0, moneyStr.length - 1)];
        
        self.resultSecondLabel.attributedText = attributeStr;
        
        self.resultthirdLabel.text = [NSString stringWithFormat:@"来自 %@ 的红包",nickName];
        
    }else{
        self.resultImageView.image = [UIImage imageNamed:@"bigRedPacket_un"];
        self.resultFirstLabel.hidden = YES;
        self.resultthirdLabel.hidden = YES;
        self.resultSecondLabel.hidden = YES;
        self.shareButton.hidden = YES;
    }
}

@end
