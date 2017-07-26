//
//  HomeCollectionViewCell.h
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/13.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantRedPacket.h"

@interface HomeCollectionViewCell : UICollectionViewCell {
    NSInteger _second;
}

@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UIImageView *brandImageView;
@property (strong, nonatomic) MerchantRedPacket *model;
@property (strong, nonatomic) NSTimer *timer;

@end
