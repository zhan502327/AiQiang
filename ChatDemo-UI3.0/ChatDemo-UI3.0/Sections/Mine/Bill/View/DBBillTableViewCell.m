//
//  DBBillTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/17.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBBillTableViewCell.h"

@implementation DBBillTableViewCell
+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    DBBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell nameLabel];
    [cell timeLabel];
    [cell moneyLabel];
    
    return cell;
}



#pragma mark - 懒加载视图

-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(10, 10, 250, 30);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor= DBBlackColor;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = DBMaxFont;
        [self.contentView addSubview:titleLabel];
        _nameLabel= titleLabel;
    }
    return _nameLabel;
}

-(UILabel *)timeLabel{
    if (_timeLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(10, CGRectGetMaxY(self.nameLabel.frame), 150, 20);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=[UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:titleLabel];
        _timeLabel= titleLabel;
    }
    return _timeLabel;
}
-(UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(SCREEN_WIDTH - 150, 20, 140, 30);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=[UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:titleLabel];
        _moneyLabel= titleLabel;
    }
    return _moneyLabel;
}

#pragma mark -数据处理
- (void)setModel:(BillModel *)model {
    if (_model != model) {
        _model = model;
        _nameLabel.text = model.log;
        _timeLabel.text = model.create_time;
        if ([model.type isEqualToString:@"1"]) {
            _moneyLabel.text = [NSString stringWithFormat:@"+%@", model.amount];
            
        } else {
            _moneyLabel.text = [NSString stringWithFormat:@"-%@", model.amount];
            
        }
    }
}


@end
