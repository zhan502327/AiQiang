//
//  PersonalTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/19.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "PersonalTableViewCell.h"

@implementation PersonalTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

//    [cell titleLabel];
//    [cell iconimageView];
//    [cell textField];
//    [cell resultLabel];
    
    return cell;
}


#pragma mark - 懒加载视图
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(10, 10, 80, 30);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=DBTitleLabelColor;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = DBTitleLabelFont;
        [self.contentView addSubview:titleLabel];
        _titleLabel= titleLabel;
    }
    return _titleLabel;
}

-(UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds=YES;
        imgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:imgView];
        _iconimageView = imgView;
    }
    return _iconimageView;
}
-(UILabel *)resultLabel{
    if (_resultLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=DBResultLabelColor;
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.font = DBResultLabelFont;
        [self.contentView addSubview:titleLabel];
        _resultLabel= titleLabel;
    }
    return _resultLabel;
}

- (UITextField *)textField{
    if (_textField == nil) {
        UITextField *textfield = [[UITextField alloc] init];
        textfield.textAlignment = NSTextAlignmentRight;
        textfield.textColor = DBResultLabelColor;
        textfield.font = DBResultLabelFont;
        [self.contentView addSubview:textfield];
        _textField = textfield;
    }
    return _textField;
}


#pragma mark -数据处理


- (void)setType:(NSString *)type{
    _type = type;
    
    if ([type isEqualToString:@"UIImageView"]) {
        self.iconimageView.frame = CGRectMake(SCREEN_WIDTH - 40, 10, 30, 30);

    }
    
    if ([type isEqualToString:@"UILabel"]) {
        self.resultLabel.frame = CGRectMake( CGRectGetMaxX(self.titleLabel.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(self.titleLabel.frame) - 10 - 10, 30);

    }
    
    if ([type isEqualToString:@"UITextField"]) {
        self.textField.frame = CGRectMake(SCREEN_WIDTH - 200, 10, 190, 30);

    }
    
}
@end
