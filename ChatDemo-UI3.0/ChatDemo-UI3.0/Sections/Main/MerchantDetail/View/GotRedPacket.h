//
//  GotRedPacket.h
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/21.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GotRedPacket : UIView

@property (weak, nonatomic) IBOutlet UILabel *yuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIImageView *brandView;
@property (weak, nonatomic) IBOutlet UILabel *moneyNumber;
@property (weak, nonatomic) IBOutlet UILabel *from;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

- (void)setType:(NSInteger )type AndNumber:(NSNumber *)number;



@end
