//
//  MoneyMangerHeaderTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/16.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MoneyMangerHeaderTableViewCell.h"

@implementation MoneyMangerHeaderTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    MoneyMangerHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell rightImageView];
    [cell nameLable];
    
    return cell;
}


#pragma mark - 懒加载视图
-(UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(SCREEN_WIDTH - 30, 15, 10, 20);
        imgView.clipsToBounds=YES;
        imgView.image = [UIImage imageNamed:@"leftArrow"];
        imgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:imgView];
        _rightImageView = imgView;
    }
    return _rightImageView;
}
-(UILabel *)nameLable{
    if (_nameLable == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(20, 10, 88, 30);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=[UIColor blackColor];
        [self.contentView addSubview:titleLabel];
        _nameLable= titleLabel;
    }
    return _nameLable;
}


#pragma mark -数据处理
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (indexPath.section == 0) {
        self.nameLable.text = @"充值";
    }else{
        self.nameLable.text = @"提现";
    }
}



@end
