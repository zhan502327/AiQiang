//
//  MyRecommendTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/11.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyRecommendTableViewCell.h"

@implementation MyRecommendTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    MyRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    [cell phoneLabel];
    [cell timeLabel];
    
    return cell;
}


#pragma mark - 懒加载视图
- (UILabel *)phoneLabel{
    if (_phoneLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 10, SCREEN_WIDTH - 220, 30);
        label.textColor = DBBlackColor;
        label.font = DBMaxFont;
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _phoneLabel = label;
    }
    return _phoneLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        UILabel *laebl = [[UILabel alloc] init];
        laebl.textAlignment = NSTextAlignmentRight;
        laebl.textColor = DBGrayColor;
        laebl.font = DBMidFont;
        laebl.frame = CGRectMake(SCREEN_WIDTH - 10 - 200, 10, 200, 30);
        [self.contentView addSubview:laebl];
        _timeLabel = laebl;
    }
    return _timeLabel;
}

#pragma mark -数据处理
- (void)setModel:(MyRecommendListModel *)model
{
    _model = model;


    self.phoneLabel.text = model.mobile;
    self.timeLabel.text = model.reg_time;
    
}

@end
