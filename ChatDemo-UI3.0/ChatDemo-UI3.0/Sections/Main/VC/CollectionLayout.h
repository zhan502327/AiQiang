//
//  CollectionLayout.h
//  Waterfalls
//
//  Created by 郭艾超 on 16/9/26.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionLayout : UICollectionViewFlowLayout
@property (strong, nonatomic)NSArray * dataArr;

@property (nonatomic, copy) void(^collectionViewHeightBlock)(CGFloat height);

- (instancetype)initOptionWithColumnNum:(NSInteger)columnNum rowSpacing:(CGFloat)rowSpacing columnSpacing:(CGFloat)columnSpacing sectionInset:(UIEdgeInsets)sectionInset;

- (CGFloat)calculateImageHeightWithCount:(NSInteger)i withWidth:(CGFloat)width;
@end
