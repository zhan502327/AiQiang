//
//  MyDiscoverViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MyDiscoverViewController.h"
#import "MyDiscoverTool.h"
#import "DiscoverCell.h"
#import "DiscoverDetailTableViewCell.h"
#import "CircleDetailViewController.h"
#import "DiscoverTool.h"
#import "DBShareView.h"
#import "MyReplyViewController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface MyDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    int page;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, weak) UIView *blackview;
@property (nonatomic, weak) DBShareView *shareView;
@property (nonatomic, strong) NSMutableArray *imageArray;



@end

@implementation MyDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    [self setupUI];
    [self initData];
    [self loadData];

}

- (UIView *)blackview{
    if (_blackview == nil) {
        UIView *view = [[UIView alloc] init];
        view.userInteractionEnabled = YES;
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.7;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackViwClicked)];
        [view addGestureRecognizer:tap];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        _blackview = view;
    }
    return _blackview;
}
- (DBShareView *)shareView{
    if (_shareView == nil) {
        DBShareView *shareViw = [DBShareView viewWithFrame:CGRectMake(0, SCREEN_HEIGHT - 120, SCREEN_HEIGHT, 120)];
        [[UIApplication sharedApplication].keyWindow addSubview:shareViw];
        _shareView = shareViw;
    }
    return _shareView;
}


- (void)blackViwClicked{
    [self.view endEditing:YES];
    [self.blackview removeFromSuperview];
    [self.shareView removeFromSuperview];
}

- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的动态";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"与我相关" style:UIBarButtonItemStyleDone target:self action:@selector(itemClicked)];
    self.navigationItem.rightBarButtonItem = item;

}

- (void)itemClicked{
    MyReplyViewController *vc = [[MyReplyViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initData{
    page = 1;
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    self.imageArray = [NSMutableArray arrayWithCapacity:0];
}

- (void)loadData{
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    NSDictionary *dic = @{@"uid":User_ID,@"page":pageStr};
   
    [MyDiscoverTool myDiscoverWithSuccessBlockWithPram:dic successBlock:^(MyDiscoverListResult *result) {
        [self endFresh];
        if (self->page == 1) {
            [self.dataSource removeAllObjects];
        }
        
        [self.dataSource addObjectsFromArray:result.modelArray];
        
        if (self.dataSource.count == 0) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake(100, 200, SCREEN_WIDTH- 200,SCREEN_WIDTH- 200 );
            imageView.image = [UIImage imageNamed:@"wushuju"];
            [self.view addSubview:imageView];
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame), SCREEN_WIDTH, 50);
            label.text = @"暂无数据";
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:18];
            [self.view addSubview:label];
        }else{
            [self.tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
        [self endFresh];

        [self showHint:@"网络错误"];
    }];
}

- (void)endFresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        tableView.backgroundColor=[UIColor whiteColor];
        tableView.tableFooterView = [[UIView alloc] init];
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.dataSource=self;
        tableView.delegate=self;
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self->page = 1;
            [self loadData];
            
        }];
        
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self->page ++;
            [self loadData];
        }];
        
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Discover *model = self.dataSource[indexPath.row];


    CGFloat imageHeight = 0;
    if (model.img.count == 0) {
        imageHeight = 10;
    }else{
        
        if (model.img.count == 1) {
            imageHeight = 200;
        }else if (model.img.count > 3){
            imageHeight = 200;
        }else{
            imageHeight = 99;
        }
    }
    return 150 + imageHeight + model.labelHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Discover *model = self.dataSource[indexPath.row];
    
    DiscoverDetailTableViewCell *cell = [DiscoverDetailTableViewCell normalTableViewCellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;    
  
    
    typeof(cell) weakcell = cell;
    
    [cell setImageArrayBlcock:^(NSMutableArray *imageArray){
       
        self.imageArray = imageArray;
    }];
    
    
    //图片
    [cell.detailView setContentImageViewTapBlock:^(NSInteger index, UIImageView *view, NSMutableArray *imageViewsArray){
        
        
        //1.创建图片浏览器
        MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
        
        //2.告诉图片浏览器显示所有的图片
        NSMutableArray *photos = [NSMutableArray array];
        for (int i = 0 ; i < imageViewsArray.count; i++) {
            //传递数据给浏览器
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.url = [NSURL URLWithString:model.img[i][@"url"]];
            photo.srcImageView = imageViewsArray[i]; //设置来源哪一个UIImageView
            [photos addObject:photo];
        }
        brower.photos = photos;
        
        //3.设置默认显示的图片索引
        brower.currentPhotoIndex = index;
        
        //4.显示浏览器  
        [brower show];  
    }];
    
    //点赞block实现
    [cell setZanButtonClickedBlock:^{
        NSLog(@"点赞button被点击");
        
        NSString *action;
        if ([model.is_liked isEqualToString:@"1"]) {
            action = @"unliked";
            weakcell.detailView.zanButton.selected = NO;
            
        }else{
            action = @"liked";
            weakcell.detailView.zanButton.selected = YES;
        }
        NSDictionary *param = @{@"uid":User_ID, @"cid":model.discoverID ,@"act":action};
        [DiscoverTool circleSetLikedWithParam:param successBlock:^(NSString *msg, NSNumber *status) {
            [self showHint:msg];
            if ([status intValue] == 1) {
                [self.tableView.mj_header beginRefreshing];
            }
        } errorBlock:^(NSError *error) {
            [self showHint:@"网络错误"];
        }];
        
    }];
    //评论block实现
    [cell setPinglunButtonClickedBlock:^{
        NSLog(@"评论button被点击");
        Discover *message=self.dataSource[indexPath.row];
        
        CircleDetailViewController *vc = [[CircleDetailViewController alloc] init];
        
        vc.discoverModel = message;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    //分享block实现
    [cell setShareButtonClickedBlock:^{
        NSLog(@"分享button被点击");
        [self blackview];
        [self shareView];
        
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Discover *message=self.dataSource[indexPath.row];
    CircleDetailViewController *vc = [[CircleDetailViewController alloc] init];
    
    vc.discoverModel = message;
    [vc setDeleteDiscoverReloadDataBlock:^{
        [self.tableView.mj_header beginRefreshing];
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
