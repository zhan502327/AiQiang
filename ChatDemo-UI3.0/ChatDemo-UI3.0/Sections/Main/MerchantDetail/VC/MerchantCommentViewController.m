//
//  MerchantCommentViewController.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/25.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "MerchantCommentViewController.h"
#import "MerchantCommentTableViewCell.h"
#import "MerchantCommentModel.h"

@interface MerchantCommentViewController () {
    NSInteger _count;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MerchantCommentViewController


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 60;
    
    _count = 1;
    
    [[NetworkManager new] postWithURL:[NSString stringWithFormat:@"%@/api.php/RedBags/getComment", www] parameter:@{@"uid": User_ID, @"id": _redPacketID, @"page": @"1"} success:^(id obj) {
        if ([obj[@"status"] isEqualToNumber:@1]) {
            for (NSDictionary *dic in obj[@"data"]) {
                MerchantCommentModel *model = [[MerchantCommentModel alloc] initWithDic:dic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        } else {
            [self showHint:obj[@"msg"]];
        }
    } fail:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        [[NetworkManager new] postWithURL:[NSString stringWithFormat:@"%@/api.php/RedBags/getComment", www] parameter:@{@"uid": User_ID, @"id": self->_redPacketID, @"page": @"1"} success:^(id obj) {
            if ([obj[@"status"] isEqualToNumber:@1]) {
                self->_count = 1;
                [self.dataArray removeAllObjects];
                for (NSDictionary *dic in obj[@"data"]) {
                    MerchantCommentModel *model = [[MerchantCommentModel alloc] initWithDic:dic];
                    [self.dataArray addObject:model];
                }
                [self.tableView reloadData];
            } else {
                [self showHint:obj[@"msg"]];
            }
            [self.tableView.pullToRefreshView stopAnimating];
        } fail:^(NSError *error) {
            [self showHint:@"网络错误"];
            [self.tableView.pullToRefreshView stopAnimating];
        }];
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        self->_count++;
        [[NetworkManager new] postWithURL:[NSString stringWithFormat:@"%@/api.php/RedBags/getComment", www] parameter:@{@"uid": User_ID, @"id": self->_redPacketID, @"page": [NSString stringWithFormat:@"%ld", self->_count]} success:^(id obj) {
            if ([obj[@"status"] isEqualToNumber:@1]) {
                for (NSDictionary *dic in obj[@"data"]) {
                    MerchantCommentModel *model = [[MerchantCommentModel alloc] initWithDic:dic];
                    [self.dataArray addObject:model];
                }
                [self.tableView reloadData];
            } else {
                [self showHint:obj[@"msg"]];
            }
            [self.tableView.infiniteScrollingView stopAnimating];

        } fail:^(NSError *error) {
            [self showHint:@"网络错误"];
            [self.tableView.infiniteScrollingView stopAnimating];
        }];
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MerchantCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
