//
//  HomeFirstTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/18.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionLayout.h"

@interface HomeFirstTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *imageNameArray;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) CollectionLayout *layout;

@property (nonatomic, copy) void(^collectionViewClickedBlock)(NSInteger row);

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
