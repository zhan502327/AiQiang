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

#import "ApplyViewController.h"
#import "ApplyFriendCell.h"
#import "InvitationManager.h"
#import "FriendsListTool.h"
#import "FriendsCheckListModel.h"

static ApplyViewController *controller = nil;

@interface ApplyViewController ()<ApplyFriendCellDelegate>
{
    int page;
}

@property (nonatomic, strong) NSMutableArray *myDataSource;
@end

@implementation ApplyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (instancetype)shareController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] initWithStyle:UITableViewStyleGrouped];
    });
    
    return controller;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    page = 1;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page = 1;
        [self loadDataSourceFromLocalDB];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self->page ++;
        [self loadDataSourceFromLocalDB];
    }];
    
    
    [self configUI];
    
    [self loadDataSourceFromLocalDB];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
}


- (void)configUI{
    self.title = NSLocalizedString(@"title.apply", @"Application and notification");
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    backButton.accessibilityIdentifier = @"back";
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

#pragma mark - getter

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (NSMutableArray *)myDataSource{
    if (_myDataSource == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        _myDataSource = array;
    }
    return _myDataSource;
}

- (NSString *)loginUsername
{
    return [[EMClient sharedClient] currentUsername];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.dataSource count];
    }else{
        return self.myDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ApplyFriendCell *cell = [ApplyFriendCell normalTableViewCellWithTableView:tableView];
    cell.delegate = self;
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        //        static NSString *CellIdentifier = @"ApplyFriendCell";
        //        ApplyFriendCell *cell = (ApplyFriendCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //
        //        // Configure the cell...
        //        if (cell == nil) {
        //            cell = [[ApplyFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //            cell.delegate = self;
        //            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        }
        
        
        if(self.dataSource.count > indexPath.row)
        {
            ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
            if (entity) {
                cell.indexPath = indexPath;
                ApplyStyle applyStyle = [entity.style intValue];
                if (applyStyle == ApplyStyleGroupInvitation) {
                    cell.titleLabel.text = NSLocalizedString(@"title.groupApply", @"Group Notification");
                    cell.headerImageView.image = [UIImage imageNamed:@"dbgroup"];
                }
                else if (applyStyle == ApplyStyleJoinGroup)
                {
                    cell.titleLabel.text = NSLocalizedString(@"title.groupApply", @"Group Notification");
                    cell.headerImageView.image = [UIImage imageNamed:@"dbgroup"];
                }
                else if(applyStyle == ApplyStyleFriend){
                    cell.titleLabel.text = entity.applicantUsername;
                    cell.headerImageView.image = [UIImage imageNamed:@"chatListCellHead"];
                    cell.addButton.userInteractionEnabled = YES;
                    [cell.addButton setTitle:@"同意" forState:UIControlStateNormal];
                    cell.addButton.backgroundColor = [UIColor redColor];
                    [cell.addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
                cell.contentLabel.text = entity.reason;
            }
        }
        
        return cell;
        
    }else{
        
        //        static NSString *CellIdentifier = @"ApplyFriendCell";
        //        [tableView registerClass:[ApplyFriendCell class] forCellReuseIdentifier:CellIdentifier];
        //        ApplyFriendCell *cell = (ApplyFriendCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        //        if (cell == nil) {
        //            cell = [[ApplyFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //        }
        
        FriendsCheckListModel *model = self.myDataSource[indexPath.row];
        cell.indexPath = indexPath;
        
        cell.model = model;
        return cell;
    }
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
    return 0.000001;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = ColorTableViewBg;
    
    
    return backView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.0000001;
}



#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
        return [ApplyFriendCell heightWithContent:entity.reason];
        
    }else{
        return 60;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ApplyFriendCellDelegate

- (void)applyCellAddFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row < [self.dataSource count]) {
            [self showHudInView:self.view hint:NSLocalizedString(@"sendingApply", @"sending apply...")];
            
            ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
            ApplyStyle applyStyle = [entity.style intValue];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                EMError *error;
                if (applyStyle == ApplyStyleGroupInvitation) {
                    [[EMClient sharedClient].groupManager acceptInvitationFromGroup:entity.groupId inviter:entity.applicantUsername error:&error];
                }
                else if (applyStyle == ApplyStyleJoinGroup)
                {
                    error = [[EMClient sharedClient].groupManager acceptJoinApplication:entity.groupId applicant:entity.applicantUsername];
                }
                else if(applyStyle == ApplyStyleFriend){
                    error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:entity.applicantUsername];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self hideHud];
                    if (!error) {
                        
                        [self.dataSource removeObject:entity];
                        NSString *loginUsername = [[EMClient sharedClient] currentUsername];
                        [[InvitationManager sharedInstance] removeInvitation:entity loginUser:loginUsername];
//                        [self.tableView reloadData];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUntreatedApplyCount" object:nil];

                        [self.navigationController popViewControllerAnimated:YES];

                    }
                    else{
                        [self showHint:NSLocalizedString(@"acceptFail", @"accept failure")];
                    }
                });
            });
        }
        
    }else{
        [self showHudInView:self.view hint:NSLocalizedString(@"sendingApply", @"sending apply...")];
        
        FriendsCheckListModel *model = self.myDataSource[indexPath.row];
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:[model.from_uid isEqualToString:User_ID] ? model.to_uid : model.from_uid];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideHud];
            if (!error) {
                
                for (ApplyEntity *entity in self.dataSource) {
                    if ([entity.applicantUsername isEqualToString:[model.from_uid isEqualToString:User_ID] ? model.to_uid : model.from_uid ]) {
                        
                        [self.dataSource removeObject:entity];
                        
                        NSString *loginUsername = [[EMClient sharedClient] currentUsername];
                        [[InvitationManager sharedInstance] removeInvitation:entity loginUser:loginUsername];
                    }
                }

                NSDictionary *param = @{@"uid":User_ID, @"id":model.ID};
                [FriendsListTool agreeFriendApplyWithParam:param successBlock:^(NSString *msg, NSNumber *status) {
                    
                    [self showHint:msg];
                    if ([status intValue] == 1) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"DBrefreshFriendsList" object:nil];
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUntreatedApplyCount" object:nil];

                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                } errorblock:^(NSError *error) {
                    [self showHint:@"网络错误"];
                }];
            }
            else{
                [self showHint:NSLocalizedString(@"acceptFail", @"accept failure")];
            }
        });
    }
    
}

- (void)applyCellRefuseFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:NSLocalizedString(@"sendingApply", @"sending apply...")];
        ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
        ApplyStyle applyStyle = [entity.style intValue];
        EMError *error;
        
        if (applyStyle == ApplyStyleGroupInvitation) {
            error = [[EMClient sharedClient].groupManager declineInvitationFromGroup:entity.groupId inviter:entity.applicantUsername reason:nil];
        }
        else if (applyStyle == ApplyStyleJoinGroup)
        {
            error = [[EMClient sharedClient].groupManager declineJoinApplication:entity.groupId applicant:entity.applicantUsername reason:nil];
        }
        else if(applyStyle == ApplyStyleFriend){
            [[EMClient sharedClient].contactManager declineInvitationForUsername:entity.applicantUsername];
        }
        
        [self hideHud];
        if (!error) {
            [self.dataSource removeObject:entity];
            NSString *loginUsername = [[EMClient sharedClient] currentUsername];
            [[InvitationManager sharedInstance] removeInvitation:entity loginUser:loginUsername];
            
            [self.tableView reloadData];
        }
        else{
            [self showHint:NSLocalizedString(@"rejectFail", @"reject failure")];
            [self.dataSource removeObject:entity];
            NSString *loginUsername = [[EMClient sharedClient] currentUsername];
            [[InvitationManager sharedInstance] removeInvitation:entity loginUser:loginUsername];
            
            [self.tableView reloadData];
            
        }
    }
}

#pragma mark - public

- (void)addNewApply:(NSDictionary *)dictionary
{
    if (dictionary && [dictionary count] > 0) {
        NSString *applyUsername = [dictionary objectForKey:@"username"];
        ApplyStyle style = [[dictionary objectForKey:@"applyStyle"] intValue];
        
        if (applyUsername && applyUsername.length > 0) {
            for (int i = ((int)[_dataSource count] - 1); i >= 0; i--) {
                ApplyEntity *oldEntity = [_dataSource objectAtIndex:i];
                ApplyStyle oldStyle = [oldEntity.style intValue];
                if (oldStyle == style && [applyUsername isEqualToString:oldEntity.applicantUsername]) {
                    if(style != ApplyStyleFriend)
                    {
                        NSString *newGroupid = [dictionary objectForKey:@"groupname"];
                        if (newGroupid || [newGroupid length] > 0 || [newGroupid isEqualToString:oldEntity.groupId]) {
                            break;
                        }
                    }
                    
                    oldEntity.reason = [dictionary objectForKey:@"applyMessage"];
                    [_dataSource removeObject:oldEntity];
                    [_dataSource insertObject:oldEntity atIndex:0];
                    [self.tableView reloadData];
                    
                    return;
                }
            }
            
            //new apply
            ApplyEntity * newEntity= [[ApplyEntity alloc] init];
            newEntity.applicantUsername = [dictionary objectForKey:@"username"];
            newEntity.style = [dictionary objectForKey:@"applyStyle"];
            newEntity.reason = [dictionary objectForKey:@"applyMessage"];
            
            NSString *loginName = [[EMClient sharedClient] currentUsername];
            newEntity.receiverUsername = loginName;
            
            NSString *groupId = [dictionary objectForKey:@"groupId"];
            newEntity.groupId = (groupId && groupId.length > 0) ? groupId : @"";
            
            NSString *groupSubject = [dictionary objectForKey:@"groupname"];
            newEntity.groupSubject = (groupSubject && groupSubject.length > 0) ? groupSubject : @"";
            
            NSString *loginUsername = [[EMClient sharedClient] currentUsername];
            [[InvitationManager sharedInstance] addInvitation:newEntity loginUser:loginUsername];
            
            [_dataSource insertObject:newEntity atIndex:0];
            [self.tableView reloadData];
            
        }
    }
}

- (void)loadDataSourceFromLocalDB
{
    NSDictionary *param = @{@"uid":User_ID, @"page":[NSString stringWithFormat:@"%d",page]};
    [FriendsListTool checklistWithParam:param successBlock:^(NSMutableArray *modelArray, NSString *msg, NSNumber *status) {
        
        [self endRefresh];
        if (self->page == 1) {
            [self.myDataSource removeAllObjects];
        }
        
        [self.myDataSource addObjectsFromArray:modelArray];
        
        [self.tableView reloadData];
        
    } errorblock:^(NSError *error) {
        [self endRefresh];
        [self showHint:@"网络错误"];
    }];
    
    [self->_dataSource removeAllObjects];
    NSString *loginName = [self loginUsername];
    if(loginName && [loginName length] > 0)
    {
        NSArray * applyArray = [[InvitationManager sharedInstance] applyEmtitiesWithloginUser:loginName];
        
        NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:0];
        for (ApplyEntity *entity in applyArray) {
            ApplyStyle applyStyle = [entity.style intValue];
            if (!(applyStyle == ApplyStyleFriend)) {
                [newArray addObject:entity];
            }
        }
        [self.dataSource addObjectsFromArray:newArray];
        [self.tableView reloadData];
    }
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)back
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUntreatedApplyCount" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clear
{
    [_dataSource removeAllObjects];
    [self.tableView reloadData];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return NO;
    }else{
        return YES;
    }
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendsCheckListModel *model = self.myDataSource[indexPath.row];

    [tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
  
        NSDictionary *param = @{@"uid":User_ID, @"id":model.ID};
        [FriendsListTool deleteCheckWithParam:param successBlock:^(NSString *msg, NSNumber *status) {
            if ([status intValue] == 1) {
                [self.myDataSource removeObject:model];
                [self.tableView.mj_header beginRefreshing];
            }else{
                [self showHint:msg];
            }
            
        } errorblock:^(NSError *error) {
            [self showHint:@"网络错误"];
        }];
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
@end
