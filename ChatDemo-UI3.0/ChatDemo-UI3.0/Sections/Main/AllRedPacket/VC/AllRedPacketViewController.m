//
//  AllRedPacketViewController.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/22.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "AllRedPacketViewController.h"
#import "AllRedPacketTableViewCell.h"
#import "AllRedPacketHeaderView.h"
#import "AllManRedPacketTool.h"
#import "AllManRedPacketTool.h"
#import "AllManRedPacketDetailViewController.h"
#import "PublishRedBagViewController.h"
#import "ChooseSexView.h"
#import "OtherPersonInfoViewController.h"
#import "StealRedBagView.h"


@interface AllRedPacketViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    int page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) SDCycleScrollView *cycleView;

@property (nonatomic, strong) NSMutableArray *maxDataSource;
@property (nonatomic, strong) NSMutableArray *minDataSource;

@property (nonatomic, weak) UIView *sexBgView;
@property (nonatomic, weak) ChooseSexView *contentView;

@property (nonatomic, copy) NSString *sexStr;
@property (nonatomic, strong) NSMutableArray *imageArray;//轮播图

@property (nonatomic, weak) StealRedBagView *stealView;
@end

@implementation AllRedPacketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self initData];
    [self loadData];
    [self setupTableView];
    [self configSex];
}

- (NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        _imageArray = array;
    }
    return _imageArray;
}
- (UIView *)sexBgView{
    if (_sexBgView == nil) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT + 64);
        view.userInteractionEnabled = YES;
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.4;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        _sexBgView = view;
    }
    return _sexBgView;
}

- (StealRedBagView *)stealView{
    if (_stealView == nil) {
        StealRedBagView *view = [[StealRedBagView alloc] init];
        _stealView = view;
    }
    return _stealView;
}

- (ChooseSexView *)contentView{
    if (_contentView == nil) {

        ChooseSexView *view = [ChooseSexView viewWithFrame:CGRectMake(30, SCREEN_HEIGHT/2 - 150, SCREEN_WIDTH - 60, 300)];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        _contentView = view;
    }
    return _contentView;
}

- (void)configSex{
    
    if ([User_Sex isEqualToString:@"0"]) {
        
        [self sexBgView];

        [self.contentView setManButtonBlock:^{
            self.sexStr = @"1";
            self.contentView.manButton.selected = YES;
            self.contentView.womanButton.selected = NO;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"1" forKey:@"sex"];

        }];
        
        [self.contentView setWomanButtonBlock:^{
            self.sexStr = @"2";
            self.contentView.manButton.selected = NO;
            self.contentView.womanButton.selected = YES;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"2" forKey:@"sex"];

        }];
        
        [self.contentView setLeftButtonBlock:^{
            [self.contentView removeFromSuperview];
            [self.sexBgView removeFromSuperview];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [self.contentView setRightButtonBlock:^{
            
            [self loadConfigUserSex];
        }];
        
    }
}

- (void)loadConfigUserSex{
    if ([self.sexStr isEqualToString:@"0"]) {
        [self showHint:@"请先选择性别"];
    }else{
        NSDictionary *dic = @{@"uid":User_ID,@"sex":self.sexStr};
        [AllManRedPacketTool configSexWithParam:dic successBlock:^(NSString *msg, NSNumber *num) {
            
            [self showHint:msg];
            if ([num isEqualToNumber:@1]) {
                [self.contentView removeFromSuperview];
                [self.sexBgView removeFromSuperview];
            }
            
        } errorBlock:^(NSError *error) {
            if (error) {
                [self showHint:@"网络错误"];
            }
        }];
    }

}
- (void)setupNav{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发红包" style:UIBarButtonItemStylePlain target:self action:@selector(sendRedBag)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)sendRedBag{
    PublishRedBagViewController *vc = [[PublishRedBagViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupTableView{
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"AllRedPacketTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = ColorTableViewBg;
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page = 1;
        [self loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self->page ++;
        [self loadData];
    }];
}

- (void)initData{
    self.maxDataSource = [NSMutableArray arrayWithCapacity:0];
    self.minDataSource = [NSMutableArray arrayWithCapacity:0];
    page = 1;
    self.sexStr = @"0";
}

- (void)loadData{
    
    //获取轮播图片数据
    [[NetworkManager new] getWithURL:MainImageURL success:^(id obj) {
        [self.imageArray removeAllObjects];
        if ([obj[@"status"] isEqualToNumber:@1]) {
            for (NSDictionary *dic in obj[@"data"]) {
                [self.imageArray addObject:[NSString stringWithFormat:@"%@%@", www, dic[@"homeimg"]]];
            }
            self.cycleView.imageURLStringsGroup = self.imageArray;
        } else {
            [self showHint:obj[@"msg"]];
        }
    } fail:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];

    
    NSDictionary *param = @{@"uid":User_ID,@"page":[NSString stringWithFormat:@"%d",page]};
    
    [AllManRedPacketTool getAllManRedPacketListWithSuccessBlockWithPram:param successBlock:^(NSMutableArray *maxarray, NSMutableArray *minArray, AllManRedPacketResult *result) {
        
        [self endRefresh];
        if (self->page == 1) {
            [self.maxDataSource removeAllObjects];
            [self.minDataSource removeAllObjects];
        }
        
        
        [self.maxDataSource addObjectsFromArray:maxarray];
        [self.minDataSource addObjectsFromArray:minArray];
        [self.tableView reloadData];
        [self setTableViewHeader];
    } errorBlock:^(NSError *error) {
        [self endRefresh];

        [self showHint:@"网络错误"];
    }];

}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (SDCycleScrollView *)cycleView {
    if (!_cycleView) {
        SDCycleScrollView *view = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 7 / 16)];
        view.delegate = self;
        _cycleView = view;
    }
    return _cycleView;
}


- (void)setTableViewHeader {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 7 / 16 + 170)];
    [view addSubview:self.cycleView];
    AllRedPacketHeaderView *header = [[NSBundle mainBundle] loadNibNamed:@"AllRedPacketHeaderView" owner:nil options:nil][0];
    header.frame = CGRectMake(0, SCREEN_WIDTH * 7 / 16, SCREEN_WIDTH, 170);
    header.modelArray = self.maxDataSource;
    [header setDidClick:^(NSInteger tag) {
        NSLog(@"%ld", tag);
        AllManRedPacketDetailViewController *vc = [[AllManRedPacketDetailViewController alloc] init];
        vc.allManmodel = self.maxDataSource[tag - 5000];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [view addSubview:header];
    self.tableView.tableHeaderView = view;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.minDataSource.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AllRedPacketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AllManRedPacketListModel *model = self.minDataSource[indexPath.row];
    cell.model = model;
    [cell setIconImageViewBlock:^{
        OtherPersonInfoViewController *vc = [[OtherPersonInfoViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.uid = model.uid;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [cell setRobRedBagBlock:^{
//        NSDictionary *param = @{@"uid":User_ID,@"rid":model.ID};
//        [self stealAllManRedBagWith:param andModel:model];
        AllManRedPacketDetailViewController *vc = [[AllManRedPacketDetailViewController alloc] init];
        vc.allManmodel = self.minDataSource[indexPath.row];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    return cell;
}

- (void)stealAllManRedBagWith:(NSDictionary *)param andModel:(AllManRedPacketListModel *)model{
    [AllManRedPacketTool stealAllManRedBagWithParam:param successBlock:^(StealRedBagResult *result) {
        if ([result.status intValue] == 1) {
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

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AllManRedPacketDetailViewController *vc = [[AllManRedPacketDetailViewController alloc] init];
    vc.allManmodel = self.minDataSource[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld", index);
}

@end
