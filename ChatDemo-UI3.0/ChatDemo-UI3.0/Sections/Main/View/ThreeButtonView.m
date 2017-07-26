//
//  ThreeButtonView.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/13.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "ThreeButtonView.h"

@implementation ThreeButtonView

- (IBAction)shangjia:(id)sender {
    if (_didClickButton) {
        _didClickButton(1);
    }
    
}

- (IBAction)jielong:(id)sender {
    if (_didClickButton) {
        _didClickButton(2);
    }
    
}

- (IBAction)quanmin:(id)sender {
    if (_didClickButton) {
        _didClickButton(3);
    }
    
}


@end
