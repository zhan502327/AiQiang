//
//  AllRedPacketHeaderView.h
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/22.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllManRedPacketListModel.h"
@interface AllRedPacketHeaderView : UIView

@property (nonatomic, copy) void (^didClick)(NSInteger tag);
@property (nonatomic, strong) AllManRedPacketListModel *model;

@property (nonatomic, strong) NSArray *modelArray;

@property (weak, nonatomic) IBOutlet UIView *FirstView;
@property (weak, nonatomic) IBOutlet UIView *SecondView;
@property (weak, nonatomic) IBOutlet UIView *ThirdView;
@property (weak, nonatomic) IBOutlet UIView *FourthViw;
@property (weak, nonatomic) IBOutlet UIView *FivethView;
@property (weak, nonatomic) IBOutlet UIView *SixthView;


@end
