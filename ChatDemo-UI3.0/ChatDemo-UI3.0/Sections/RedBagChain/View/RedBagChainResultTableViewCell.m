//
//  RedBagChainResultTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/31.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "RedBagChainResultTableViewCell.h"

#define Height 20

@implementation RedBagChainResultTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    RedBagChainResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell iconimageView];
    [cell nameLabel];
    [cell timeLabel];
    [cell moneyLabel];
    [cell goodLabel];
    
    
    return cell;
}

#pragma mark - 懒加载视图
-(UIImageView *)iconimageView{
    if (_iconimageView == nil) {

        UIImageView *imageViwe= [[UIImageView alloc] init];
        imageViwe.frame = CGRectMake(10, 10, 40, 40);
        imageViwe.layer.masksToBounds = YES;
        imageViwe.layer.cornerRadius = 20;
        imageViwe.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imageViwe];
        _iconimageView = imageViwe;
    }
    return _iconimageView;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame =CGRectMake(SCREEN_WIDTH - 110, 10, 100, Height);
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        _moneyLabel = label;
    }
    return _moneyLabel;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame =CGRectMake(CGRectGetMaxX(self.iconimageView.frame) + 10, 10, CGRectGetMaxX(self.moneyLabel.frame) - CGRectGetMaxX(self.iconimageView.frame) , Height);
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        label.frame = CGRectMake(CGRectGetMinX(self.nameLabel.frame), 30, 200, Height);
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor grayColor];
        [self.contentView addSubview:label];
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)goodLabel{
    if (_goodLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame =CGRectMake(CGRectGetMinX(self.moneyLabel.frame), 30, 100, Height);
        label.textColor = [UIColor yellowColor];
        label.text = @"手气最佳";
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        _goodLabel = label;
    }
    return _goodLabel;
}


#pragma mark -数据处理
- (void)setModel:(RedBagChainResultListModel *)model{
    _model = model;
    
    [self.iconimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",www,model.headimg]]];
    
    self.nameLabel.text = model.nickname;
    
    //设置创建时间
    NSString *timeStr=model.create_time;
    //将时间戳转换成标准时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStr.doubleValue];
    NSLog(@"%@",date);
    //格式化时间数据
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    
    NSString *strDate=[dateFormatter stringFromDate:date];
    
    self.timeLabel.text = strDate;

    self.moneyLabel.text = model.amount;
    
    if ([model.max isEqualToNumber:@1]) {
        self.goodLabel.hidden = NO;
    }else{
        self.goodLabel.hidden = YES;
    }
    
}


@end
