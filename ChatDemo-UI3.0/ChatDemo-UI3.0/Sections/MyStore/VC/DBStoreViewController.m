//
//  DBStoreViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/8/22.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBStoreViewController.h"
#import "DBStoreCollectionViewCell.h"
#import "DBCycleModel.h"
#import "DBStoreBottomVIew.h"
#import "DBStoreHeaderCollectionReusableView.h"

@interface DBStoreViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic, weak) UICollectionView *collcetionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) SDCycleScrollView *cycleView;
@property (nonatomic, strong) DBStoreBottomVIew *bottomView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *cycleModelArray;
@end

@implementation DBStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
    
    
    // 注册collectionViewcell:WWCollectionViewCell是我自定义的cell的类型
//    [self.collcetionView registerClass:[WWCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    // 注册collectionView头部的view，需要注意的是这里的view需要继承自UICollectionReusableView
//    [self.collcetionView registerNib:[UINib nibWithNibName:@"DBStoreCollectionViewHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}

- (DBStoreBottomVIew *)bottomView{
    if (_bottomView == nil) {
        DBStoreBottomVIew *view = [DBStoreBottomVIew viewWithFrame:CGRectMake(0, CGRectGetMaxY(self.cycleView.frame), SCREEN_WIDTH, 50)];
        _bottomView = view;
    }
    return _bottomView;
}

- (NSMutableArray *)cycleModelArray{
    if (_cycleModelArray == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _cycleModelArray = array;
    }
    return _cycleModelArray;
}

- (void)loadData{
    //获取轮播图片数据
    [[NetworkManager new] getWithURL:MainImageURL success:^(id obj) {
        [self.imageArray removeAllObjects];
        [self.cycleModelArray removeAllObjects];
        if ([obj[@"status"] isEqualToNumber:@1]) {
            NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *dic in obj[@"data"]) {
                DBCycleModel *model = [[DBCycleModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [array addObject:model];
                [self.imageArray addObject:[NSString stringWithFormat:@"%@%@", www, dic[@"homeimg"]]];
            }
            
            [self.cycleModelArray addObjectsFromArray:array];
            self.cycleView.imageURLStringsGroup = self.imageArray;
            [self.collcetionView reloadData];
        } else {
            [self showHint:obj[@"msg"]];
        }
    } fail:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

- (void)configUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"积分商城";
    
}

- (SDCycleScrollView *)cycleView {
    if (!_cycleView) {
        self.cycleView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH + 12) * 7/16 )];
        _cycleView.delegate = self;
    }
    return _cycleView;
}


- (NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        NSMutableArray *array =[NSMutableArray arrayWithCapacity:0];
        
        _imageArray = array;
    }
    return _imageArray;
}

-(UICollectionView *)collcetionView{
    if (_collcetionView == nil) {
        UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
        layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layOut];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollEnabled  = YES;
        layOut.minimumInteritemSpacing = 0;
        layOut.minimumLineSpacing = 0;//这个控制每个item的间隔
        collectionView.backgroundColor =ColorTableViewBg;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[DBStoreHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        [self.view addSubview:collectionView];
        _collcetionView = collectionView;
        
    }
    return _collcetionView;
}

#pragma mark - collectionView delegate and collectionView dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 22;
}
//告知每个块item应该有多大
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((SCREEN_WIDTH)/2 , (SCREEN_WIDTH)/2 + 50);
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DBStoreCollectionViewCell *cell = [DBStoreCollectionViewCell normalCollectionCellWithCollectionView:collectionView atIndexPath:indexPath];
    return cell;
}



//设置偏移
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 0, 0);//这个控制collectionView距离其父类的上、左、下、右边距
}
//点击调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

/** 头部/底部*/
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // 头部
        DBStoreHeaderCollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"header"   forIndexPath:indexPath];
        
        [view addSubview:self.cycleView];
        [view addSubview:self.bottomView];
        return view;
        
    }else {
   
        return  nil;
    }
}

/** 头部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH + 12) * 7/16 + 50);
}

@end
