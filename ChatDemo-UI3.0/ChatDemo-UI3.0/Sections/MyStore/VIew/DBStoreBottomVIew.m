//
//  DBStoreBottomVIew.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/8/22.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBStoreBottomVIew.h"

@implementation DBStoreBottomVIew


+ (DBStoreBottomVIew *)viewWithFrame:(CGRect)frame{
    
    DBStoreBottomVIew *view = [[DBStoreBottomVIew alloc] init];
    view.frame = frame;
    
    UIButton *leftButton = [[UIButton alloc] init];
    leftButton.frame = CGRectMake(0, 0, (SCREEN_WIDTH)/2, frame.size.height);
    [leftButton setTitle:@"积分 666" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        leftButton.titleLabel.font = DBMaxFont;
    leftButton.backgroundColor = [UIColor whiteColor];
    [view addSubview:leftButton];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor redColor];
    lineView.frame = CGRectMake((SCREEN_WIDTH - 1)/2, 11, 1, frame.size.height- 22);
    lineView.layer.masksToBounds = YES;
    lineView.layer.cornerRadius = 0.5;
    [view addSubview:lineView];
    [view bringSubviewToFront:lineView];
    
    UIButton *rightbutton = [[UIButton alloc] init];
    rightbutton.frame = CGRectMake((SCREEN_WIDTH)/2, 0, (SCREEN_WIDTH)/2, frame.size.height);
    [rightbutton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [rightbutton setTitle:@"兑换记录" forState:UIControlStateNormal];
    [rightbutton setTitleColor:DBBlackColor forState:UIControlStateNormal];
    rightbutton.titleLabel.font = DBMaxFont;
    rightbutton.backgroundColor = [UIColor whiteColor];
    [view addSubview:rightbutton];
    return view;
}

@end
