//
//  MerchantCommentTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/25.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "MerchantCommentTableViewCell.h"
#import "MerchantCommentModel.h"


@interface MerchantCommentTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *head;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *comment;

@end

@implementation MerchantCommentTableViewCell


- (void)setModel:(MerchantCommentModel *)model {
    if (_model != model) {
        _model = model;
        [_head sd_setImageWithURL:[NSURL URLWithString:model.headimg]];
        _name.text = model.nickname;
        _time.text = model.create_time;
        _comment.text = model.comment;
        [_comment sizeToFit];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
