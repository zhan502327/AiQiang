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

#import "ContactListViewController.h"
#import "ChatViewController.h"
#import "RobotListViewController.h"
#import "ChatroomListViewController.h"
#import "AddFriendViewController.h"
#import "ApplyViewController.h"
#import "UserProfileManager.h"
#import "RealtimeSearchUtil.h"
#import "UserProfileManager.h"
#import "RedPacketChatViewController.h"
#import "BaseTableViewCell.h"
#import "UIViewController+SearchController.h"
#import "FriendsListTool.h"
#import "FriendsListModel.h"
#import "StealRedBagView.h"
#import "OtherPersonInfoViewController.h"
#import "DBUserInfoDataBaseModel.h"
#import "DBUserInfoDataBaseManager.h"
@implementation NSString (search)

//根据用户昵称进行搜索
- (NSString*)showName
{
    return [[UserProfileManager sharedInstance] getNickNameWithUsername:self];
}

@end

@interface ContactListViewController ()<UISearchBarDelegate, UIActionSheetDelegate, EaseUserCellDelegate, EMSearchControllerDelegate>
{
    NSIndexPath *_currentLongPressIndex;
}

@property (strong, nonatomic) NSMutableArray *sectionTitles;
@property (strong, nonatomic) NSMutableArray *contactsSource;
@property (nonatomic, strong) NSMutableArray *friendsListInfoArray;

@property (nonatomic) NSInteger unapplyCount;

@property (nonatomic) NSIndexPath *indexPath;

@property (nonatomic, weak) StealRedBagView *stealView;

@property (nonatomic, strong) NSDate *start_time;
@property (nonatomic, strong) NSDate *end_time;


@end

@implementation ContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    
    _contactsSource = [NSMutableArray array];
    _sectionTitles = [NSMutableArray array];
    _friendsListInfoArray = [NSMutableArray array];
    
    
    // 环信UIdemo中有用到Parse, 加载用户好友个人信息
    [[UserProfileManager sharedInstance] loadUserProfileInBackgroundWithBuddy:self.contactsSource saveToLoacal:YES completion:NULL];
    
    [self setupSearchController];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriend)];
    self.navigationItem.rightBarButtonItem = item;

    
    [self checkoutProtectTime];
}

- (void)checkoutProtectTime{
    
    [FriendsListTool chectoutProtectTimeWithParam:@{@"uid":User_ID} successBlock:^(NSString *start_time, NSString *end_time, NSString *else_time, NSString *msg, NSNumber *status) {
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd-HH:MM:ss"];//@"yyyy-MM-dd-HHMMss"
        
        NSDate* date1 = [NSDate dateWithTimeIntervalSince1970:[start_time doubleValue]];
        
        self.start_time = date1;
        NSString *dateString = [formatter stringFromDate:date1];
        NSLog(@"开始时间: %@", dateString);
        
        NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[end_time doubleValue]];
        self.end_time = date2;
        NSString *dateString2 = [formatter stringFromDate:date2];
        NSLog(@"结束时间: %@", dateString2);
        
        NSTimeInterval seconds = [date2 timeIntervalSinceDate:date1];
        NSLog(@"两个时间相隔：%f", seconds);
        
        
    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
    
    
}

- (void)addFriend{
    [self addFriendAction];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadApplyView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DBrefreshFriendsList) name:@"DBrefreshFriendsList" object:nil];
}
- (void)DBrefreshFriendsList{
    [self tableViewDidTriggerHeaderRefresh];
}


#pragma mark - getter

- (NSArray *)rightItems
{
    if (_rightItems == nil) {
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [addButton setImage:[UIImage imageNamed:@"addContact.png"] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addContactAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
        _rightItems = @[addItem];
    }
    
    return _rightItems;
}

- (StealRedBagView *)stealView{
    if (_stealView == nil) {
        StealRedBagView *view = [[StealRedBagView alloc] init];
        _stealView = view;
    }
    return _stealView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.dataArray count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 3;
    }
    
    return [[self.dataArray objectAtIndex:(section - 1)] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString *CellIdentifier = @"addFriend";
            EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.avatarView.image = [UIImage imageNamed:@"addfriend"];
            cell.titleLabel.text = NSLocalizedString(@"title.apply", @"Application and notification");
            cell.avatarView.badge = self.unapplyCount;
            cell.redBagButton.hidden = YES;
            cell.circularTimer.hidden = YES;
            return cell;
        }
        
        NSString *CellIdentifier = @"commonCell";
        EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        if (indexPath.row == 1) {
//            cell.avatarView.image = [UIImage imageNamed:@"EaseUIResource.bundle/group"];
            cell.avatarView.image = [UIImage imageNamed:@"dbgroup"];
            cell.titleLabel.text = NSLocalizedString(@"title.group", @"Group");
            cell.circularTimer.hidden = YES;

        }
        else if (indexPath.row == 2) {

            cell.circularTimer.hidden = NO;
            [cell.avatarView.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",www,User_Heading]]];
            cell.titleLabel.text = User_NickName;

            cell.circularTimer = [[CircularTimer alloc] initWithPosition:CGPointMake(SCREEN_WIDTH - 35 - 50, 12)
                                                             outerRadius:18
                                                          internalRadius:15
                                                       circleStrokeColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]
                                                 activeCircleStrokeColor:[UIColor orangeColor]
                                                             initialDate:self.start_time
                                                               finalDate:self.end_time
                                                           startCallback:^{
                                                               
                                                               
                                                           }
                                                             endCallback:^{
                                                                 
                                                             }];
            [cell.contentView addSubview:cell.circularTimer];
            
            cell.protectLabel = [[UILabel alloc] init];
            cell.protectLabel.text = @"保护";
            cell.protectLabel.textAlignment = NSTextAlignmentCenter;
            cell.protectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
            
            cell.protectLabel.frame = CGRectMake(3, 3, 30, 30);
            cell.protectLabel.backgroundColor = [UIColor clearColor];
            cell.protectLabel.textColor = [UIColor orangeColor];
            [cell.circularTimer addSubview:cell.protectLabel];
            
        }

        else if (indexPath.row == 3) {
            cell.avatarView.image = [UIImage imageNamed:@"EaseUIResource.bundle/group"];
            cell.titleLabel.text = NSLocalizedString(@"title.chatroomlist",@"chatroom list");
        }
        else if (indexPath.row == 4) {
            cell.avatarView.image = [UIImage imageNamed:@"EaseUIResource.bundle/group"];
            cell.titleLabel.text = NSLocalizedString(@"title.robotlist",@"robot list");
        }
        cell.redBagButton.hidden = YES;

        return cell;
    }
    else{
        NSString *CellIdentifier = [EaseUserCell cellIdentifierWithModel:nil];
        EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSArray *userSection = [self.dataArray objectAtIndex:(indexPath.section - 1)];
//        EaseUserModel *model = [userSection objectAtIndex:indexPath.row];
        FriendsListModel *mymodel = [userSection objectAtIndex:indexPath.row];
        EaseUserModel *model = [[EaseUserModel alloc] init];
//        for (FriendsListModel *mymodel in self.friendsListInfoArray) {
//            if ([mymodel.uid isEqualToString:model.uid]) {
//                model.nickname = (mymodel.remark.length > 0) ? mymodel.remark : mymodel.nickname;
//                model.avatarURLPath = [NSString stringWithFormat:@"%@%@",www,mymodel.headimg];
//                if ([mymodel.is_stealed isEqualToNumber:@1]) {
//                    model.showStealRedBagButton = YES;
//                }else{
//                    model.showStealRedBagButton = NO;
//                }
//                model.uid = mymodel.uid;
//            }
//        }
        model.nickname = (mymodel.remark.length > 0) ? mymodel.remark : mymodel.nickname;
        model.avatarURLPath = [NSString stringWithFormat:@"%@%@",www,mymodel.headimg];
        if ([mymodel.is_stealed isEqualToNumber:@1]) {
            model.showStealRedBagButton = YES;
        }else{
            model.showStealRedBagButton = NO;
        }
        model.uid = mymodel.uid;
        

//        if ([mymodel.uid isEqualToString:model.uid]) {
//            model.nickname = (mymodel.remark.length > 0) ? mymodel.remark : mymodel.nickname;
//            model.avatarURLPath = [NSString stringWithFormat:@"%@%@",www,mymodel.headimg];
//            if ([mymodel.is_stealed isEqualToNumber:@1]) {
//                model.showStealRedBagButton = YES;
//            }else{
//                model.showStealRedBagButton = NO;
//            }
//            model.uid = mymodel.uid;
//        }

        
        
        UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:model.buddy];
        if (profileEntity) {
            model.avatarURLPath = profileEntity.imageUrl;
            model.nickname = profileEntity.nickname == nil ? profileEntity.username : profileEntity.nickname;
        }
        cell.indexPath = indexPath;
        cell.delegate = self;
        cell.model = model;
        if (model.showStealRedBagButton == YES) {
            cell.redBagButton.hidden = NO;
        }else{
            cell.redBagButton.hidden = YES;
        }
        
        [cell setStealRedBagBlock:^{
            NSLog(@"偷红包按钮被点击——————");
            NSDictionary *param = @{@"uid":User_ID,@"to_uid":model.uid};
            
            [FriendsListTool stealRedbagWithParam:param successBlock:^(NSString *msg, NSNumber *status) {
                
                [self tableViewDidTriggerHeaderRefresh];
                
                if ([status isEqualToNumber:@1]) {
                    
                    [self.stealView configViewWithStatus:1 Moeny:msg andNickName:model.nickname andImageName:model.avatarURLPath];
                }else{
//                    [self showHint:msg];
                    [self.stealView configViewWithStatus:0 Moeny:nil andNickName:nil andImageName:model.avatarURLPath];
                }
                
            } errorBlock:^(NSError *error) {
                [self showHint:@"网络错误"];
            }];
            
        }];
        cell.circularTimer.hidden = YES;
        return cell;
    }}


#pragma mark - Table view delegate

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    else{
        return 22;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return nil;
    }
    
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
    label.backgroundColor = [UIColor clearColor];
    [label setText:[self.sectionTitles objectAtIndex:(section - 1)]];
    [contentView addSubview:label];
    return contentView;
}
         
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {//申请与通知
        
            ApplyViewController *vc = [ApplyViewController shareController];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (row == 1)
        {
//            if (_groupController == nil) {
//                _groupController = [[GroupListViewController alloc] initWithStyle:UITableViewStylePlain];
//            }
//            else{
//                [_groupController reloadDataSource];
//            }
            
            //--------------群组-------------
            GroupListViewController *groupController = [[GroupListViewController alloc] initWithStyle:UITableViewStylePlain];
            groupController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:groupController animated:YES];
        }
        else if (row == 2)
        {
            NSLog(@" 点击自己");
            [FriendsListTool resetProtectTimeWithParam:@{@"uid":User_ID} successBlock:^(NSString *msg, NSNumber *status) {
                [self showHint:msg];
                if ([status intValue] == 1) {
                    [self tableViewDidTriggerHeaderRefresh];
                    
                    
                }
            } errorblock:^(NSError *error) {
                [self showHint:@"网络错误"];
            }];
            
        }
        
        else if (row == 3)
        {
            ChatroomListViewController *controller = [[ChatroomListViewController alloc] initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if (row == 4) {
            RobotListViewController *robot = [[RobotListViewController alloc] init];
            [self.navigationController pushViewController:robot animated:YES];
        }
    }
    else{
        FriendsListModel *model = [[self.dataArray objectAtIndex:(section - 1)] objectAtIndex:row];
//        UIViewController *chatController = nil;
//#ifdef REDPACKET_AVALABLE
//        chatController = [[RedPacketChatViewController alloc] initWithConversationChatter:model.buddy conversationType:EMConversationTypeChat];
//#else
//        chatController = [[ChatViewController alloc] initWithConversationChatter:model.buddy conversationType:EMConversationTypeChat];
//#endif
//        chatController.title = model.nickname.length > 0 ? model.nickname : model.buddy;
//        chatController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:chatController animated:YES];
        
        OtherPersonInfoViewController *vc = [[OtherPersonInfoViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.uid = model.uid;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
}
                                                       
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}
                                                       
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *loginUsername = [[EMClient sharedClient] currentUsername];
        FriendsListModel *model = [[self.dataArray objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];
        if ([model.uid isEqualToString:loginUsername]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notDeleteSelf", @"can't delete self") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
            [alertView show];
            
            return;
        }
        
        self.indexPath = indexPath;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定删除该好友？" delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
        
        alertView.tag = 101;
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.indexPath == nil)
    {
        return;
    }
    
    NSIndexPath *indexPath = self.indexPath;
    FriendsListModel *model = [[self.dataArray objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];
    self.indexPath = nil;
    
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        if (alertView.tag == 101) {
            //        EMError *error = [[EMClient sharedClient].contactManager deleteContact:model.buddy isDeleteConversation:NO];
            //        if (!error) {
            //            [self.tableView beginUpdates];
            //            [[self.dataArray objectAtIndex:(indexPath.section - 1)] removeObjectAtIndex:indexPath.row];
            //            [self.contactsSource removeObject:model.buddy];
            //            [self.tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            //            [self.tableView endUpdates];
            //        }
            //        else{
            //            [self showHint:[NSString stringWithFormat:NSLocalizedString(@"deleteFailed", @"Delete failed:%@"), error.errorDescription]];
            //            [self.tableView reloadData];
            //        }
        }

    }
    else
    {
        if (alertView.tag == 101) {
            
            NSString *nickeName = @"";
            for (FriendsListModel *mymodel in self.friendsListInfoArray) {
                if ([mymodel.uid isEqualToString:model.uid]) {
                    nickeName = mymodel.nickname;
                }
            }
            

            
            EMError *error = [[EMClient sharedClient].contactManager deleteContact:model.uid isDeleteConversation:YES];
            if (!error) {
                [[EMClient sharedClient].chatManager deleteConversation:model.uid isDeleteMessages:YES completion:nil];
                
                [self.tableView beginUpdates];
                [[self.dataArray objectAtIndex:(indexPath.section - 1)] removeObjectAtIndex:indexPath.row];
                [self.contactsSource removeObject:model.uid];
                [self.tableView  deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView endUpdates];
            }
            else{
                [self showHint:[NSString stringWithFormat:NSLocalizedString(@"deleteFailed", @"Delete failed:%@"), error.errorDescription]];
                [self.tableView reloadData];
            }
        }
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex || _currentLongPressIndex == nil) {
        return;
    }
    
    NSIndexPath *indexPath = _currentLongPressIndex;
    FriendsListModel *model = [[self.dataArray objectAtIndex:(indexPath.section - 1)] objectAtIndex:indexPath.row];
    _currentLongPressIndex = nil;
    
    [self hideHud];
    [self showHudInView:self.view hint:NSLocalizedString(@"wait", @"Pleae wait...")];
    EMError *error = [[EMClient sharedClient].contactManager addUserToBlackList:model.uid relationshipBoth:YES];
    [self hideHud];
    if (!error) {
        //由于加入黑名单成功后会刷新黑名单，所以此处不需要再更改好友列表
        [self reloadDataSource];
    }
    else {
        [self showHint:error.errorDescription];
    }
}
                                                       
#pragma mark - EaseUserCellDelegate
                                                       
- (void)cellLongPressAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row >= 1) {
        return;
    }
    
    _currentLongPressIndex = indexPath;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") destructiveButtonTitle:NSLocalizedString(@"friend.block", @"join the blacklist") otherButtonTitles:nil, nil];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}
                                               
#pragma mark - EMSearchControllerDelegate     
                                                       
- (void)cancelButtonClicked
{
    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
}
                                               
- (void)searchTextChangeWithString:(NSString *)aString
{
    __weak typeof(self) weakSelf = self;
    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.contactsSource searchText:aString collationStringSelector:@selector(showName) resultBlock:^(NSArray *results) {
        if (results) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.resultController.displaySource removeAllObjects];
                [weakSelf.resultController.displaySource addObjectsFromArray:results];
                [weakSelf.resultController.tableView reloadData];
            });
        }
    }];
}

#pragma mark - action

- (void)addContactAction
{
    AddFriendViewController *addController = [[AddFriendViewController alloc] init];
    [self.navigationController pushViewController:addController animated:YES];
}

#pragma mark - private
                                                       
- (void)setupSearchController
{
    [self enableSearchController];
    
    __weak ContactListViewController *weakSelf = self;
    [self.resultController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        static NSString *CellIdentifier = @"BaseTableViewCell";
        BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSString *buddy = [weakSelf.resultController.displaySource objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"chatListCellHead.png"];
        cell.textLabel.text = buddy;
        cell.username = buddy;
        
        return cell;
    }];
    
    [self.resultController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 50;
    }];
    
    [self.resultController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSString *buddy = [weakSelf.resultController.displaySource objectAtIndex:indexPath.row];
        [weakSelf.searchController.searchBar endEditing:YES];
        
#ifdef REDPACKET_AVALABLE
        RedPacketChatViewController *chatVC = [[RedPacketChatViewController alloc] initWithConversationChatter:buddy conversationType:EMConversationTypeChat];
#else
        ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:buddy
                                     conversationType:EMConversationTypeChat];
#endif
        chatVC.title = [[UserProfileManager sharedInstance] getNickNameWithUsername:buddy];
        [weakSelf.navigationController pushViewController:chatVC animated:YES];
                                               
        [weakSelf cancelSearch];
    }];
        
    UISearchBar *searchBar = self.searchController.searchBar;
    self.tableView.tableHeaderView = searchBar;
    [searchBar sizeToFit];

}

- (void)_sortDataArray:(NSArray *)buddyList
{
    
    
    [self.dataArray removeAllObjects];
    [self.sectionTitles removeAllObjects];
    NSMutableArray *contactsSource = [NSMutableArray array];//存储环信id
    
    //从获取的数据中剔除黑名单中的好友
    NSArray *blockList = [[EMClient sharedClient].contactManager getBlackList];
    NSLog(@"%@",blockList);
    for (NSString *buddy in buddyList) {
        if (![blockList containsObject:buddy]) {
            [contactsSource addObject:buddy];
        }
    }
    
    //建立索引的核心, 返回27，是a－z和＃
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    [self.sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
    
    NSInteger highSection = [self.sectionTitles count];
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i < highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    //按首字母分组
    for (FriendsListModel *mymodel in self.friendsListInfoArray)
    {
        
        NSString *firstLetter = mymodel.remark.length > 0 ? mymodel.remark : mymodel.nickname;
        NSInteger section;
        if (firstLetter.length > 0) {
            section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
        } else {
            section = [sortedArray count] - 1;
        }
        
        NSMutableArray *array = [sortedArray objectAtIndex:section];
        [array addObject:mymodel];
    }
    
//    for (NSString *buddy in contactsSource)
//    {
//        EaseUserModel *model = [[EaseUserModel alloc] initWithBuddy:buddy];
//        if (model) {
//            model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
//            model.nickname = [[UserProfileManager sharedInstance] getNickNameWithUsername:buddy];
//            
//            
//            NSString *firstLetter = [EaseChineseToPinyin pinyinFromChineseString:[[UserProfileManager sharedInstance] getNickNameWithUsername:buddy]];
//            NSInteger section;
//            if (firstLetter.length > 0) {
//                section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
//            } else {
//                section = [sortedArray count] - 1;
//            }
//            
//            NSMutableArray *array = [sortedArray objectAtIndex:section];
//            [array addObject:model];
//        }
//    }
    
    
    
    //每个section内的数组排序
    for (int i = 0; i < [sortedArray count]; i++) {
        NSArray *array = [[sortedArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(FriendsListModel *obj1, FriendsListModel *obj2) {
            NSString *firstLetter1 = [EaseChineseToPinyin pinyinFromChineseString:obj1.remark.length > 0 ? obj1.remark : obj1.nickname];
            firstLetter1 = [[firstLetter1 substringToIndex:1] uppercaseString];
            
            NSString *firstLetter2 = [EaseChineseToPinyin pinyinFromChineseString:obj2.remark.length > 0 ? obj2.remark : obj2.nickname];
            firstLetter2 = [[firstLetter2 substringToIndex:1] uppercaseString];
            
            return [firstLetter1 caseInsensitiveCompare:firstLetter2];
        }];
        
        
        [sortedArray replaceObjectAtIndex:i withObject:[NSMutableArray arrayWithArray:array]];
    }

//    for (int i = 0; i < [sortedArray count]; i++) {
//        NSArray *array = [[sortedArray objectAtIndex:i] sortedArrayUsingComparator:^NSComparisonResult(EaseUserModel *obj1, EaseUserModel *obj2) {
//            NSString *firstLetter1 = [EaseChineseToPinyin pinyinFromChineseString:obj1.buddy];
//            firstLetter1 = [[firstLetter1 substringToIndex:1] uppercaseString];
//            
//            NSString *firstLetter2 = [EaseChineseToPinyin pinyinFromChineseString:obj2.buddy];
//            firstLetter2 = [[firstLetter2 substringToIndex:1] uppercaseString];
//            
//            return [firstLetter1 caseInsensitiveCompare:firstLetter2];
//        }];
//        
//        
//        [sortedArray replaceObjectAtIndex:i withObject:[NSMutableArray arrayWithArray:array]];
//    }
    
    //去掉空的section
    for (NSInteger i = [sortedArray count] - 1; i >= 0; i--) {
        NSArray *array = [sortedArray objectAtIndex:i];
        if ([array count] == 0) {
            [sortedArray removeObjectAtIndex:i];
            [self.sectionTitles removeObjectAtIndex:i];
        }
    }
    
    [self.dataArray addObjectsFromArray:sortedArray];
    [self.tableView reloadData];
}

- (void)loadFriendsListInfoFromLocalServeWithArray:(NSArray *)array{
    
    typeof(self) weakself = self;
    if (array) {
        NSString *str = [array componentsJoinedByString:@","];
        
        NSDictionary *dic = @{@"uid" : User_ID, @"uids" : str};
        
        [FriendsListTool friendsListWithParam:dic successBlock:^(NSMutableArray *array, NSNumber *status) {
            
            self.friendsListInfoArray = array;
            [weakself _sortDataArray:self.contactsSource];

            if ([status intValue] == 1) {
                [self FMDB];
            }
            
        } errorBlock:^(NSError *error) {
            
        }];
    }
}
//数据库操作
- (void)FMDB{
    for (FriendsListModel *myModel in self.friendsListInfoArray) {
        DBUserInfoDataBaseModel *model = [[DBUserInfoDataBaseModel alloc] init];
        model.uid = myModel.uid;
        model.nickname = myModel.nickname;
        model.headimg = myModel.headimg;
        model.remark = myModel.remark;
        
        //查询是否存在
        NSArray *resultModelArray = [[DBUserInfoDataBaseManager shareDBManager] getUserInfoModelWithUid:myModel.uid];
        
        if (resultModelArray.count > 0) {// 数据库中存在此数据
            for (DBUserInfoDataBaseModel *dbModel in resultModelArray) {
                BOOL isdelete = [[DBUserInfoDataBaseManager shareDBManager] deleteUserInfoWithUid:dbModel.uid];
                
                if (isdelete == YES) {
                    int64_t messageid = [[DBUserInfoDataBaseManager shareDBManager] addNewUserInfoWithModel:model];
                    if (-1 != messageid){
                        NSLog(@"数据插入成功 消息id %lld",messageid);
                    }
                }else{
                    
                }
            }
        }else{// 不存在此数据  插入
            
            int64_t messageid = [[DBUserInfoDataBaseManager shareDBManager] addNewUserInfoWithModel:model];
            if (-1 != messageid){
                NSLog(@"数据插入成功 消息id %lld",messageid);
            }
            
        }
    }
    
    
    
    //获取所有数据
    NSArray *allUserInfoModelArray = [[DBUserInfoDataBaseManager shareDBManager] getAllUserInfoModel];
    
    NSLog(@"allUserInfoModelArray------%@",allUserInfoModelArray);
}


#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    //查询保护期
    [self checkoutProtectTime];
    
    
//    [self showHudInView:self.view hint:NSLocalizedString(@"loadData", @"Load data...")];
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        EMError *error = nil;
        NSArray *buddyList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        NSLog(@"%@",buddyList);
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [self hideHud];
        });
        if (!error) {
            [[EMClient sharedClient].contactManager getBlackListFromServerWithError:&error];
            if (!error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.contactsSource removeAllObjects];
                    for (NSInteger i = (buddyList.count - 1); i >= 0; i--) {
                        NSString *username = [buddyList objectAtIndex:i];
                        [weakself.contactsSource addObject:username];//添加环信id
                    }
                    [self loadFriendsListInfoFromLocalServeWithArray:buddyList];
//                    [weakself _sortDataArray:self.contactsSource];
                });
            }
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself showHint:NSLocalizedString(@"loadDataFailed", @"Load data failed.")];
                [weakself reloadDataSource];
            });
        }
        [weakself tableViewDidFinishTriggerHeader:YES reload:NO];
    });
    
    
}

#pragma mark - public

- (void)reloadDataSource
{
    [self.dataArray removeAllObjects];
    [self.contactsSource removeAllObjects];
    
    NSArray *buddyList = [[EMClient sharedClient].contactManager getContacts];
    
    for (NSString *buddy in buddyList) {
        [self.contactsSource addObject:buddy];
    }
    [self _sortDataArray:self.contactsSource];
    
    [self.tableView reloadData];
}

- (void)reloadApplyView
{
    NSInteger count = [[[ApplyViewController shareController] dataSource] count];
    self.unapplyCount = count;
    [self.tableView reloadData];
}

- (void)reloadGroupView
{
    [self reloadApplyView];
    
    if (_groupController) {
        [_groupController tableViewDidTriggerHeaderRefresh];
    }
}

- (void)addFriendAction
{
    AddFriendViewController *addController = [[AddFriendViewController alloc] init];
    addController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addController animated:YES];
}

@end
