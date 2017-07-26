//
//  OtherPersonInfoTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "OtherPersonInfoTableViewCell.h"

@implementation OtherPersonInfoTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    OtherPersonInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [cell titleLabel];
    [cell descLabel];
    
    return cell;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 10, 100, 30);
        label.backgroundColor = [UIColor whiteColor];
        label.font = DBMaxFont;
        label.textColor = DBBlackColor;
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        
        _titleLabel = label;
    }
    return _titleLabel;
}


- (UILabel *)descLabel{
    if (_descLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = DBMaxFont;
        label.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+ 30, 10, SCREEN_WIDTH - CGRectGetMaxX(self.titleLabel.frame) - 30, 30);
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = DBBlackColor;
        [self.contentView addSubview:label];
        _descLabel = label;
    }
    return _descLabel;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subview in self.contentView.superview.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
            subview.hidden = NO;
            CGRect frame = subview.frame;
            frame.origin.x += self.separatorInset.left;
            frame.size.width -= self.separatorInset.right;
            subview.frame =frame;
        }
    }
}

#pragma mark - 懒加载视图


#pragma mark -数据处理
//- (void)setModel:(<#ModelClass#> *)model
//{
//    _model = model;
//    
//    [_imgView ideago_setImageWithURL:model.img placeholderImage:[UIImage imageNamed:@"placeholder1"]];
//    _titleLabel.text = model.title;
//    
//}

@end
