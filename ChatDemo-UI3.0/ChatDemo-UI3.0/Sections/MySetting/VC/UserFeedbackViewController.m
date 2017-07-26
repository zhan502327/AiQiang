//
//  UserFeedbackViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/18.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "UserFeedbackViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "RedbagTextViewTableViewCell.h"

@interface UserFeedbackViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (nonatomic, weak) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong)  NSArray *titleArray;
@property (nonatomic, strong)  NSArray *placeHolderArray;
@property (nonatomic, copy)  NSString *firstStr;
@property (nonatomic, copy)  NSString *secondStr;


@end

@implementation UserFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupUI];
    [self tableView];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"用户反馈";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)sendMessage{
    
    
    
    
}

- (NSArray *)titleArray{
    if (_titleArray == nil) {
        NSArray *array = @[@"标题：",@"内容："];
        _titleArray = array;
    }
    return _titleArray;
}

- (NSArray *)placeHolderArray{
    if (_placeHolderArray == nil) {
        NSArray *array = @[@"正文标题...",@"您宝贵的建议是我们的最大的动力..."];
        _placeHolderArray = array;
    }
    return _placeHolderArray;
}

- (TPKeyboardAvoidingTableView *)tableView
{
    if (_tableView == nil) {
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
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
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==  0) {
        return 50;
    }else{
        return 200;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RedbagTextViewTableViewCell *cell = [RedbagTextViewTableViewCell normalTableViewCellWithTableView:tableView];
    cell.nameLabel.text = self.titleArray[indexPath.section];
    cell.textView.tag = 200 + indexPath.section;
    cell.textView.delegate = self;
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
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000000001;
}

- (void)textViewDidChange:(UITextView *)textView{
    switch (textView.tag) {
        case 200:
            self.firstStr = textView.text;
            break;
        case 201:
            self.secondStr = textView.text;
            break;
        default:
            break;
    }
}

@end
