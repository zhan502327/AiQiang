//
//  MoneyMangerViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/15.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MoneyMangerViewController.h"
#import "MoneyMangerTableViewCell.h"
#import "MoneyMangerHeaderTableViewCell.h"
#import "TiXianViewController.h"
#import "ChongZhiViewController.h"

#define PayTypeZhiFuBao @"zhiFuBao"
#define PayTypeWehat @"weChat"

#define TiXianTypeZhiFuBao @"zhiFuBao"
#define TiXianTypeBankCard @"bank"

@interface MoneyMangerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) NSString *payType;
@property (nonatomic, copy) NSString *tiXianType;
@end

@implementation MoneyMangerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupUI];
    [self tableView];
    
    
}
- (void)initData{
    self.payType = PayTypeWehat;
    self.tiXianType = TiXianTypeZhiFuBao;
}

- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(nextButtonClick)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)nextButtonClick{
    if (self.indexPath == nil) {
        if (self.type == 1) {
            NSLog(@"充值微信");
            ChongZhiViewController *vc = [[ChongZhiViewController alloc] init];
            vc.type = 1;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            NSLog(@"提现支付宝");
            TiXianViewController *vc = [[TiXianViewController alloc] init];
            vc.type = 1;
            vc.hidesBottomBarWhenPushed = YES;

            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        if (self.indexPath.section == 0) {
            
            if (self.type == 1) {
                NSLog(@"充值微信");
                ChongZhiViewController *vc = [[ChongZhiViewController alloc] init];
                vc.type = 1;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];

            }else{
                NSLog(@"提现支付宝");
                TiXianViewController *vc = [[TiXianViewController alloc] init];
                vc.type = 1;
                vc.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            
            if (self.type == 1) {
                NSLog(@"充值支付宝");
                ChongZhiViewController *vc = [[ChongZhiViewController alloc] init];
                vc.type = 2;
                vc.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                NSLog(@"提现微信");
                TiXianViewController *vc = [[TiXianViewController alloc] init];
                vc.type = 2;
                vc.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            

        }
    }
    
    
}

- (void)setType:(int)type{
    _type = type;
    if (type == 1) {
        self.title = @"充值";

    }
    
    if (type == 2) {
        self.title = @"提现";
    }
}


- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        tableView.backgroundColor = ColorTableViewBg;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] init];
        [self.view insertSubview:tableView atIndex:1];
        _tableView = tableView;
    }
    return _tableView ;
}
#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0) {
//        MoneyMangerHeaderTableViewCell *cell = [MoneyMangerHeaderTableViewCell normalTableViewCellWithTableView:tableView];
//        cell.indexPath = indexPath;
//        cell.type = self.type;
//        if (self.indexPath) {
//            
//        }else{
//            if (self.type == 1) {
//                if (indexPath.section == 0) {
//
//                    cell.rightImageView.image = [UIImage imageNamed:@"bottomArrow"];
//                    cell.rightImageView.frame = CGRectMake(SCREEN_WIDTH - 35, 20, 20, 10);
//                }else{
//                    cell.rightImageView.image = [UIImage imageNamed:@"leftArrow"];
//                    cell.rightImageView.frame = CGRectMake(SCREEN_WIDTH - 30, 15, 10, 20);
//                }
//            }else{
//                if (indexPath.section == 1) {
//                    cell.rightImageView.image = [UIImage imageNamed:@"bottomArrow"];
//                    cell.rightImageView.frame = CGRectMake(SCREEN_WIDTH - 35, 20, 20, 10);
//
//                }else{
//                    cell.rightImageView.image = [UIImage imageNamed:@"leftArrow"];
//                    cell.rightImageView.frame = CGRectMake(SCREEN_WIDTH - 30, 15, 10, 20);
//
//                }
//            }
//        }
//        return cell;
//    }else{
//    }
    MoneyMangerTableViewCell *cell = [MoneyMangerTableViewCell normalTableViewCellWithTableView:tableView];
    cell.indexPath = indexPath;
    cell.type = self.type;
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.indexPath = indexPath;
//    if (self.indexPath == indexPath) {
//        if (indexPath.row == 0) {
//            MoneyMangerHeaderTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//            cell.rightImageView.image = [UIImage imageNamed:@"bottomArrow"];
//            cell.rightImageView.frame = CGRectMake(SCREEN_WIDTH - 35, 20, 20, 10);
//
//            if (indexPath.section == 0) {
//                NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
//                MoneyMangerTableViewCell *othercell = [tableView cellForRowAtIndexPath:index];
//                othercell.rightImageView.image = [UIImage imageNamed:@"leftArrow"];
//                othercell.rightImageView.frame = CGRectMake(SCREEN_WIDTH - 30, 15, 10, 20);
//
//            }else{
//                NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
//                MoneyMangerTableViewCell *othercell = [tableView cellForRowAtIndexPath:index];
//                othercell.rightImageView.image = [UIImage imageNamed:@"leftArrow"];
//                othercell.rightImageView.frame = CGRectMake(SCREEN_WIDTH - 30, 15, 10, 20);
//            }
//            [self.tableView reloadData];
//        }
//
//    }
    
    self.indexPath = indexPath;
    if (indexPath.section == 0) {
        MoneyMangerTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.rightImageView.image = [UIImage imageNamed:@"yuanSelected"];
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
        MoneyMangerTableViewCell *othercell = [tableView cellForRowAtIndexPath:index];
        othercell.rightImageView.image = [UIImage imageNamed:@"yuan"];
    }
    if (indexPath.section == 1) {
        MoneyMangerTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.rightImageView.image = [UIImage imageNamed:@"yuanSelected"];
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        MoneyMangerTableViewCell *othercell = [tableView cellForRowAtIndexPath:index];
        othercell.rightImageView.image = [UIImage imageNamed:@"yuan"];
    }
    
    
    if (self.type == 1) {//充值
        if (indexPath.section == 0) {
            //微信支付
            self.payType = PayTypeWehat;
        }
        
        if (indexPath.section == 1) {
            //支付宝支付
            self.payType = PayTypeZhiFuBao;
        }
    }
    
    if (self.type == 2) {//提现
        if (indexPath.section == 0) {
            //提现支付宝
            self.tiXianType = TiXianTypeZhiFuBao;
        }
        
        if (indexPath.section == 1) {
            //提现微信
            self.tiXianType = TiXianTypeBankCard;
        }
    }
}


//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    
    
    
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = ColorTableViewBg;
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


@end
