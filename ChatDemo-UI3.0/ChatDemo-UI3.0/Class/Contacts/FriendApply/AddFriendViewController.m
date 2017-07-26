/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "AddFriendViewController.h"

#import "ApplyViewController.h"
#import "AddFriendCell.h"
#import "InvitationManager.h"
#import "FriendsListTool.h"
#import "UserInfoModel.h"
#import "OtherPersonInfoViewController.h"
#import "DBAddfriendsTableViewCell.h"

@interface AddFriendViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (nonatomic, strong) UserInfoModel *userInfoModel;

@property (nonatomic, strong) NSArray *friendsListArray;

@end

@implementation AddFriendViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.title = NSLocalizedString(@"friend.add", @"Add friend");
    self.view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    
    [self.view addSubview:self.headerView];
    
    self.dataSource = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame) - 10, self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.headerView.frame) - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    self.tableView.tableFooterView = footerView;
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    searchButton.accessibilityIdentifier = @"search_contact";
    [searchButton setTitle:NSLocalizedString(@"search", @"Search") forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:searchButton]];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backButton.accessibilityIdentifier = @"back";
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    [self.view addSubview:self.textField];
    
    
    
    [self getFriendsList];
}

- (NSArray *)friendsListArray{
    if (_friendsListArray == nil) {
        NSArray *array = [NSArray array];
        _friendsListArray = array;
    }
    return _friendsListArray;
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


- (void)loadData{
    
    
    [FriendsListTool recommendFriendWithParam:@{@"uid":User_ID} successBlock:^(NSMutableArray *array, NSString *msg, NSNumber *status) {
        [self.dataSource removeAllObjects];
        for (UserInfoModel *model in array) {
            if ([self.friendsListArray containsObject:model.uid] || [model.uid intValue] == [User_ID intValue]) {
            }else{
                [self.dataSource addObject:model];
            }
        }
        
        [self.tableView reloadData];
        
    } errorblock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - getter

- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        _headerView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 40)];
        _textField.accessibilityIdentifier = @"contact_name";
        _textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _textField.layer.borderWidth = 0.5;
        _textField.layer.cornerRadius = 3;
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont systemFontOfSize:15.0];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.placeholder = NSLocalizedString(@"friend.inputNameToSearch", @"input to find friends");
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
        [_headerView addSubview:_textField];
    }
    
    return _headerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UserInfoModel *model = self.dataSource[indexPath.row];
//    static NSString *CellIdentifier = @"AddFriendCell";
//    AddFriendCell *cell = (AddFriendCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
//    if (cell == nil) {
//        cell = [[AddFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",www,model.headimg]] placeholderImage:[UIImage imageNamed:@"chatListCellHead.png"]];
//    cell.textLabel.text = model.nickname;
//    cell.addLabel.hidden = YES;
//    return cell;
    
    UserInfoModel *model = self.dataSource[indexPath.row];

    DBAddfriendsTableViewCell *cell = [DBAddfriendsTableViewCell normalTableViewCellWithTableView:tableView];
    
    cell.model = model;
    return cell;
    
}

#pragma mark - Table view delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    view.frame = CGRectMake(0, 10, SCREEN_WIDTH , 40);
    view.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 5, 100, 30);
    label.textColor = [UIColor blackColor];
    label.text = @"推荐好友";
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(SCREEN_WIDTH -100, 5, 100, 30);
    [button setTitle:@"换一批" forState:UIControlStateNormal];
    [button setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(changeData) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)changeData{
    [self.dataSource removeAllObjects];
    [self loadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UserInfoModel *model = self.dataSource[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndexPath = indexPath;
    
//    
//    NSString *buddyName = model.uid;
//    if ([self didBuddyExist:buddyName]) {
//        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.repeat", @"'%@'has been your friend!"), model.nickname];
//        
//        [EMAlertView showAlertWithTitle:message
//                                message:nil
//                        completionBlock:nil
//                      cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
//                      otherButtonTitles:nil];
//        
//    }
//    else if([self hasSendBuddyRequest:buddyName])
//    {
//        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"friend.repeatApply", @"you have send fridend request to '%@'!"), model.nickname];
//        [EMAlertView showAlertWithTitle:message
//                                message:nil
//                        completionBlock:nil
//                      cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
//                      otherButtonTitles:nil];
//        
//    }else{
//        [self showMessageAlertView];
//    }
//    
    
    
    OtherPersonInfoViewController *vc = [[OtherPersonInfoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.uid = model.uid;
    [self.navigationController pushViewController:vc animated:YES];

    
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - action

- (void)searchAction
{
    [_textField resignFirstResponder];
    if(_textField.text.length > 0)
    {
        NSString *loginUsername = [[EMClient sharedClient] currentUsername];
        if ([_textField.text isEqualToString:loginUsername]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notAddSelf", @"can't add yourself as a friend") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
            [alertView show];
            
            return;
        }
        
        //判断是否已发来申请
        NSArray *applyArray = [[ApplyViewController shareController] dataSource];
        if (applyArray && [applyArray count] > 0) {
            for (ApplyEntity *entity in applyArray) {
                ApplyStyle style = [entity.style intValue];
                BOOL isGroup = style == ApplyStyleFriend ? NO : YES;
                if (!isGroup && [entity.applicantUsername isEqualToString:_textField.text]) {
                    NSString *str = [NSString stringWithFormat:NSLocalizedString(@"friend.repeatInvite", @"%@ have sent the application to you"), _textField.text];
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:str delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
                    [alertView show];
                    
                    return;
                }
            }
        }
        
        //根据输入内容查找用户信息
        NSDictionary *param = @{@"uid":User_ID,@"serach":_textField.text};
        [FriendsListTool searchUserInfoWithParam:param successBlock:^(NSString *msg, NSNumber *status,UserInfoModel *model) {
           
            if ([status intValue] == 1) {
                self.userInfoModel = model;
                [self.dataSource removeAllObjects];
                [self.dataSource addObject:model];
                [self.tableView reloadData];
            }else{
                [self showHint:msg];
            }
            
        } errorBlock:^(NSError *error) {
            [self showHint:@"网络错误"];
        }];
    }
}

- (BOOL)hasSendBuddyRequest:(NSString *)buddyName
{
    NSArray *userlist = [[EMClient sharedClient].contactManager getContacts];
    for (NSString *username in userlist) {
        if ([username isEqualToString:buddyName]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)didBuddyExist:(NSString *)buddyName
{
    NSArray *userlist = [[EMClient sharedClient].contactManager getContacts];
    for (NSString *username in userlist) {
        if ([username isEqualToString:buddyName]){
            return YES;
        }
    }
    return NO;
}

- (void)showMessageAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:NSLocalizedString(@"saySomething", @"say somthing")
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel")
                                          otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView cancelButtonIndex] != buttonIndex) {
        UITextField *messageTextField = [alertView textFieldAtIndex:0];
        
        NSString *messageStr = @"";
        NSString *username = [[EMClient sharedClient] currentUsername];
        if (messageTextField.text.length > 0) {
            messageStr = [NSString stringWithFormat:@"%@：%@", username, messageTextField.text];
        }
        else{
            messageStr = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyInvite", @"%@ invite you as a friend"), username];
        }
        [self sendFriendApplyAtIndexPath:self.selectedIndexPath
                                 message:messageStr];
    }
}

- (void)sendFriendApplyAtIndexPath:(NSIndexPath *)indexPath
                           message:(NSString *)message
{
    UserInfoModel *model = self.dataSource[indexPath.row];
    NSString *buddyName = model.uid;

    if (buddyName && buddyName.length > 0) {
        
        [self showHudInView:self.view hint:NSLocalizedString(@"friend.sendApply", @"sending application...")];
        NSDictionary *param = @{@"uid":User_ID,@"to_uid":buddyName,@"msg":message};
        [FriendsListTool sendFriendCheckWithParam:param successBlock:^(NSString *msg, NSNumber *status) {
            if ([status intValue] == 1) {
                EMError *error = [[EMClient sharedClient].contactManager addContact:buddyName message:message];
                [self hideHud];
                if (error) {
                    [self showHint:NSLocalizedString(@"friend.sendApplyFail", @"send application fails, please operate again")];
                }
                else{
                    [self showHint:NSLocalizedString(@"friend.sendApplySuccess", @"send successfully")];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                [self showHint:msg];
            }
        } errorBlock:^(NSError *error) {
            [self showHint:@"网络错误"];
        }];
    }
}

@end
