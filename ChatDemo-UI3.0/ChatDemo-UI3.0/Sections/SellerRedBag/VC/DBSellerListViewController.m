//
//  DBSellerListViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/7.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBSellerListViewController.h"
#import "SellerRedBagTool.h"
#import "SellerRedBagListModel.h"
#import "AC_WaterCollectionViewLayout.h"
#import "DBhomeCollectionViewCell.h"
#import "AllManRedPacketDetailViewController.h"
#import <ImageIO/ImageIO.h>
#import "SDCycleScrollView.h"


@interface DBSellerListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,AC_WaterCollectionViewLayoutDelegate,SDCycleScrollViewDelegate>
{
    int page;
}
@property (nonatomic, strong) NSMutableArray *imageNameArray;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) SDCycleScrollView *cycleView;

@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation DBSellerListViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    page = 1;
//    [self setupUI];
//    [self loadData];
//    [self refreshData];
//    
//}
//
//- (NSMutableArray *)imageArray{
//    if (_imageArray == nil) {
//        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
//        _imageArray = array;
//    }
//    return _imageArray;
//}
//
//- (SDCycleScrollView *)cycleView {
//    if (!_cycleView) {
//        SDCycleScrollView *view = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 7 / 16)];
//        view.delegate = self;
//        view.backgroundColor = [UIColor whiteColor];
//        view.imageURLStringsGroup = self.imageArray;
//
//        _cycleView = view;
//    }
//    return _cycleView;
//}
//
//- (UICollectionView *)collectionView{
//    if (_collectionView == nil) {
//        
//        AC_WaterCollectionViewLayout *layout = [[AC_WaterCollectionViewLayout alloc] init];
//        layout.footViewHeight = 0;
////        layout.headerViewHeight = SCREEN_WIDTH * 7 / 16;
//        layout.headerViewHeight = 0;
//
//        layout.delegate = self;
//        
//        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
//        view.backgroundColor = [UIColor whiteColor];
//        view.delegate = self;
//        view.dataSource = self;
//        [self.view addSubview:view];
//        
//        
//        [view registerClass:[DBhomeCollectionViewCell class] forCellWithReuseIdentifier:@"DBhomeCollectionViewCell"];
////        [view registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:AC_UICollectionElementKindSectionHeader withReuseIdentifier:@"simpleHead"];
//        
////        [self.waterCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SimpleFootCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:AC_UICollectionElementKindSectionFooter withReuseIdentifier:@"simpleFoot"];
//        
//        _collectionView = view;
//
//    }
//    return _collectionView;
//}
//
//- (NSMutableArray *)imageNameArray{
//    if (_imageNameArray == nil) {
//        NSMutableArray *array = [NSMutableArray array];
//        _imageNameArray = array;
//    }
//    return _imageNameArray;
//}
//- (NSMutableArray *)dataSource{
//    if (_dataSource == nil) {
//        NSMutableArray *array = [NSMutableArray array];
//        _dataSource = array;
//    }
//    return _dataSource;
//}
//
//- (void)setupUI{
//    self.title = @"特约红包";
//    self.view.backgroundColor = [UIColor whiteColor];
//}
//
//- (void)loadData{
//    [self showHudInView:self.view hint:@""];
//    NSDictionary *dic = @{@"page":@"1"};
//    [SellerRedBagTool sellerRedBagWithParam:dic successBlock:^(NSArray *modelArray) {
//        [self.dataSource addObjectsFromArray:modelArray];
//        for (int i = 0; i<self.dataSource.count; i++) {
//            SellerRedBagListModel *model = self.dataSource[i];
//            [self.imageNameArray addObject: [NSString stringWithFormat:@"%@%@",www,model.img]];
//        }
//        
//        //获取轮播图片数据
//        [[NetworkManager new] getWithURL:MainImageURL success:^(id obj) {
//            if ([obj[@"status"] isEqualToNumber:@1]) {
//                for (NSDictionary *dic in obj[@"data"]) {
//                    [self.imageArray addObject:[NSString stringWithFormat:@"%@%@", www, dic[@"homeimg"]]];
//                }
//                self.cycleView.imageURLStringsGroup = self.imageArray;
//            } else {
//                [self showHint:obj[@"msg"]];
//            }
//        } fail:^(NSError *error) {
//            [self showHint:@"网络错误"];
//        }];
//        
//        [self.collectionView reloadData];
//    } errorBlock:^(NSError *error) {
//        [self showHint:@"网络错误"];
//    }];
//}
//
//- (void)refreshData{
//    [self.collectionView addPullToRefreshWithActionHandler:^{
//        self->page = 1;
//        NSDictionary *dic = @{@"page":@"1"};
//        [SellerRedBagTool sellerRedBagWithParam:dic successBlock:^(NSArray *modelArray) {
//            [self.collectionView.pullToRefreshView stopAnimating];
//            [self.dataSource removeAllObjects];
//            [self.imageNameArray removeAllObjects];
//            [self.dataSource addObjectsFromArray:modelArray];
//            for (int i = 0; i<self.dataSource.count; i++) {
//                SellerRedBagListModel *model = self.dataSource[i];
//                [self.imageNameArray addObject: [NSString stringWithFormat:@"%@%@",www,model.img]];
//            }
//            
//            [self.collectionView reloadData];
//        } errorBlock:^(NSError *error) {
//            [self showHint:@"网络错误"];
//            [self.collectionView.pullToRefreshView stopAnimating];
//
//        }];
//        
//    }];
//    
//    [self.collectionView addInfiniteScrollingWithActionHandler:^{
//        self->page ++;
//        NSString *pageStr = [NSString stringWithFormat:@"%d",self->page];
//        NSDictionary *dic = @{@"page":pageStr};
//        [SellerRedBagTool sellerRedBagWithParam:dic successBlock:^(NSArray *modelArray) {
//            [self.collectionView.infiniteScrollingView stopAnimating];
//            [self.dataSource addObjectsFromArray:modelArray];
//            for (int i = 0; i<self.dataSource.count; i++) {
//                SellerRedBagListModel *model = self.dataSource[i];
//                [self.imageNameArray addObject: [NSString stringWithFormat:@"%@%@",www,model.img]];
//            }
//            
//            [self.collectionView reloadData];
//        } errorBlock:^(NSError *error) {
//            [self showHint:@"网络错误"];
//            [self.collectionView.infiniteScrollingView stopAnimating];
//
//        }];
//
//    }];
//}
//
////设置head foot视图
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if ([kind isEqualToString:AC_UICollectionElementKindSectionHeader]) {
//        UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"simpleHead" forIndexPath:indexPath];
//        
//        head.backgroundColor = [UIColor cyanColor];
//        
//        
//        
//        [head addSubview:self.cycleView];
//        return head;
//    }
////    else if([kind isEqualToString:AC_UICollectionElementKindSectionFooter]){
////        UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"simpleFoot" forIndexPath:indexPath];
////        return foot;
////    }
//    return nil;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake(SCREEN_WIDTH ,0.000001);
//}
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return self.dataSource.count;
//}
//
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    DBhomeCollectionViewCell *cell = [DBhomeCollectionViewCell normalCollectionCellWithCollectionView:collectionView atIndexPath:indexPath];
//    SellerRedBagListModel *model = self.dataSource[indexPath.row];
////    cell.imageName = [NSString stringWithFormat:@"%@%@",www,model.img];
//
//    return cell;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(AC_WaterCollectionViewLayout *)layout heightOfItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
//{
//    CGSize size = [self getImageSizeWithURL:self.imageNameArray[indexPath.row]];
//    return size.height/size.width * itemWidth;
//    
////    return [self imageAtIndexPath:indexPath].size.height/[self imageAtIndexPath:indexPath].size.width * itemWidth;
//}
//
////- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath {
////    UIImageView *imageView = [[UIImageView alloc] init];
////    [self.view addSubview:imageView];
////    [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageNameArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType,NSURL *imageUrl){
////        CGSize size = image.size;
////        CGFloat w = size.width;
////        CGFloat H = size.height;
////    }];
////    
////    
////    
////    return [UIImage imageNamed:[self.imageNameArray objectAtIndex:indexPath.row]];
////}
//
//- (CGSize)getImageSizeWithURL:(id)URL{
//    NSURL * url = nil;
//    if ([URL isKindOfClass:[NSURL class]]) {
//        url = URL;
//    }
//    if ([URL isKindOfClass:[NSString class]]) {
//        url = [NSURL URLWithString:URL];
//    }
//    if (!URL) {
//        return CGSizeZero;
//    }
//    CGImageSourceRef imageSourceRef =     CGImageSourceCreateWithURL((CFURLRef)url, NULL);
//    CGFloat width = 0, height = 0;
//    if (imageSourceRef) {
//        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
//        if (imageProperties != NULL) {
//            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
//            if (widthNumberRef != NULL) {
//                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
//            }
//            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
//            if (heightNumberRef != NULL) {
//                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
//            }
//            CFRelease(imageProperties);
//        }
//        CFRelease(imageSourceRef);
//    }
//    return CGSizeMake(width, height);
//}
//
//
//- (void)moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
//{
//    if(sourceIndexPath.row != destinationIndexPath.row){
//        NSString *value = self.imageNameArray[sourceIndexPath.row];
//        [self.imageNameArray removeObjectAtIndex:sourceIndexPath.row];
//        [self.imageNameArray insertObject:value atIndex:destinationIndexPath.row];
//        NSLog(@"from:%ld      to:%ld", sourceIndexPath.row, destinationIndexPath.row);
//    }
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    AllManRedPacketDetailViewController *vc = [[AllManRedPacketDetailViewController alloc] init];
//    vc.sellerRedBagModel = self.dataSource[indexPath.row];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
//    
//}
//
//#pragma mark - SDCycleScrollViewDelegate
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
//    NSLog(@"%ld", index);
//}


@end
