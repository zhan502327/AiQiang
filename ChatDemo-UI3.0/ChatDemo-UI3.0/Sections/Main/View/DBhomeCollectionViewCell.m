//
//  DBhomeCollectionViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/18.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBhomeCollectionViewCell.h"

@implementation DBhomeCollectionViewCell

+ (instancetype)normalCollectionCellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *className = NSStringFromClass([self class]);
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:className];
    DBhomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:className forIndexPath:indexPath];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    
    
    [cell imageView];
    [cell bottonLabel];
    return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        

    }];
    
    [_bottonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@40);
        
        
    }];

    
    [super updateConstraints];
}

#pragma mark - 懒加载视图
-(UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds=YES;
        imgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:imgView];
        _imageView = imgView;
    }
    return _imageView;
}

- (UILabel *)bottonLabel{
    if (_bottonLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.adjustsFontSizeToFitWidth = YES;
        label.backgroundColor = [UIColor redColor];
        label.textColor = [UIColor whiteColor];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 20;
        label.text = @"抢";
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        [self.contentView bringSubviewToFront:label];
        _bottonLabel = label;
    }
    return _bottonLabel;
}
#pragma mark -数据处理



@end
