//
//  NormalTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/18.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "NormalTableViewCell.h"

@implementation NormalTableViewCell
+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell iconimageView];
    [cell titleLabel];
    
    return cell;
}

#pragma mark - 懒加载视图
-(UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(SCREEN_WIDTH - 30, 15, 20, 20);
        imgView.clipsToBounds=YES;
        imgView.image = [UIImage imageNamed:@"right_1"];
        imgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:imgView];
        _iconimageView = imgView;
    }
    return _iconimageView;
}
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(10, 10, 150, 30);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=DBBlackColor;
        titleLabel.font = DBMaxFont;
        [self.contentView addSubview:titleLabel];
        _titleLabel= titleLabel;
    }
    return _titleLabel;
}


#pragma mark -数据处理
@end
