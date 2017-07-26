//
//  SellerListViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/20.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "SellerListViewController.h"
#import "SellerRedBagTool.h"
#import "SellerRedBagListModel.h"
#import "DBhomeCollectionViewCell.h"
#import "AllManRedPacketDetailViewController.h"
#import "SDCycleScrollView.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"
#import "ItemModel.h"


#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"

@interface SellerListViewController ()<UICollectionViewDataSource,SDCycleScrollViewDelegate,CHTCollectionViewDelegateWaterfallLayout>
{
    int page;
}
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, weak) SDCycleScrollView *cycleView;

@end

@implementation SellerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 1;

    [self setupUI];
    [self loadData];
    
}

- (NSMutableArray *)itemModelArray{
    if (_itemModelArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        _itemModelArray = array;
    }
    return _itemModelArray;
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        NSMutableArray *array = [NSMutableArray array];
        _dataSource = array;
    }
    return _dataSource;
}

- (SDCycleScrollView *)cycleView {
    if (!_cycleView) {
        SDCycleScrollView *view = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 7 / 16)];
        view.delegate = self;
        _cycleView = view;
    }
    return _cycleView;
}

-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.headerHeight = 0;
        layout.footerHeight = 0;
//        layout.minimumColumnSpacing = 20;
//        layout.minimumInteritemSpacing = 20;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layout];

        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self->page = 1;
            [self loadData];
        }];
        
        collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self->page ++;
            [self loadData];
        }];
        
        //注册cell
        [collectionView registerClass:[DBhomeCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
        
        //注册头视图
        [collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
                forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                       withReuseIdentifier:HEADER_IDENTIFIER];
        //注册脚视图
        [collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                   withReuseIdentifier:FOOTER_IDENTIFIER];
        [self.view addSubview:collectionView];
        _collectionView = collectionView;
        
    }
    return _collectionView;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

- (void)setupUI{
    self.title = @"特约红包";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loadData{
    NSDictionary *dic = @{@"page":[NSString stringWithFormat:@"%d",page]};
    [SellerRedBagTool sellerRedBagWithParam:dic successBlock:^(NSArray *modelArray) {
        
        [self endRefresh];
        if (self->page == 1) {
            [self.dataSource removeAllObjects];
        }
        
        [self.dataSource addObjectsFromArray:modelArray];
        for (int i = 0; i<self.dataSource.count; i++) {
            SellerRedBagListModel *listModel = self.dataSource[i];
            ItemModel *model = [ItemModel new];
            model.imageUrl = [NSString stringWithFormat:@"%@%@",www,listModel.img];
            
            [self.itemModelArray addObject:model];
        }
        [self.collectionView reloadData];
    } errorBlock:^(NSError *error) {
        [self endRefresh];

        [self showHint:@"网络错误"];
    }];
}

- (void)endRefresh{
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView.mj_header endRefreshing];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DBhomeCollectionViewCell *cell = [DBhomeCollectionViewCell normalCollectionCellWithCollectionView:collectionView atIndexPath:indexPath];
    ItemModel *model = self.itemModelArray[indexPath.row];
    
    NSString *imgUrlString = model.imageUrl;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrlString] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            if (!CGSizeEqualToSize(model.imageSize, image.size)) {
                model.imageSize = image.size;
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }
        }
    }];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        
        CHTCollectionViewWaterfallHeader * reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEADER_IDENTIFIER forIndexPath:indexPath];
        
        return reusableView;
        
    }
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        
        CHTCollectionViewWaterfallFooter *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FOOTER_IDENTIFIER forIndexPath:indexPath];
        return reusableView;
        
        
    }
    return nil;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AllManRedPacketDetailViewController *vc = [[AllManRedPacketDetailViewController alloc] init];
    vc.sellerRedBagModel = self.dataSource[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ItemModel *model = [self.itemModelArray objectAtIndex:indexPath.row];
    if (!CGSizeEqualToSize(model.imageSize, CGSizeZero)) {
        return model.imageSize;
    }
    return CGSizeMake((SCREEN_WIDTH - 30)/2, 150);

}

@end
