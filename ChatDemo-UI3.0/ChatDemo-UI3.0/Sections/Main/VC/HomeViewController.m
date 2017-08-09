//
//  HomeViewController.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/9.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "MerchantRedPacket.h"
#import "ThreeButtonView.h"
#import "MerchantDetailViewController.h"
#import "HomeFirstTableViewCell.h"
#import "AllRedPacketTableViewCell.h"
#import "AllManRedPacketListModel.h"
#import "MainTool.h"
#import "SellerRedBagListModel.h"
#import "SellerListViewController.h"
#import "AllManRedPacketDetailViewController.h"
#import "RedBagChainViewController.h"
#import "OtherPersonInfoViewController.h"
#import "StealRedBagView.h"
#import "AllManRedPacketTool.h"
#import "SellerListViewController.h"
#import "DBCycleModel.h"
#import "DBWebViewViewController.h"

@interface HomeViewController ()< SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    CGFloat _cellHeight;
}
@property (nonatomic, weak) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *imageArray;//滚动视图的imageArray；
@property (nonatomic, strong) NSMutableArray *cycleModelArray;
@property (nonatomic, strong) NSMutableArray *allManRedBagArray;
@property (nonatomic, strong) NSMutableArray *sellerRedBagArray;

@property (strong, nonatomic) SDCycleScrollView *cycleView;
@property (strong, nonatomic) ThreeButtonView *threeView;

@property (nonatomic, strong) NSMutableArray *sellerImageArray;
@property (nonatomic, weak) StealRedBagView *stealView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loaddata];
    
}

- (NSMutableArray *)cycleModelArray{
    if (_cycleModelArray == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _cycleModelArray = array;
    }
    return _cycleModelArray;
}
- (StealRedBagView *)stealView{
    if (_stealView == nil) {
        StealRedBagView *view = [[StealRedBagView alloc] init];
        _stealView = view;
    }
    return _stealView;
}

- (NSMutableArray *)sellerImageArray{
    if (_sellerImageArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        _sellerImageArray = array;
    }
    return _sellerImageArray;
}

- (NSMutableArray *)allManRedBagArray{
    if (_allManRedBagArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        _allManRedBagArray = array;
    }
    return _allManRedBagArray;
}

- (NSMutableArray *)sellerRedBagArray{
    if (_sellerRedBagArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        _sellerRedBagArray = array;
    }
    return _sellerRedBagArray;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        self.imageArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _imageArray;
}

- (SDCycleScrollView *)cycleView {
    if (!_cycleView) {
        self.cycleView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH + 12) * 7/16 )];
        _cycleView.delegate = self;
    }
    return _cycleView;
}

- (ThreeButtonView *)threeView {
    if (!_threeView) {
        __weak __typeof(self) weakSelf = self;
        self.threeView = [[[NSBundle mainBundle] loadNibNamed:@"ThreeButtonView" owner:nil options:nil] objectAtIndex:0];
        
        [_threeView setDidClickButton:^(NSInteger tag) {
            if (tag == 1) {
                NSLog(@"商家红包");
                SellerListViewController *vc = [[SellerListViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            } else if (tag == 2) {
                NSLog(@"红包接龙");
                RedBagChainViewController *vc = [[RedBagChainViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];

            } else if (tag == 3) {
                NSLog(@"全民红包");
                [weakSelf performSegueWithIdentifier:@"all" sender:nil];
            }
        }];
        _threeView.frame = CGRectMake(0, (SCREEN_WIDTH +12)* 7/16, SCREEN_WIDTH, 80);
    }
    return _threeView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40)];
        tableView.backgroundColor = ColorTableViewBg;
        tableView.delegate = self;
        tableView.dataSource = self;
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH + 12)*7/16 + 80);
        view.userInteractionEnabled = YES;
        [view addSubview:self.cycleView];
        [view addSubview:self.threeView];
        tableView.tableHeaderView = view;
        tableView.tableFooterView = [[UIView alloc] init];
        
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
            [self loaddata];
        }];
        
        
        [self.view insertSubview:tableView atIndex:1];
        _tableView = tableView;
    }
    return _tableView ;
}


- (void)loaddata{
    [self showHudInView:self.view hint:@"加载数据..."];
    
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
        } else {
            [self showHint:obj[@"msg"]];
        }
    } fail:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
    
    [MainTool mainRedBagListWithParam:nil successBlock:^(NSArray *modelArray) {
        [self hideHud];
        [self endRefresh];
        self.sellerRedBagArray = modelArray[0];
        self.allManRedBagArray = modelArray[1];
        for (SellerRedBagListModel *model in modelArray[0]){
            [self.sellerImageArray addObject:[NSString stringWithFormat:@"%@%@",www,model.img]];
        }
        [self.tableView reloadData];
    } errorBlock:^(NSError *error) {
        [self hideHud];
        [self endRefresh];

        [self showHint:@"网络错误"];
    }];
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.sellerRedBagArray.count == 0) {
            return 0;
        }else{
            return 1;

        }
    }else{
        return self.allManRedBagArray.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _cellHeight;
    }else{
        return 80;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        HomeFirstTableViewCell *cell = [HomeFirstTableViewCell normalTableViewCellWithTableView:tableView];
        cell.imageNameArray = self.sellerImageArray;
        [cell setCollectionViewClickedBlock:^(NSInteger row){
            AllManRedPacketDetailViewController *vc = [[AllManRedPacketDetailViewController alloc] init];
            vc.sellerRedBagModel = self.sellerRedBagArray[row];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];

            
        }];
        typeof(cell) weakcell = cell;
        [cell.layout setCollectionViewHeightBlock:^(CGFloat cellHeight){
            self->_cellHeight = cellHeight;
            weakcell.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, cellHeight);
            NSLog(@"%f",weakcell.collectionView.frame.size.height);
            [self.tableView reloadData];
        }];
        return cell;

    }else{
        
        AllRedPacketTableViewCell *cell = (AllRedPacketTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell= (AllRedPacketTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"AllRedPacketTableViewCell" owner:self options:nil]  lastObject];
        }
        AllManRedPacketListModel *model = self.allManRedBagArray[indexPath.row];

        cell.model = model;
        [cell setIconImageViewBlock:^{
           
            OtherPersonInfoViewController *vc = [[OtherPersonInfoViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.uid = model.uid;
            [self.navigationController pushViewController:vc animated:YES];

        }];
        
        [cell setRobRedBagBlock:^{
//            NSDictionary *param = @{@"uid":User_ID,@"rid":model.ID};
//            [self stealAllManRedBagWith:param andModel:model];
            AllManRedPacketDetailViewController *vc = [[AllManRedPacketDetailViewController alloc] init];
            vc.allManmodel = self.allManRedBagArray[indexPath.row];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];

        }];
        return cell;
    }
}

- (void)stealAllManRedBagWith:(NSDictionary *)param andModel:(AllManRedPacketListModel *)model{
    [AllManRedPacketTool stealAllManRedBagWithParam:param successBlock:^(StealRedBagResult *result) {
        if ([result.status intValue] == 1) {
            self.stealView.redBagMoney = result.monsyStr;
            self.stealView.type = 3;
            [self.stealView configViewWithStatus:1 Moeny:result.monsyStr andNickName:model.nickname andImageName:[NSString stringWithFormat:@"%@%@",www,model.headimg]];
            
        }else if ([result.status intValue] == 5){
            [self.stealView configViewWithStatus:0 Moeny:nil andNickName:nil andImageName:[NSString stringWithFormat:@"%@%@",www,model.headimg]];
        }else{
            [self showHint:result.msg];
        }
    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        AllManRedPacketDetailViewController *vc = [[AllManRedPacketDetailViewController alloc] init];
        vc.allManmodel = self.allManRedBagArray[indexPath.row];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}


//HeaderInSection  &&  FooterInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.sellerRedBagArray.count == 0) {
            return 0.000001;
        }else{
            return 10;
        }
    }else{
        return 0.0000001;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld", index);
    DBCycleModel *model = self.cycleModelArray[index];
    if ([model.act intValue] == 1) {
        DBWebViewViewController *vc = [[DBWebViewViewController alloc] init];
        vc.url = model.content;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([model.act intValue] == 2) {
        AllManRedPacketDetailViewController *vc = [[AllManRedPacketDetailViewController alloc] init];
        vc.sellerID = model.ID;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - segue传值

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"todetail"]) {
        MerchantDetailViewController *vc = [segue destinationViewController];
        vc.redPacketID = sender;
    }
    
}


@end
