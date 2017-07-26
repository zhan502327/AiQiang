//
//  DBhomeCollectionViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/18.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MerchantRedPacket.h"

@interface DBhomeCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *bottonLabel;
+ (instancetype)normalCollectionCellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;


@end
