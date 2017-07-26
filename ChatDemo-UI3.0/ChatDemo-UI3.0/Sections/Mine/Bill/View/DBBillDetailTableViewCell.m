//
//  DBBillDetailTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/1.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBBillDetailTableViewCell.h"

@implementation DBBillDetailTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    DBBillDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell nameLabel];
    [cell rightLabel];
    
    return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(@(80));
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.nameLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    [super updateConstraints];
}

#pragma mark - 懒加载视图
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = DBMaxFont;
        label.textColor = DBBlackColor;
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)rightLabel{
    if (_rightLabel == nil ) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentRight;
        label.font = DBMaxFont;
        label.textColor = DBGrayColor;
        [self.contentView addSubview:label];
        _rightLabel = label;
    }
    return _rightLabel;
}



@end
