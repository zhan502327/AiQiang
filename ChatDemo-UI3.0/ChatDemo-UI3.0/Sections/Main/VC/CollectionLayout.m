//
//  CollectionLayout.m
//  Waterfalls
//
//  Created by 郭艾超 on 16/9/26.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "CollectionLayout.h"
@interface CollectionLayout()
{
    CGFloat maxHeight;
}
@property (assign, nonatomic) NSInteger columnNum;
@property (assign, nonatomic) CGFloat rowSpacing;
@property (assign, nonatomic) CGFloat columnSpacing;
//@property (assign, nonatomic) UIEdgeInsets sectionInset;
@property (strong, nonatomic) NSMutableDictionary * everyColumnHDict;
@property (strong, nonatomic) NSMutableArray * attributeArr;

@end

@implementation CollectionLayout
- (instancetype)initOptionWithColumnNum:(NSInteger)columnNum rowSpacing:(CGFloat)rowSpacing columnSpacing:(CGFloat)columnSpacing sectionInset:(UIEdgeInsets)sectionInset {
    if (self = [super init]) {
        maxHeight = 0;
        _columnNum = columnNum;
        _rowSpacing = rowSpacing;
        _columnSpacing = columnSpacing;
        self.sectionInset = sectionInset;
        _everyColumnHDict = [NSMutableDictionary dictionary];
        _attributeArr = [NSMutableArray array];
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;

    
}

//返回每张图片的高度
- (CGFloat)calculateImageHeightWithCount:(NSInteger)i withWidth:(CGFloat)width {
    
    NSString * imageName = _dataArr[i];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]];
    UIImage *image = [UIImage imageWithData:data];
    NSLog(@"w = %f,h = %f",image.size.width,image.size.height);

    
    CGFloat imageH = image.size.height / image.size.width * width;
    return imageH;

}

#pragma mark - 重写CollectionView方法
- (void)prepareLayout {
    [super prepareLayout];
    for (int i = 0; i < _columnNum; i++) {
        [_everyColumnHDict setObject:@(self.sectionInset.top) forKey:[NSString stringWithFormat:@"%d",i]];
    }
    
    for (int i = 0; i < _dataArr.count; i++) {
        [_attributeArr addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewLayoutAttributes * attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //计算宽度(等宽)
    CGFloat itemW = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - (_columnNum - 1) * _rowSpacing) / _columnNum;
    //返回每张图片的高度
    CGFloat itemH = [self calculateImageHeightWithCount:indexPath.row withWidth:itemW];
    
    CGRect frame = CGRectMake(0, 0, itemW, itemH);
    
    NSInteger x = 0;
    CGFloat y = 0.0f;
    for (id temKey in _everyColumnHDict) {
        CGFloat temHeight = [_everyColumnHDict[temKey] floatValue];
        if (y == 0) {
            y = temHeight;
            x = [temKey integerValue];
            continue;
        }
        
        if(y > temHeight ) {
            y = temHeight;
            x = [temKey integerValue];
        }
    }
    frame.origin = CGPointMake(self.sectionInset.left + x * (itemW + _rowSpacing), y);
    NSString * key = [NSString stringWithFormat:@"%ld",x];
    NSNumber * height = @(_columnSpacing + y + itemH);
    [_everyColumnHDict setObject:height forKey:key];

    attribute.frame = frame;
    

    CGFloat c_height = frame.origin.y + frame.size.height + 10;
    if (c_height > maxHeight) {
        maxHeight = c_height;
    }
    
    if (indexPath.row == self.dataArr.count - 1) {
        if (_collectionViewHeightBlock) {
            _collectionViewHeightBlock(maxHeight);
        }
    }
    return attribute;
}

- (CGSize)collectionViewContentSize {    
    CGFloat height = 0.0f;
    for (id key in _everyColumnHDict) {
        CGFloat temHeight = [_everyColumnHDict[key] floatValue];
        height = height > temHeight ? height : temHeight;
    }
    return CGSizeMake(self.collectionView.frame.size.width, height + self.sectionInset.bottom);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _attributeArr;
}

@end
