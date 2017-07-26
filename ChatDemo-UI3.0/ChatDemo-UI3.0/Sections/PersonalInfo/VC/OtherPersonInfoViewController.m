//
//  OtherPersonInfoViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/5.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "OtherPersonInfoViewController.h"
#import "MineHeaderView.h"
#import "PersonalInfoTool.h"
#import "OtherPersonInfoTableViewCell.h"
#import "UserInfoModel.h"
#import "RedPacketChatViewController.h"
#import "DBAddFriendViewController.h"
#import "PersonalInfoTool.h"

@interface OtherPersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource, UIAlertViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *resultArray;
@property (nonatomic, strong) MineHeaderView *headerview;

@property (nonatomic, strong) UserInfoModel *userInfoModel;
@property (nonatomic, strong) NSArray *friendsListArray;
@property (nonatomic, strong) UIButton *bottomButton;

@property (nonatomic, assign) BOOL isFriend;

@property (nonatomic, copy) NSString *age;
@end

@implementation OtherPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupUI];
    [self getFriendsList];
}

- (void)initData{
    self.isFriend = NO;
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
}

- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"详细信息";
    
}

- (void)setUid:(NSString *)uid{
    _uid = uid;
}

- (void)loadData{
    
    NSDictionary *param = @{@"uid":User_ID,@"get_uid":self.uid};
    [PersonalInfoTool userInfoWithSuccessBlockWithPram:param successBlock:^(UserInfoModel *model) {
        self.userInfoModel = model;
        self.isFriend = [self.friendsListArray containsObject: self.userInfoModel.uid];
        NSString *localtion = [self.userInfoModel.location stringByReplacingOccurrencesOfString:@"null" withString:@""];
        self.userInfoModel.location = localtion;
        
         self.age = [NSString stringWithFormat:@"%@",self.userInfoModel.age];
        if ([model.sex isEqualToString:@"0"]) {
            model.sex = @"";
        }else if ([model.sex isEqualToString:@"1"]){
            model.sex = @"男";
        }else{
            model.sex = @"女";
        }
        self.userInfoModel.sex = model.sex;
        if (self.isFriend == YES) {
            self.dataSource = @[@"爱抢号",@"性别",@"年龄",@"故乡",@"所在地",@"备注"];
            if (self.userInfoModel.remark.length == 0) {
                self.userInfoModel.remark = @"无";
            }
            self.resultArray = @[model.aq_id,model.sex,self.age,model.address,self.userInfoModel.location,self.userInfoModel.remark];

            
        }else{
            self.dataSource = @[@"爱抢号",@"性别",@"年龄",@"故乡",@"所在地",@"备注"];
            if (self.userInfoModel.remark.length == 0) {
                self.userInfoModel.remark = @"无";
            }
            self.resultArray = @[model.aq_id,model.sex,self.age,model.address,self.userInfoModel.location,self.userInfoModel.remark];

        }
        [self.tableView reloadData];
    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

- (void)getFriendsList
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        NSArray *buddyList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        if (!error) {
            self.friendsListArray = buddyList;
            [self loadData];
        }else{
            [self showHint:@"网络错误"];
        }
    });
    
    
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        tableView.backgroundColor = ColorTableViewBg;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] init];
        self.headerview = [MineHeaderView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
//        self.headerview.settingButton.hidden = YES;
        self.headerview.userModel = self.userInfoModel;
        tableView.tableHeaderView = self.headerview;
        tableView.scrollEnabled = NO;
        [self.view insertSubview:tableView atIndex:1];
        _tableView = tableView;
    }
    return _tableView ;
}
#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isFriend == YES) {
        return self.dataSource.count;
    }else{
        return self.dataSource.count - 1;

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherPersonInfoTableViewCell *cell = [OtherPersonInfoTableViewCell normalTableViewCellWithTableView:tableView];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    cell.descLabel.text = self.resultArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    if (self.isFriend == YES) {
        if (indexPath.row == self.dataSource.count - 1) {

            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"设置好友备注" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            view.alertViewStyle = UIAlertViewStylePlainTextInput;
            [view show];
        }
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *textfield = [alertView textFieldAtIndex:0];
        
        if (textfield.text.length == 0) {
            [self showHint:@"请输入内容"];
            return;
        }
        
        NSDictionary *param = @{@"uid":User_ID , @"friend_uid":self.userInfoModel.uid, @"remark":textfield.text};
        [PersonalInfoTool setRemarkWithParam:param successBlock:^(NSString *msg, NSNumber *status) {
           
            [self showHint:msg];
            if ([status intValue] == 1) {
                self.userInfoModel.remark = textfield.text;
                self.resultArray = @[self.userInfoModel.aq_id,self.userInfoModel.sex,self.age,self.userInfoModel.address,self.userInfoModel.location,self.userInfoModel.remark];

                [[NSNotificationCenter defaultCenter] postNotificationName:@"DBrefreshFriendsList" object:nil];
                [self.tableView reloadData];
            }
        } errorBlock:^(NSError *error) {
            [self showHint:@"网络错误"];
        }];
        
    }
}

//HeaderInSection  &&  FooterInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = ColorTableViewBg;
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    backView.userInteractionEnabled = YES;
 
    self.bottomButton = [[UIButton alloc] init];
    self.bottomButton.frame = CGRectMake((SCREEN_WIDTH - 100)/2, 20, 100, 40);
    self.bottomButton.backgroundColor = [UIColor redColor];
    [self.bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.bottomButton.titleLabel.font = DBMaxFont;
    self.bottomButton.layer.masksToBounds = YES;
    self.bottomButton.layer.cornerRadius = 5;
    if ([self.userInfoModel.uid isEqualToString:User_ID]) {
        self.bottomButton.backgroundColor = [UIColor clearColor];
    }else{
        if (self.isFriend == YES) {
            [self.bottomButton setTitle:@"发送消息" forState:UIControlStateNormal];
        }else{
            [self.bottomButton setTitle:@"加好友" forState:UIControlStateNormal];
        }
        [self.bottomButton addTarget:self action:@selector(bottomButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    }
    
    [backView addSubview:self.bottomButton];
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}

- (void)bottomButtonClicked{
    if (self.isFriend) {

        UIViewController *chatController = nil;
#ifdef REDPACKET_AVALABLE
        chatController = [[RedPacketChatViewController alloc] initWithConversationChatter:self.userInfoModel.uid conversationType:EMConversationTypeChat];
#else
        chatController = [[ChatViewController alloc] initWithConversationChatter:self.userInfoModel.uid  conversationType:EMConversationTypeChat];
#endif
        chatController.title = self.userInfoModel.nickname.length > 0 ? self.userInfoModel.nickname : self.userInfoModel.uid;
        chatController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatController animated:YES];
    }else{
        
        DBAddFriendViewController *vc = [[DBAddFriendViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userInfoModel = self.userInfoModel;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}


@end
