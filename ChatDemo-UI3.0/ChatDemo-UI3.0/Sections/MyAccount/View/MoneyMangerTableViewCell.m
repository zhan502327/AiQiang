//
//  MoneyMangerTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/15.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MoneyMangerTableViewCell.h"

@implementation MoneyMangerTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    MoneyMangerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
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
        titleLabel.textColor=DBBlackColor;
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
        imgView.frame = CGRectMake(SCREEN_WIDTH - 30, 17.5, 15, 15);
        imgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:imgView];
        _rightImageView = imgView;
    }
    return _rightImageView;
}


#pragma mark -数据处理
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

- (void)setType:(int)type
{
    NSArray *imageArray = @[@"weixin",@"zhifubao"];
    NSArray *nameArray = @[@"提现到支付宝",@"提现到微信"];
    NSArray *rightImageView = @[@"yuanSelected",@"yuan"];

    _type = type;
    if (type == 1) {//充值
        self.iconimageView.hidden = NO;
        self.nameLabel.hidden = YES;
 
        if (self.indexPath.row == 1) {
            self.iconimageView.frame = CGRectMake(50, 15, 55, 20);
        }else{
            self.iconimageView.frame = CGRectMake(50, 15, 55, 20);
        }
        self.rightImageView.image = [UIImage imageNamed:rightImageView[self.indexPath.section]];
        self.iconimageView.image = [UIImage imageNamed:imageArray[self.indexPath.section]];
        
        
        
    }
    if (type == 2) {//提现
        self.iconimageView.hidden = YES;
        self.nameLabel.hidden = NO;
        self.nameLabel.frame = CGRectMake(50, 10, 200, 30);
        self.nameLabel.text = nameArray[self.indexPath.section];
        self.rightImageView.image = [UIImage imageNamed:rightImageView[self.indexPath.section]];
        
    }
}


@end
