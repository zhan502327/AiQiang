//
//  TwoButtonView.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/10/12.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "TwoButtonView.h"

#define imageWidth 40
#define labelWidth 80
@implementation TwoButtonView

+ (instancetype)customViewWithFrame:(CGRect)frame{
    
    TwoButtonView *view = [[TwoButtonView alloc] init];
    view.frame = frame;
    view.backgroundColor = [UIColor whiteColor];


    UIImageView *leftimaeView = [[UIImageView alloc] init];
    leftimaeView.image = [UIImage imageNamed:@"jielongx"];
    leftimaeView.frame = CGRectMake((SCREEN_WIDTH - imageWidth*2)/3 - 8, 10, imageWidth, imageWidth);
    [view addSubview:leftimaeView];
    
    UIImageView *rightImageView = [[UIImageView alloc] init];
    rightImageView.image = [UIImage imageNamed:@"quanminx"];
    rightImageView.frame = CGRectMake((SCREEN_WIDTH - imageWidth*2)/3*2 + imageWidth  + 8 , 10, imageWidth, imageWidth);
    [view addSubview:rightImageView];
    
    UILabel *leftlabel = [[UILabel label] init];
    leftlabel.frame = CGRectMake((SCREEN_WIDTH - labelWidth*2)/3, CGRectGetMaxY(leftimaeView.frame),labelWidth, 20);
    leftlabel.text = @"红包接龙";
    leftlabel.textColor = [UIColor blackColor];
    leftlabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:leftlabel];
    
    
    UILabel *rightLabel = [[UILabel label] init];
    rightLabel.frame = CGRectMake((SCREEN_WIDTH - labelWidth*2)/3*2 + labelWidth  , CGRectGetMaxY(leftimaeView.frame), labelWidth, 20);
    rightLabel.text = @"全民红包";
    rightLabel.textColor = [UIColor blackColor];
    rightLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:rightLabel];
    
    UIButton *leftButton = [[UIButton alloc] init];
    leftButton.backgroundColor = [UIColor clearColor];
    leftButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, frame.size.height);
    leftButton.tag = 100;
    [leftButton addTarget:view action:@selector(allbbButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:leftButton];
    
    
    UIButton *rightButton = [[UIButton alloc] init];
    rightButton.backgroundColor = [UIColor clearColor];
    rightButton.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, frame.size.height);
    rightButton.tag = 101;
    [rightButton addTarget:view action:@selector(allbbButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:rightButton];
    
    return view;
}

- (void)allbbButtonClicked:(UIButton *)button{
    if (_buttonBlock) {
        _buttonBlock(button.tag);
    }
}

@end
