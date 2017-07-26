//
//  RedBagChainResultHeaderView.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/31.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedBagChainResultModel.h"

@interface RedBagChainResultHeaderView : UIView

@property (nonatomic, strong) RedBagChainResultModel *resultModel;
@property (nonatomic, weak) UIImageView *bgTopImageView;
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *fromLabel;
@property (nonatomic, weak) UILabel *greetingLabel;
@property (nonatomic, weak) UILabel *moneyLabel;
@property (nonatomic, weak) UILabel *tipLabel;


+ (RedBagChainResultHeaderView *)viewWithFrame:(CGRect )frame;

@end
