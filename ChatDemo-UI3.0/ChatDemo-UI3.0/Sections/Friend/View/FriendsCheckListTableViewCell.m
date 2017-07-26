//
//  FriendsCheckListTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/6.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "FriendsCheckListTableViewCell.h"

@implementation FriendsCheckListTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    FriendsCheckListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    [cell iconimageView];
    [cell nameLaebl];
    [cell msgLabel];
    
    return cell;
}

#pragma mark - 懒加载视图
- (UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imageViw = [[UIImageView alloc] init];
        imageViw.frame = CGRectMake(10, 10, 40, 40);
        imageViw.layer.cornerRadius = 20;
        [self.contentView addSubview:imageViw];
        _iconimageView = imageViw;
    }
    return _iconimageView;
}

#pragma mark -数据处理
- (void)setModel:(FriendsCheckListModel *)model
{
    _model = model;

    
}

@end
