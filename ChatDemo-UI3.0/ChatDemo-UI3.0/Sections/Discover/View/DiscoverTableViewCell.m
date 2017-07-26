//
//  DiscoverTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/31.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "DiscoverTableViewCell.h"


@interface DiscoverTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *head;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation DiscoverTableViewCell

- (IBAction)zan:(id)sender {
}
- (IBAction)comment:(id)sender {
}
- (IBAction)share:(id)sender {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setMessage:(YLFind *)message{


}
@end
