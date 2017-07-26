//
//  ThreeButtonView.h
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/13.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeButtonView : UIView

@property (nonatomic, copy) void(^didClickButton)(NSInteger tag);

@end
