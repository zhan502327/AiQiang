//
//  DBDetailViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/18.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBDetailViewController.h"
#import "DBBillDetailTableViewCell.h"

@interface DBDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *resultArray;

@end

@implementation DBDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
    [self tableView];
}
- (void)setUI{
    self.title = @"账单明细";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setBillModel:(BillModel *)billModel{
    _billModel = billModel;
    NSString *type;
    if ([billModel.type isEqualToString:@"-1"]) {
        type = @"支出";
        NSArray *array = @[@[@"出账金额"],@[@"类  型",@"时  间",@"交易单号",@"剩余零钱",@"备  注"]];
        self.dataSource = array;
    }else{
        type = @"收入";
        NSArray *array = @[@[@"入账金额"],@[@"类  型",@"时  间",@"交易单号",@"剩余零钱",@"备  注"]];
        self.dataSource = array;
    }
    
    NSString *amount_after = [NSString stringWithFormat:@"%@",billModel.amount_after];
    self.resultArray = @[@[billModel.amount],@[type, billModel.create_time,billModel.number, amount_after,billModel.log]];
    
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        tableView.backgroundColor = ColorTableViewBg;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view insertSubview:tableView atIndex:1];
        _tableView = tableView;
    }
    return _tableView ;
}


#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == 0) {
        return 80;
    }else{
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DBBillDetailTableViewCell *cell = [DBBillDetailTableViewCell normalTableViewCellWithTableView:tableView];
    cell.nameLabel.text = self.dataSource[indexPath.section][indexPath.row];
    
    cell.rightLabel.text = self.resultArray[indexPath.section][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
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
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


@end
