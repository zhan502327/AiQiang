//
//  AllManRedPacketPinglunViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "AllManRedPacketPinglunViewController.h"
#import "AllManRedPacketTool.h"
#import "SellerRedBagTool.h"
#import "AllManRedPacketPingLunModel.h"
#import "AllManRedPacketPingLunTableViewCell.h"
#import "OtherPersonInfoViewController.h"

#define PlaceHolderStr @"我有话要说~~"


@interface AllManRedPacketPinglunViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, weak) UIView *inputView;
@property (nonatomic, weak) UIButton *sendMessageButton;
@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, copy) NSString *textFieldText;
@end

@implementation AllManRedPacketPinglunViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self inputView];
    [self initData];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 添加对键盘的监控
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];

    
}

- (void)keyBoardWillShow:(NSNotification *) note {
    self.textField.text = nil;
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘高度
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [self.view bringSubviewToFront:self.inputView];
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.inputView.transform = CGAffineTransformMakeTranslation(0, - keyBoardHeight);
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
    
}

- (void)keyBoardWillHide:(NSNotification *) note {
    self.textField.text = nil;
    self.textField.placeholder = PlaceHolderStr;
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.inputView.transform = CGAffineTransformIdentity;
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}

- (void)keyBoardDidHide:(NSNotification *)note{
    self.textFieldText = nil;
}

- (UIView *)inputView{
    if (_inputView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        view.layer.masksToBounds = YES;
        view.layer.borderColor = [UIColor grayColor].CGColor;
        view.layer.borderWidth = 0.5;
        view.frame = CGRectMake(0, SCREEN_HEIGHT - 64 - 45, SCREEN_WIDTH, 45);
        [self.view addSubview:view];
        [self.view bringSubviewToFront:view];
        
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(SCREEN_WIDTH - 10 - 60 , 5, 60, 35);
        button.backgroundColor = [UIColor redColor];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5;
        [button setTitle:@"发送" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sendMessageButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [view addSubview:button];
        _sendMessageButton = button;
        
        
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(10, 5, SCREEN_WIDTH - 100, 35);
        textField.layer.masksToBounds = YES;
        textField.layer.borderColor = [UIColor grayColor].CGColor;
        textField.layer.borderWidth = 0.5;
        textField.layer.cornerRadius = 4;
        textField.backgroundColor = [UIColor whiteColor];
        textField.placeholder = PlaceHolderStr;
        textField.textAlignment = NSTextAlignmentLeft;
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = [UIColor blackColor];
        [textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
        [view addSubview:textField];
        _textField = textField;
        
        _inputView = view;
    }
    return _inputView;
}

- (void)textFieldValueChanged:(UITextField *)textfield{
    self.textFieldText = textfield.text;
}

- (void)sendMessageButtonClicked{
    
    [self.textField resignFirstResponder];
    if (self.textFieldText.length == 0) {
        [self showHint:@"请输入评论内容"];
        return;
    }
    
    if ([self.redBagType isEqualToString:AllMan_RedBagType]) {
        NSDictionary *param = @{@"uid":User_ID, @"rid":self.redBagID ,@"comment":self.textFieldText};
        
        [AllManRedPacketTool allManRedBagSendCommentWithParam:param successBlock:^(NSString *msg, NSNumber *num) {
            [self showHint:msg];
            if ([num intValue] == 1) {
                [self loadData];
            }
            
        } errorBlock:^(NSError *error) {
            [self showHint:@"网络错误"];
        }];
        
    }
    
    if ([self.redBagType isEqualToString:Seller_RedBagType]) {
        NSDictionary *param = @{@"uid":User_ID, @"id":self.redBagID ,@"comment":self.textFieldText};
        
        [SellerRedBagTool selletRedBagSendCommnetWithParam:param successBlock:^(NSString *msg, NSNumber *num) {
            [self showHint:msg];
            if ([num intValue] == 1) {
                [self loadData];
            }
        } errorBlock:^(NSError *error) {
            [self showHint:@"网络错误"];
        }];
    }
    
    
}


- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"评论";
}

- (void)setRedBagID:(NSString *)redBagID{
    _redBagID = redBagID;
}

- (void)setRedBagType:(NSString *)redBagType{
    _redBagType = redBagType;
}


- (void)initData{
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
}

- (void)loadData{
    
    if ([self.redBagType isEqualToString:AllMan_RedBagType]) {
        
        NSDictionary *param = @{@"uid":User_ID,@"rid":self.redBagID,@"page":@"1"};
        [AllManRedPacketTool getAllManRedPacketPinglunListWithSuccessBlockWithPram:param successBlock:^(AllManRedPacketPingLunListResult *result) {
            
            self.dataSource = (NSMutableArray *)result.modelArray;
            [self.tableView reloadData];
            
        } errorBlock:^(NSError *error) {
            [self showHint:@"网络错误"];
        }];

        
    }
    
    if ([self.redBagType isEqualToString:Seller_RedBagType]) {
        
        NSDictionary *param = @{@"uid":User_ID,@"id":self.redBagID,@"page":@"1"};
        
        [SellerRedBagTool sellerRedBagCommentListWithParam:param successBlock:^(AllManRedPacketPingLunListResult *result) {
            
            self.dataSource = (NSMutableArray *)result.modelArray;
            [self.tableView reloadData];
        } errorBlock:^(NSError *error) {
            [self showHint:@"网络错误"];

        }];
    }
    
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40);
        tableView.backgroundColor=[UIColor clearColor];
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.dataSource=self;
        tableView.delegate=self;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}


- (void)sendButtonClicked{
    
}
#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AllManRedPacketPingLunModel *model = self.dataSource[indexPath.row];
    
    CGRect rect = [model.comment boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} context:nil];
    
    CGFloat height = rect.size.height;
    
    return height + 10 + 10 + 40 + 10 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllManRedPacketPingLunModel *model = self.dataSource[indexPath.row];

    AllManRedPacketPingLunTableViewCell *cell = [AllManRedPacketPingLunTableViewCell normalTableViewCellWithTableView:tableView];
    cell.model = model;
    [cell setIconImageViewBlock:^{
        
        OtherPersonInfoViewController *vc = [[OtherPersonInfoViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.uid = model.uid;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
