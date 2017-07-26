//
//  PublishChatRedBagViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/1.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "PublishChatRedBagViewController.h"
#import "RebBagFirstTableViewCell.h"
#import "RedBagSecondTableViewCell.h"
#import "TPKeyboardAvoidingTableView.h"
#import "RedBagChainTool.h"
@interface PublishChatRedBagViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *rightArray;
@property (nonatomic, strong) NSArray *placeHolderArray;
@property (nonatomic, weak) TPKeyboardAvoidingTableView *tableView;

@property (nonatomic, copy) NSString *redBagCount;
@property (nonatomic, copy) NSString *redBagMoney;
@property (nonatomic, copy) NSString *greeting;


@end

@implementation PublishChatRedBagViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUI];
    [self tableView];
}


- (void)setUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发红包";
}

- (void)setRedbagType:(NSString *)redbagType{
    _redbagType = redbagType;
}

- (NSArray *)titleArray{
    if (_titleArray == nil) {
        NSArray *array = @[@"红包个数",@"总金额"];
        _rightArray = array;
    }
    return _titleArray;
}

- (NSArray *)rightArray{
    if (_rightArray == nil) {
        NSArray *array = @[@"个",@"元"];
        _rightArray = array;
    }
    return _rightArray;
}

- (NSArray *)placeHolderArray{
    if (_placeHolderArray == nil) {
        NSArray *array = @[@"请填写个数",@"请填写金额"];
        _placeHolderArray = array;
    }
    return _placeHolderArray;
}

- (NSArray *)dataSource{
    if (_dataSource == nil) {
        NSArray *array = @[@"红包个数",@"总金额",@"恭喜发财，大吉大利！"];
        _dataSource = array;
    }
    return _dataSource;
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
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.redbagType isEqualToString:GroupChatRedBagType]) {
        return 1;
        
    }else{
        if (section == 0) {
            return 0;
        }else{
            return 1;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.redbagType isEqualToString:GroupChatRedBagType]) {
        return 50;
        
    }else{
        if (indexPath.section == 0) {
            return 0.000001;
        }else{
            return 50;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1) {
        RebBagFirstTableViewCell *cell  = [RebBagFirstTableViewCell normalTableViewCellWithTableView:tableView];
        cell.nameLabel.text = self.dataSource[indexPath.section];
        cell.textField.placeholder = self.placeHolderArray[indexPath.section];
        cell.rightLabel.text = self.rightArray[indexPath.section];
        cell.textField.tag = 100 + indexPath.section;
        
        [cell.textField addTarget:self action:@selector(textFieldClicked:) forControlEvents:UIControlEventEditingChanged];

        return cell;
        
    }else{
        RedBagSecondTableViewCell *cell = [RedBagSecondTableViewCell normalTableViewCellWithTableView:tableView];
        cell.textField.text = self.dataSource[indexPath.section];
        cell.textField.tag = 100 + indexPath.section;
        [cell.textField addTarget:self action:@selector(textFieldClicked:) forControlEvents:UIControlEventEditingChanged];
        [cell setButtonBlock:^{
           
            NSLog(@"buttonBlock 被点击");
        }];
        return cell;
        
    }
    
}

- (void)textFieldClicked:(UITextField *)textfield{
    if (textfield.tag == 100) {
        self.redBagCount = textfield.text;
        
    }
    
    if (textfield.tag == 101) {
        self.redBagMoney = textfield.text;
        
    }
    
    if (textfield.tag == 102) {
        
        self.greeting = textfield.text;
        
    }
    
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
    if (section == 2) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
        view.userInteractionEnabled = YES;
        
        UIButton *button = [[UIButton alloc] init];
        button.frame =CGRectMake(20, 110, SCREEN_WIDTH - 40, 40);
        [button setTitle:@"塞钱进红包" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor: [UIColor redColor]];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(sendRedBagButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        return view;
        
    }else{
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor clearColor];
        return backView;
    }

}

- (void)sendRedBagButtonClicked{
    
    NSString *greeting;
    if (self.greeting.length == 0) {
        greeting = @"恭喜发财，大吉大利！";
    }
    if (self.redBagCount.length == 0) {
        if ([self.redbagType isEqualToString:SingleChatRedBagType]) {
            self.redBagCount = @"1";
        }else{
            [self showHint:@"请填写红包个数"];
            return;
        }
    }
    
    if (self.redBagMoney.length == 0) {
        [self showHint:@"请填写金额"];
        return;
    }
    NSDictionary *param = @{@"uid":User_ID, @"type":@"11",@"num":self.redBagCount,@"total_amount":self.redBagMoney,@"desc":greeting};
    [RedBagChainTool publishGroupChatRedbagWithWithParam:param successBlock:^(NSString *msg, NSNumber *status,NSString *rid) {
        if ([status intValue] == 1) {
            if (self->_sendGroupChatRedBagBlock) {
                NSString *redbagtye = @"groupChatOrSingle";
                self->_sendGroupChatRedBagBlock(rid,redbagtye);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showHint:msg];
        }
        
        
    } errorBlock:^(NSError *error) {
        
    }];


}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 160;
    }else{
        return 10;
    }
}

@end
