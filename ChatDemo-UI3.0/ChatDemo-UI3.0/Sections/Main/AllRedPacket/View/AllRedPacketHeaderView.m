//
//  AllRedPacketHeaderView.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/22.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "AllRedPacketHeaderView.h"


@interface AllRedPacketHeaderView ()


@end


@implementation AllRedPacketHeaderView

- (IBAction)touch:(id)sender {
    UIButton *button = sender;
    
    if (_didClick) {
        _didClick(button.tag);
    }
    NSLog(@"%ld", button.tag);
    
}

- (void)setModel:(AllManRedPacketListModel *)model{
    _model = model;
    for (int i = 0; i < 6; i++) {
        UIView *view = [self viewWithTag:100 + i];
        
        //头像
        UIImageView *iconImageView = [view viewWithTag:1000 + i];
        NSString *urlstr = [NSString stringWithFormat:@"%@%@",www,model.headimg];
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:nil];
        
        //名字
        UILabel *name = [view viewWithTag:2000 + i];
        name.text = model.nickname;
        
        //金额
        UILabel *moneyLabel = [view viewWithTag:3000 + i];
        moneyLabel.text = model.total_amount;
        
        //已抢
        UILabel *yiqiangLabel = [view viewWithTag:4000 + i];
        yiqiangLabel.text = [NSString stringWithFormat:@"已抢%@/%@",model.over_num,model.num];
        
    }
    
}

- (void)setModelArray:(NSArray *)modelArray{
    
    _modelArray = modelArray;
    
    _FirstView.hidden = YES;
    _SecondView.hidden = YES;
    _ThirdView.hidden = YES;
    _FourthViw.hidden = YES;
    _FivethView.hidden = YES;
    _SixthView.hidden = YES;
    
   
    for (int i = 0; i < modelArray.count; i++) {
        AllManRedPacketListModel *model = modelArray[i];
        
        UIView *view = [self viewWithTag:100 + i];
        view.hidden = NO;
        
        //头像
        UIImageView *iconImageView = [view viewWithTag:1000 + i];
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.cornerRadius = 8.5;
        NSString *urlstr = [NSString stringWithFormat:@"%@%@",www,model.headimg];
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:nil];
        
        //名字
        UILabel *name = [view viewWithTag:2000 + i];
        name.text = model.nickname;
        
        //金额
        UILabel *moneyLabel = [view viewWithTag:3000 + i];
        moneyLabel.text = model.total_amount;
        
        //已抢
        UILabel *yiqiangLabel = [view viewWithTag:4000 + i];
        yiqiangLabel.text = [NSString stringWithFormat:@"已抢%@/%@",model.over_num,model.num];
        
    }

    
    
    
}




@end
