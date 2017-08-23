//
//  DBStoreCollectionViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/8/22.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBStoreCollectionViewCell : UICollectionViewCell

//@property (nonatomic, strong) <#ModelClass#> *model;

@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *moneyLabel;
@property (nonatomic, weak) UIView *leftLineView;
@property (nonatomic, weak) UIView *rightLineView;
@property (nonatomic, weak) UIView *bottomLineView;

+ (instancetype)normalCollectionCellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end
