//
//  MineSecondTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/17.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MineSecondTableViewCell.h"

@implementation MineSecondTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    MineSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell nameLabel];
    [cell resultLable];
    [cell rightImageView];
    [cell redView];
    return cell;
}


#pragma mark - 懒加载视图
- (UIView *)redView
{
    if (_redView == nil) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(SCREEN_WIDTH - 50, 19, 12, 12);
        view.backgroundColor = [UIColor redColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 6;
        view.hidden = YES;
        [self addSubview:view];
        _redView = view;
    }
    return _redView;
}


-(UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(SCREEN_WIDTH - 30, 15, 20, 20);
        imgView.clipsToBounds=YES;
        imgView.image = [UIImage imageNamed:@"right_1"];
        imgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:imgView];
        _rightImageView = imgView;
    }
    return _rightImageView;
}
-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(15, 10, 100,  30);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = DBNameLabelColor;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = DBNameLabelFont;
        [self.contentView addSubview:titleLabel];
        _nameLabel= titleLabel;
    }
    return _nameLabel;
}
-(UILabel *)resultLable{
    if (_resultLable == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame) , 10, 100, 30);
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=[UIColor blackColor];
        [self.contentView addSubview:titleLabel];
        _resultLable= titleLabel;
    }
    return _resultLable;
}

#pragma mark -数据处理


@end
