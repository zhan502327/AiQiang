//
//  RedbagTextViewTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/9.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "RedbagTextViewTableViewCell.h"

#define GAP 10

@implementation RedbagTextViewTableViewCell
+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    RedbagTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell nameLabel];
    [cell textView];
    
    return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(GAP);
        make.left.equalTo(self.contentView.mas_left).offset(GAP);
        make.width.mas_equalTo(@(70));

        make.height.mas_equalTo(@(30));
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top).offset(GAP);
        make.left.equalTo(self.nameLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-GAP);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-GAP);
    }];
    
    [super updateConstraints];
}

#pragma mark - 懒加载视图
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = DBBlackColor;
        label.font = DBMaxFont;
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UITextView *)textView{
    if (_textView == nil) {
        UITextView *view = [[UITextView alloc] init];
        view.textColor = DBBlackColor;
        view.font = DBMaxFont;
        [self.contentView addSubview:view];
        _textView = view;
    }
    return _textView;
}

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
