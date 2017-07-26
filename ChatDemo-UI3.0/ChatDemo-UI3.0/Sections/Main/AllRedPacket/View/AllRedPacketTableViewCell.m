//
//  AllRedPacketTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/22.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "AllRedPacketTableViewCell.h"

@interface AllRedPacketTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *head;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *gotNumber;
@property (weak, nonatomic) IBOutlet UIButton *qiangButton;

@property (weak, nonatomic) IBOutlet UILabel *limitLabel;

@end


@implementation AllRedPacketTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.head.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewClicked)];
    
    [self.head addGestureRecognizer:tap];
    
    self.qiangButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    self.qiangButton.backgroundColor = [UIColor redColor];
    self.qiangButton.layer.masksToBounds = YES;
    self.qiangButton.layer.cornerRadius = 4;
}

- (void)iconImageViewClicked{
    if (_iconImageViewBlock) {
        _iconImageViewBlock();
    }
}

- (IBAction)qiang:(id)sender {
    if (_robRedBagBlock) {
        _robRedBagBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(AllManRedPacketListModel *)model{
    _model = model;
    
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",www,model.headimg];
    [self.head sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    

    self.name.text = model.nickname;
    
    //已抢
    NSString *gotStr = [NSString stringWithFormat:@"已抢%@/%@",model.over_num,model.num];
    self.gotNumber.text = gotStr;

//    self.number.text = model.total_amount;
    
    
    self.limitLabel.text = model.limitText;
    
}

@end
