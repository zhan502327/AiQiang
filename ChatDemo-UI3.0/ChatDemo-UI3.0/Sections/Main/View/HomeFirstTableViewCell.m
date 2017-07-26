//
//  HomeFirstTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/18.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "HomeFirstTableViewCell.h"
#import "DBhomeCollectionViewCell.h"

@interface HomeFirstTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation HomeFirstTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    HomeFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell collectionView];
    return cell;
}

#pragma mark - 懒加载视图

#pragma mark -数据处理


-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 500) collectionViewLayout:self.layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollEnabled  = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:collectionView];
        _collectionView = collectionView;
        
    }
    return _collectionView;
}



- (CollectionLayout *)layout{
    if (_layout == nil) {
        CollectionLayout *layout =  [[CollectionLayout alloc] initOptionWithColumnNum:2 rowSpacing:10 columnSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
        layout.dataArr = self.imageNameArray;
        [layout setCollectionViewHeightBlock:^(CGFloat collectionHeight){
            self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, collectionHeight);
        }];
        _layout = layout;
    }
    return _layout;
}

- (void)setImageNameArray:(NSArray *)imageNameArray{
    _imageNameArray = imageNameArray;
    
    self.layout.dataArr = imageNameArray;
}


#pragma mark - collectionView delegate and collectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNameArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DBhomeCollectionViewCell *cell = [DBhomeCollectionViewCell normalCollectionCellWithCollectionView:collectionView atIndexPath:indexPath];
    NSString * imageName = self.imageNameArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_collectionViewClickedBlock) {
        _collectionViewClickedBlock(indexPath.row);
    }
    
    
}


@end
