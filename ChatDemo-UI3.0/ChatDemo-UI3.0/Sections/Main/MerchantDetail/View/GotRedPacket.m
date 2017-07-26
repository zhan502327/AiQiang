//
//  GotRedPacket.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/21.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "GotRedPacket.h"

@implementation GotRedPacket

- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}


- (void)drawRect:(CGRect)rect {
    _brandView.layer.cornerRadius = 30;
    _brandView.clipsToBounds = YES;
}

- (void)setType:(NSInteger )type AndNumber:(NSNumber *)number {
    if (!type) {
        _bigImageView.image = [UIImage imageNamed:@"bigRedPacket_un"];
        _moneyNumber.hidden = YES;
        _label1.hidden = YES;
        _yuanLabel.hidden = YES;
    } else {
        _moneyNumber.text = [NSString stringWithFormat:@"%.2f", [number floatValue]];
    }
}

@end
