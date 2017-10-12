//
//  DBStoreCollectionViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/8/22.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBStoreCollectionViewCell.h"

@implementation DBStoreCollectionViewCell

+ (instancetype)normalCollectionCellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *className = NSStringFromClass([self class]);
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:className];
    DBStoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:className forIndexPath:indexPath];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=[UIColor whiteColor];
    
    
    [cell iconimageView];
    [cell nameLabel];
    [cell moneyLabel];
    [cell leftLineView];
    [cell rightLineView];
    [cell bottomLineView];
    
    return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    
    [_leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.width.mas_equalTo(@(0.25));
    }];
    
    [_rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(@(0.25));
    }];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(@(0.5));
    }];
    
    [_iconimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.nameLabel.mas_top).offset(-10);
        make.left.equalTo(self.leftLineView.mas_right).offset(10);
        make.right.equalTo(self.rightLineView.mas_left).offset(-10);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.moneyLabel.mas_top);
        make.left.equalTo(self.leftLineView.mas_right).offset(10);
        make.right.equalTo(self.rightLineView.mas_left).offset(-10);
        make.height.mas_equalTo(@(25));
        
    }];
    
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomLineView.mas_top);
        make.left.equalTo(self.leftLineView.mas_right).offset(10);
        make.right.equalTo(self.rightLineView.mas_left).offset(-10);
        make.height.mas_equalTo(@(24.5));
    }];

    [super updateConstraints];
}

#pragma mark - 懒加载视图
-(UIImageView *)iconimageView{
    if (_iconimageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds=YES;
        imgView.backgroundColor = [UIColor redColor];
        imgView.layer.masksToBounds = YES;
        imgView.layer.cornerRadius = 30;
        imgView.image = [UIImage imageNamed:@"aiqianglogo"];
        [self.contentView addSubview:imgView];
        _iconimageView = imgView;
    }
    return _iconimageView;
}
-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor=[UIColor blackColor];
        titleLabel.font = DBMaxFont;
        titleLabel.text = @"优酷月度黄金会员";
        [self.contentView addSubview:titleLabel];
        _nameLabel= titleLabel;
    }
    return _nameLabel;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.font = DBMidFont;
        label.textColor = [UIColor redColor];
        label.text = @"积分 500";
        [self.contentView addSubview:label];
        _moneyLabel = label;
    }
    return _moneyLabel;
}

- (UIView *)leftLineView{
    if (_leftLineView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ColorTableViewBg;
        [self.contentView addSubview:view];
        _leftLineView = view;
    }
    return _leftLineView;
}
- (UIView *)rightLineView{
    if (_rightLineView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ColorTableViewBg;
        [self.contentView addSubview:view];

        _rightLineView = view;
    }
    return _rightLineView;
}
- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ColorTableViewBg;
        [self.contentView addSubview:view];

        _bottomLineView = view;
    }
    return _bottomLineView;
}

#pragma mark -数据处理
- (void)setModel:(DBStoreListModel *)model
{
    _model = model;
    
    [self.iconimageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",www,model.img]]];
    self.nameLabel.text = model.name;
    self.moneyLabel.text = model.amount;
    
}


@end
