//
//  DBStoreBottomVIew.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/8/22.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBStoreBottomVIew.h"

#define buttonWidth 50
#define Gap ((SCREEN_WIDTH - buttonWidth*4)/4)


@implementation DBStoreBottomVIew


+ (DBStoreBottomVIew *)viewWithFrame:(CGRect)frame{
    
    DBStoreBottomVIew *view = [[DBStoreBottomVIew alloc] init];
    view.frame = frame;
//    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc] init];
    leftButton.frame = CGRectMake(0, 0, (SCREEN_WIDTH)/2, 50);
    [leftButton setTitle:@"积分 666" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    leftButton.tag = 100;
    [leftButton setImage:[UIImage imageNamed:@"storeScore"] forState:UIControlStateNormal];

        leftButton.titleLabel.font = DBMaxFont;
    leftButton.backgroundColor = [UIColor whiteColor];
    [view addSubview:leftButton];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor redColor];
    lineView.frame = CGRectMake((SCREEN_WIDTH - 1)/2, 11, 1, 50 - 22);
    lineView.layer.masksToBounds = YES;
    lineView.layer.cornerRadius = 0.5;
    [view addSubview:lineView];
    [view bringSubviewToFront:lineView];
    
    UIButton *rightbutton = [[UIButton alloc] init];
    rightbutton.frame = CGRectMake((SCREEN_WIDTH)/2, 0, (SCREEN_WIDTH)/2, 50);
    [rightbutton setImage:[UIImage imageNamed:@"storeList"] forState:UIControlStateNormal];
    rightbutton.tag = 101;
    [rightbutton addTarget:view action:@selector(bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    [rightbutton setTitle:@"兑换记录" forState:UIControlStateNormal];
    [rightbutton setTitleColor:DBBlackColor forState:UIControlStateNormal];
    rightbutton.titleLabel.font = DBMaxFont;
    rightbutton.backgroundColor = [UIColor whiteColor];
    [view addSubview:rightbutton];
    
    UIView *gapView = [[UIView alloc] init];
    gapView.frame = CGRectMake(0, CGRectGetMaxY(leftButton.frame), SCREEN_WIDTH, 10);
    gapView.backgroundColor = ColorTableViewBg;
    [view addSubview:gapView];
    
    
    NSArray *titleArray = @[@"日用百货",@"优惠礼券",@"其他专区",@"所有商品"];

    NSArray *imageArray = @[@"storeDay",@"storeYouHui",@"storeOther",@"storeAll"];
    
    for (int i = 0; i<titleArray.count; i++) {

        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(Gap/2 + i *(buttonWidth+Gap), CGRectGetMaxY(gapView.frame) + 20, buttonWidth, buttonWidth);
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [view addSubview:imageView];
        
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.frame = CGRectMake(0 + i*SCREEN_WIDTH/4, CGRectGetMaxY(imageView.frame) + 10, SCREEN_WIDTH/4, 20);
        label.text = titleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = DBMaxFont;
        label.tintColor = DBBlackColor;
        [view addSubview:label];
        
        UIButton *firstButton = [[UIButton alloc] init];
        firstButton.frame = CGRectMake( i*SCREEN_WIDTH/4, CGRectGetMinY(imageView.frame), SCREEN_WIDTH/4, buttonWidth + 20 + 10);
        firstButton.backgroundColor = [UIColor clearColor];
        [firstButton addTarget:view action:@selector(bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        firstButton.tag = 200+i;
        [view addSubview:firstButton];
    }
    return view;
}

- (void)bottomButtonClicked:(UIButton *)btn{
  
    if (_storeBottomViewBlock) {
        _storeBottomViewBlock(btn.tag);
    }
    
    
}

@end
