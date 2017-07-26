//
//  MyAccountTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/15.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyAccountTableViewCell.h"

@implementation MyAccountTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    MyAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell iconimageView];
    [cell nameLabel];
    [cell rightImageView];
    
    return cell;
}


#pragma mark - 懒加载视图
-(UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(10, 12.5, 25, 25);
        imgView.clipsToBounds=YES;
        imgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:imgView];
        _iconimageView = imgView;
    }
    return _iconimageView;
}
-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor= DBBlackColor;
        titleLabel.frame = CGRectMake(50, 10, self.contentView.frame.size.width - 100, 30);
        titleLabel.font = DBMaxFont;
        [self.contentView addSubview:titleLabel];
        _nameLabel= titleLabel;
    }
    return _nameLabel;
}

-(UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds=YES;
        imgView.frame = CGRectMake(SCREEN_WIDTH - 30, 12.5, 20, 25);
        imgView.image = [UIImage imageNamed:@"right_1"];
        imgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:imgView];
        _rightImageView = imgView;
    }
    return _rightImageView;
}


#pragma mark -数据处理

@end
