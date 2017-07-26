
//
//  ChatWithRedPacketViewController.m
//  ChatDemo-UI3.0
//
//  Created by Mr.Yang on 16/2/23.
//  Copyright © 2016年 Mr.Yang. All rights reserved.
//

#import "RedPacketChatViewController.h"
#import "EaseRedBagCell.h"
#import "RedpacketTakenMessageTipCell.h"
#import "RedpacketViewControl.h"
#import "RedpacketMessageModel.h"
#import "RedPacketUserConfig.h"
#import "RedpacketOpenConst.h"
#import "YZHRedpacketBridge.h"
#import "ChatDemoHelper.h"
#import "UserProfileManager.h"
#import "RedBagChainTool.h"
#import "RedBagChainResultViewController.h"
#import "StealRedBagView.h"
#import "PublishChatRedBagViewController.h"

//#import "UIImageView+EMWebCache.h"

/** 红包聊天窗口 */
@interface RedPacketChatViewController () < EaseMessageCellDelegate,
                                            EaseMessageViewControllerDataSource,
                                            RedpacketViewControlDelegate,
                                            UIAlertViewDelegate>

{
    NSString *type;
    NSString *total_amount;
    
    
}

/** 发红包的控制器 */
@property (nonatomic, strong)   RedpacketViewControl *viewControl;

@property (nonatomic, weak) UIView *topBgView;
@property (nonatomic, weak) UILabel *onlineLabel;
@property (nonatomic, weak) UIButton *startGameButton;

@property (nonatomic, strong) dispatch_source_t timer;//计时器
@property (nonatomic, strong) dispatch_source_t timer_chaeckOutMax;//计时器


@property (nonatomic, copy) NSString *onlineNumber;

@property (nonatomic, copy) NSString *rid;//红包id

@property (nonatomic, weak) StealRedBagView *stealView;

@property (nonatomic, assign) BOOL isYourTurnToSendRedBag;

@property (nonatomic, copy) NSString *sendGroupChatOrSingleRedBag;

@end

@implementation RedPacketChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    type = 0;
    self.isYourTurnToSendRedBag = NO;
    
    
    /** RedPacketUserConfig 持有当前聊天窗口 */
    [RedPacketUserConfig sharedConfig].chatVC = self;
    /** 红包功能的控制器， 产生用户单击红包后的各种动作 */
    _viewControl = [[RedpacketViewControl alloc] init];
    /** 获取群组用户代理 */
    _viewControl.delegate = self;
    /** 需要当前的聊天窗口 */
    _viewControl.conversationController = self;
    /** 需要当前聊天窗口的会话ID */
    RedpacketUserInfo *userInfo = [RedpacketUserInfo new];
    userInfo.userId = self.conversation.conversationId;
    _viewControl.converstationInfo = userInfo;
    __weak typeof(self) weakSelf = self;
    
    /** 用户抢红包和用户发送红包的回调 */
    [_viewControl setRedpacketGrabBlock:^(RedpacketMessageModel *messageModel) {
        
        /** 发送通知到发送红包者处 */
        if (messageModel.redpacketType != RedpacketTypeAmount) {
            [weakSelf sendRedpacketHasBeenTaked:messageModel];
        }
    } andRedpacketBlock:^(RedpacketMessageModel *model) {
        
        /** 发送红包 */
        [weakSelf sendRedPacketMessage:model];
    }];
    
    /** 设置用户头像大小 */
    [[EaseRedBagCell appearance] setAvatarSize:40.f];
    /** 设置头像圆角 */
    [[EaseRedBagCell appearance] setAvatarCornerRadius:20.f];
    
    if ([self.chatToolbar isKindOfClass:[EaseChatToolbar class]]) {
        /** 红包按钮 */
        [self.chatBarMoreView insertItemWithImage:[UIImage imageNamed:@"RedpacketCellResource.bundle/redpacket_redpacket"] highlightedImage:[UIImage imageNamed:@"RedpacketCellResource.bundle/redpacket_redpacket_high"] title:@"红包"];
        /** 转账按钮 */
        [self.chatBarMoreView insertItemWithImage:[UIImage imageNamed:@"RedPacketResource.bundle/redpacket_transfer_high"] highlightedImage:[UIImage imageNamed:@"RedPacketResource.bundle/redpacket_transfer_high"] title:@"转账"];
    }
    
    if ([self.conversation.conversationId isEqualToString:OneGroupId]) {
        type = @"1";
        total_amount = @"0.5";
    }
    
    if ([self.conversation.conversationId isEqualToString:TwoGroupId]){
        type = @"2";
        total_amount = @"1";
    }
    
    if ([self.conversation.conversationId isEqualToString:ThreeGroupId]){
        type = @"3";
        total_amount = @"3";
    }
    
    if ([self.conversation.conversationId isEqualToString:FourGroupId]) {
        type = @"4";
        total_amount = @"5";
    }
    
    if ([self.conversation.conversationId isEqualToString:OneGroupId] || [self.conversation.conversationId isEqualToString:TwoGroupId] || [self.conversation.conversationId isEqualToString:ThreeGroupId] || [self.conversation.conversationId isEqualToString:FourGroupId]) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tips"] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItemClicked)];
        self.navigationItem.rightBarButtonItem = item;
    }
    
}

- (void)barButtonItemClicked{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"红包接龙规则" message:@"为打造健康良好的娱乐平台，避免用户进行违法违禁操作，特制订以下规则：\nI、红包接龙游戏分为4个群组，进入任何一个群组需缴纳对应的押金。\nII、押金在退出群组时自动退回到个人账户，违禁操作押金不予退还。\nIII、违禁操作：\n① 不按系统提示操作，逃跑退出群组。\n② 在未退出群组时，直接点击手机主页面，清除APP缓存。\nIV、参与接龙游戏的金额不能以任何形式进行充值，所用金额皆来源于平台所发送的红包金额。" preferredStyle:UIAlertControllerStyleAlert];
    UIView *subView1 = alertController.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    NSLog(@"%@",subView5.subviews);
    //取title和message：
    //    UILabel *title = subView5.subviews[0];
    UILabel *message = subView5.subviews[1];
    message.textAlignment = NSTextAlignmentLeft;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.conversation.type == EMConversationTypeGroupChat) {
        //执行事件
        //定时器用来监听群聊人数的变化
        //定时器开始执行的延时时间
        NSTimeInterval delayTime = 0.0f;
        //定时器间隔时间
        NSTimeInterval timeInterval = 5.0f;//间隔十秒执行一次
        //创建子线程队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //使用之前创建的队列来创建计时器
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        //设置延时执行时间，delayTime为要延时的秒数
        dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
        //设置计时器
        dispatch_source_set_timer(_timer, startDelayTime, timeInterval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_timer, ^{
            //执行事件
            NSLog(@"timer date 1== %@",[NSDate date]);
            EMGroup *group = [[[EMClient sharedClient] groupManager] fetchGroupInfo:self.conversation.conversationId includeMembersList:YES error:nil];
            
            self.onlineNumber = [NSString stringWithFormat:@"%ld",group.occupants.count];

            //主线程刷新UI
            dispatch_sync(dispatch_get_main_queue(), ^{
                //Update UI in UI thread here
                self.onlineLabel.text = [NSString stringWithFormat:@"在线人数：%@人",self.onlineNumber];
                
            });
        });
        // 启动计时器
        dispatch_resume(_timer);
    }

}

- (StealRedBagView *)stealView{
    if (_stealView == nil) {
        StealRedBagView *view = [[StealRedBagView alloc] init];
        _stealView = view;
    }
    return _stealView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.conversation.type == EMConversationTypeGroupChat) {
        dispatch_source_cancel(_timer);
        if (_timer_chaeckOutMax) {
            dispatch_source_cancel(_timer_chaeckOutMax);

        }
    }
}

- (UIView *)topBgView{
    if (_topBgView == nil) {
        UIView *view = [[UIView alloc] init];
        view.userInteractionEnabled = YES;
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 35);
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.7;
        [self.view addSubview:view];
        _topBgView = view;
        
    }
    return _topBgView;
}

- (UIButton *)startGameButton{
    if (_startGameButton == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(self.topBgView.frame.size.width - 90, 5, 80, 25);
        button.backgroundColor = [UIColor orangeColor];
        [button setTitle:@"开始游戏" forState:UIControlStateNormal];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(startGameButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.topBgView addSubview:button];
        _startGameButton = button;
    }
    return _startGameButton;
}

- (void)startGameButtonClicked:(UIButton *)btn{
    NSLog(@"开始游戏按钮被点击");

    if ([self.onlineNumber intValue] < 3) {
        
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前人数小于三人，不能开始游戏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [view show];
    }else{
        //发送红包信息
        [btn setTitle:@"正在游戏" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor grayColor];
        btn.userInteractionEnabled = NO;
        [self publishRedBagChain];
    }

}

- (void)publishRedBagChain{
    //    发送红包的用户信息
    RedpacketUserInfo *redpacketSender = [[RedpacketUserInfo alloc] init];
    NSString *nickName = User_NickName.length>0 ? User_NickName: User_mobile;
    redpacketSender.userNickname = nickName;
    
    redpacketSender.userAvatar = [NSString stringWithFormat:@"%@%@",www,User_Heading];
    
    RedpacketViewModel *redpacket = [[RedpacketViewModel alloc] init];
    redpacket.redpacketOrgName = @"爱抢红包";
    redpacket.redpacketMoney = @"";
    redpacket.redpacketCount = 12;
    redpacket.redpacketGreeting = [NSString stringWithFormat:@"来自%@的红包",nickName];
    
    
    RedpacketMessageModel *model = [[RedpacketMessageModel alloc] init];
    model.redpacketId = self.rid;
    model.conversationID = self.conversation.conversationId;
    model.redpacketSender = redpacketSender;
    model.messageType = RedpacketMessageTypeRedpacket;//红包消息类型
    model.redpacketType =RedpacketTypeAvg;//红包类型
    model.redpacket = redpacket;
    
    
    //--------发送接龙红包--------
    NSString *num = @"";
    if ([self.onlineNumber intValue] > 60) {

        num = @"30";
    }else{
        num = [NSString stringWithFormat:@"%d",[self.onlineNumber intValue]/2 + 1];

    }
    
    NSString *desc = [NSString stringWithFormat:@"来自%@的红包",nickName];
    NSDictionary *param = @{@"uid":User_ID,@"type": type,@"num": num,@"total_amount": total_amount,@"desc": desc};
    [RedBagChainTool publishRedBagChainRedbagWithParam:param successBlock:^(NSString *msg, NSNumber *status, NSString *rid) {
        if ([status intValue] == 1) {
            self.rid = rid;
            [self sendRedPacketMessage:model];
        }
    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

- (UILabel *)onlineLabel{
    if (_onlineLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 0, CGRectGetMinX(self.startGameButton.frame) - 10, 35);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        [self.topBgView addSubview:label];
        _onlineLabel = label;
    }
    return _onlineLabel;
}



#pragma mark - Delegate RedpacketViewControlDelegate
- (void)getGroupMemberListCompletionHandle:(void (^)(NSArray<RedpacketUserInfo *> *))completionHandle
{
    EMGroup *group = [[[EMClient sharedClient] groupManager] fetchGroupInfo:self.conversation.conversationId includeMembersList:YES error:nil];
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    
    for (NSString *username in group.occupants) {
        /** 创建一个用户模型 并赋值 */
        RedpacketUserInfo *userInfo = [self profileEntityWith:username];
        [mArray addObject:userInfo];
    }
    completionHandle(mArray);
}

/** 要在此处根据userID获得用户昵称,和头像地址 */
- (RedpacketUserInfo *)profileEntityWith:(NSString *)userId
{
    RedpacketUserInfo *userInfo = [RedpacketUserInfo new];

    UserProfileEntity *profile = [[UserProfileManager sharedInstance] getUserProfileByUsername:userId];
    if (profile) {
        if (profile.nickname && profile.nickname.length > 0) {
            userInfo.userNickname = profile.nickname;
        } else {
            userInfo.userNickname = userId;
        }
    } else {
        userInfo.userNickname = userId;
    }
    
    userInfo.userAvatar = profile.imageUrl;
    userInfo.userId = userId;

    return userInfo;
}

/** 长时间按在某条Cell上的动作 */
- (BOOL)messageViewController:(EaseMessageViewController *)viewController canLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if ([object conformsToProtocol:NSProtocolFromString(@"IMessageModel")]) {
        id <IMessageModel> messageModel = object;
        NSDictionary *ext = messageModel.message.ext;
        /** 如果是红包，则只显示删除按钮 */
        if ([RedpacketMessageModel isRedpacket:ext]) {
            EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell becomeFirstResponder];
            self.menuIndexPath = indexPath;
            [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:EMMessageBodyTypeCmd];
            return NO;
        }else if ([RedpacketMessageModel isRedpacketTakenMessage:ext]) {
            return NO;
        }
    }
    return [super messageViewController:viewController canLongPressRowAtIndexPath:indexPath];
}

#pragma mrak - 自定义红包的Cell
- (UITableViewCell *)messageViewController:(UITableView *)tableView
                       cellForMessageModel:(id<IMessageModel>)messageModel
{
    NSString *heading = [NSString stringWithFormat:@"%@%@",www,User_Heading];
    NSDictionary *dic;
    if (self.rid.length > 0) {
        dic = @{FromHeading:heading,FromNickName:User_NickName,@"ID":self.rid};
    }else{
        dic = @{FromHeading:heading,FromNickName:User_NickName};
    }
    
    NSDictionary *ext = messageModel.message.ext;

    if ([RedpacketMessageModel isRedpacketRelatedMessage:ext]) {
        if ([RedpacketMessageModel isRedpacket:ext] || [RedpacketMessageModel isRedpacketTransferMessage:ext]) {
            EaseRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:[EaseRedBagCell cellIdentifierWithModel:messageModel]];
            if (!cell) {
                cell = [[EaseRedBagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[EaseRedBagCell cellIdentifierWithModel:messageModel] model:messageModel];
                cell.delegate = self;
            }
            cell.model = messageModel;
            cell.dic = dic;
            cell.bubbleView.isSender = YES;//是消息的发送者db

            if (self.rid.length > 0) {
                cell.tag = [self.rid intValue];
            }
            return cell;
        }
        
        RedpacketTakenMessageTipCell *cell =  [[RedpacketTakenMessageTipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell configWithRedpacketMessageModel:[RedpacketMessageModel redpacketMessageModelWithDic:ext]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)messageViewController:(EaseMessageViewController *)viewController
           heightForMessageModel:(id<IMessageModel>)messageModel
                   withCellWidth:(CGFloat)cellWidth
{
    NSDictionary *ext = messageModel.message.ext;
    if ([RedpacketMessageModel isRedpacket:ext] || [RedpacketMessageModel isRedpacketTransferMessage:ext])    {
        return [EaseRedBagCell cellHeightWithModel:messageModel];
    }else if ([RedpacketMessageModel isRedpacketTakenMessage:ext]) {
        return [RedpacketTakenMessageTipCell heightForRedpacketMessageTipCell];
    }
    return 0;
}

#pragma mark - DataSource
/** 未读消息回执 */
- (BOOL)messageViewController:(EaseMessageViewController *)viewController
shouldSendHasReadAckForMessage:(EMMessage *)message
                         read:(BOOL)read
{
    NSDictionary *ext = message.ext;
    if ([RedpacketMessageModel isRedpacketRelatedMessage:ext]) {
        return YES;
    }
    return [super shouldSendHasReadAckForMessage:message read:read];
}

#pragma mark - 发送红包消息
- (void)messageViewController:(EaseMessageViewController *)viewController didSelectMoreView:(EaseChatBarMoreView *)moreView AtIndex:(NSInteger)index
{
    if (self.conversation.type == EMConversationTypeChat) {
        /** 单聊发送界面 */
        if (index == 5) {
//            [self.viewControl presentRedPacketViewControllerWithType:RPSendRedPacketViewControllerRand memberCount:0];
            PublishChatRedBagViewController *vc = [[PublishChatRedBagViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.redbagType = SingleChatRedBagType;
            [vc setSendGroupChatRedBagBlock:^(NSString *rid,NSString *redBagType){
                self.rid = rid;
                self.sendGroupChatOrSingleRedBag = redBagType;
                [self sendGroupChatRdBad];
                
            }];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            /** 转账页面 */
            RedpacketUserInfo *userInfo = [RedpacketUserInfo new];
            userInfo = [self profileEntityWith:self.conversation.conversationId];
            [self.viewControl presentTransferViewControllerWithReceiver:userInfo];
        }
    }else{
//        NSArray *groupArray = [EMGroup groupWithId:self.conversation.conversationId].occupants;
//        /** 群聊红包发送界面 */
//        [self.viewControl presentRedPacketViewControllerWithType:RPSendRedPacketViewControllerMember memberCount:groupArray.count];
        
        PublishChatRedBagViewController *vc = [[PublishChatRedBagViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.redbagType = GroupChatRedBagType;
        [vc setSendGroupChatRedBagBlock:^(NSString *rid,NSString *redBagType){
            self.rid = rid;
            self.sendGroupChatOrSingleRedBag = redBagType;
            [self sendGroupChatRdBad];
            
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)sendGroupChatRdBad{
    //    发送红包的用户信息
    RedpacketUserInfo *redpacketSender = [[RedpacketUserInfo alloc] init];
    NSString *nickName = User_NickName.length>0 ? User_NickName: User_mobile;
    redpacketSender.userNickname = nickName;
    
    redpacketSender.userAvatar = [NSString stringWithFormat:@"%@%@",www,User_Heading];
    
    RedpacketViewModel *redpacket = [[RedpacketViewModel alloc] init];
    redpacket.redpacketOrgName = @"爱抢红包";
    redpacket.redpacketMoney = @"";
    redpacket.redpacketCount = 12;
    redpacket.redpacketGreeting = [NSString stringWithFormat:@"来自%@的红包",nickName];
    
    
    RedpacketMessageModel *model = [[RedpacketMessageModel alloc] init];
    model.redpacketId = self.rid;
    model.conversationID = self.conversation.conversationId;
    model.redpacketSender = redpacketSender;
    model.messageType = RedpacketMessageTypeRedpacket;//红包消息类型
    model.redpacketType =RedpacketTypeAvg;//红包类型
    model.redpacket = redpacket;
    
    [self sendRedPacketMessage:model];
}
#pragma mark - 发送红包消息
- (void)sendRedPacketMessage:(RedpacketMessageModel *)model
{
    NSDictionary *dic = [model redpacketMessageModelToDic];
    [dic setValue:self.rid forKey:@"ID"];
    
    NSString *heading = [NSString stringWithFormat:@"%@%@",www,User_Heading];
    [dic setValue:heading forKey:FromHeading];
    [dic setValue:User_NickName forKey:FromNickName];
    NSString *message;
    if ([RedpacketMessageModel isRedpacketTransferMessage:dic]) {
        message = [NSString stringWithFormat:@"[转账]转账%@元",model.redpacket.redpacketMoney];
    }else {
        message = [NSString stringWithFormat:@"[%@]%@", model.redpacket.redpacketOrgName, model.redpacket.redpacketGreeting];
    }
    
    [self sendTextMessage:message withExt:dic];
}

#pragma mark -  发送红包被抢的消息
- (void)sendRedpacketHasBeenTaked:(RedpacketMessageModel *)messageModel
{
    NSString *currentUser = [EMClient sharedClient].currentUsername;
    NSString *senderId = messageModel.redpacketSender.userId;
    NSString *conversationId = self.conversation.conversationId;
    NSMutableDictionary *dic = [messageModel.redpacketMessageModelToDic mutableCopy];
    /** 忽略推送 */
    [dic setValue:@(YES) forKey:@"em_ignore_notification"];
    NSString *text = [NSString stringWithFormat:@"你领取了%@发的红包", messageModel.redpacketSender.userNickname];
    if (self.conversation.type == EMConversationTypeChat) {
        [self sendTextMessage:text withExt:dic];
    }else{
        if ([senderId isEqualToString:currentUser]) {
            text = @"你领取了自己的红包";
        }else {
            /** 如果不是自己发的红包，则发送抢红包消息给对方 */
            [[EMClient sharedClient].chatManager sendMessage:[self createCmdMessageWithModel:messageModel] progress:nil completion:nil];
        }
        EMTextMessageBody *textMessageBody = [[EMTextMessageBody alloc] initWithText:text];
        EMMessage *textMessage = [[EMMessage alloc] initWithConversationID:conversationId from:currentUser to:conversationId body:textMessageBody ext:dic];
        textMessage.chatType = (EMChatType)self.conversation.type;
        textMessage.isRead = YES;
        /** 刷新当前聊天界面 */
        [self addMessageToDataSource:textMessage progress:nil];
        /** 存入当前会话并存入数据库 */
        [self.conversation insertMessage:textMessage error:nil];
    }
}

- (EMMessage *)createCmdMessageWithModel:(RedpacketMessageModel *)model
{
    NSMutableDictionary *dict = [model.redpacketMessageModelToDic mutableCopy];
    
    NSString *currentUser = [EMClient sharedClient].currentUsername;
    NSString *toUser = model.redpacketSender.userId;
    EMCmdMessageBody *cmdChat = [[EMCmdMessageBody alloc] initWithAction:RedpacketKeyRedapcketCmd];
    EMMessage *message = [[EMMessage alloc] initWithConversationID:self.conversation.conversationId from:currentUser to:toUser body:cmdChat ext:dict];
    message.chatType = EMChatTypeChat;
    
    return message;
}

#pragma mark - EaseMessageCellDelegate 单击了Cell 事件
- (void)messageCellSelected:(id<IMessageModel>)model
{
    NSDictionary *dict = model.message.ext;
    if ([RedpacketMessageModel isRedpacket:dict]) {
//        [self.viewControl redpacketCellTouchedWithMessageModel:[self toRedpacketMessageModel:model]];
        NSDictionary *param = @{@"uid":User_ID,@"rid":dict[@"ID"]};
        if ([self.sendGroupChatOrSingleRedBag isEqualToString:@"groupChatOrSingle"]) {
            //----------抢群聊红包
            [RedBagChainTool doGroupChatRedbagWithParam:param successBlock:^(NSString *msg, NSNumber *status, NSString *price) {
                if ([status intValue] == 1) {
                     [self.stealView configViewWithStatus:[status intValue] Moeny:price andNickName:User_NickName andImageName:[NSString stringWithFormat:@"%@%@",www,User_Heading]];
                }else{
                    [self showHint:msg];
                    
                    //跳转到红包详情页
                    RedBagChainResultViewController *vc = [[RedBagChainResultViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.rid = dict[@"ID"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
            } errorBlock:^(NSError *error) {
                
                [self showHint:@"网络错误"];
            }];
            
            
        }else{
            //----------抢接龙红包
            [RedBagChainTool doChainRedBagWithParam:param successBlock:^(NSString *msg, NSNumber *status, NSString *price) {
                if ([status intValue] == 1) {
                    
                    [self.stealView configViewWithStatus:[status intValue] Moeny:price andNickName:User_NickName andImageName:[NSString stringWithFormat:@"%@%@",www,User_Heading]];
                    
                    //抢过红包之后，开启计时器查询是否是最大 最大的要发红包
                    
                    //定时器开始执行的延时时间
                    NSTimeInterval delayTime = 30.0f;
                    //定时器间隔时间
                    NSTimeInterval timeInterval = 30.0f;//间隔十秒执行一次
                    //创建子线程队列
                    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    //使用之前创建的队列来创建计时器
                    self.timer_chaeckOutMax = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
                    //设置延时执行时间，delayTime为要延时的秒数
                    dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
                    //设置计时器
                    dispatch_source_set_timer(self.timer_chaeckOutMax, startDelayTime, timeInterval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
                    dispatch_source_set_event_handler(self.timer_chaeckOutMax, ^{
                        //执行事件
                        NSLog(@"timer date 1== %@",[NSDate date]);
                        
                        //----------定时查询抢到红包最大者ID
                        [RedBagChainTool checkoutRedBagMaxIDWithParam:param successBlock:^(NSString *msg, NSNumber *status,NSString *uid){
                            
                            if ([uid isEqualToString:User_ID]) {
                                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"本次抢夺红包，您的结算金额最大，成为下轮游戏的金主！请在30秒内发送红包，否则系统将自动为您发送红包" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                                view.tag = 101;
                                [view show];
                                self.isYourTurnToSendRedBag = YES;
                            }else{
                                self.isYourTurnToSendRedBag = NO;
                            }
                            
                        } errorBlock:^(NSError *error) {
                            [self showHint:@"网络错误"];
                        }];
                        
                        //主线程刷新UI
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            //Update UI in UI thread here
                            
                            
                        });
                    });
                    // 启动计时器
                    dispatch_resume(self.timer_chaeckOutMax);
                    
                }else{
                    if ([msg isEqualToString:@"您已抢此红包"]) {
                        [self showHint:msg];
                        
                        //跳转到红包详情页
                        RedBagChainResultViewController *vc = [[RedBagChainResultViewController alloc] init];
                        vc.hidesBottomBarWhenPushed = YES;
                        vc.rid = dict[@"ID"];
                        [self.navigationController pushViewController:vc animated:YES];
                    }else{
                        [self showHint:msg];
                        
                        //跳转到红包详情页
                        RedBagChainResultViewController *vc = [[RedBagChainResultViewController alloc] init];
                        vc.hidesBottomBarWhenPushed = YES;
                        vc.rid = dict[@"ID"];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                }
            } errorBlock:^(NSError *error) {
                [self showHint:@"网络错误"];
            }];

        }
        
    }else if([RedpacketMessageModel isRedpacketTransferMessage:dict]) {
        [self.viewControl presentTransferDetailViewController:[RedpacketMessageModel redpacketMessageModelWithDic:dict]];
    }else {
        [super messageCellSelected:model];
    }
    
}

- (void)backAction{
    
    if (self.isYourTurnToSendRedBag) {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您已经参加本轮游戏，且是本轮游戏的最大金主，请继续游戏，如果强行退出，将不再归还押金" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        view.tag = 100;
        [view show];
    }else{
        //正常退出  退换押金
        [super backAction];
        
        if (type.length > 0) {
            NSDictionary *param = @{@"uid":User_ID, @"type": type};
            [RedBagChainTool returnDepositWithParam:param successBlock:^(NSString *msg, NSNumber *status) {
                
                [self showHint:msg];
                
            } errorBlock:^(NSError *error) {
                [self showHint:@"网错错误"];
            }];
        }
        
        
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{


//    if (alertView.tag == 100) {//归还押金提示
//        if (buttonIndex == 1) {//扣除押金
//            [super backAction];
//            
//
//        }else{
//            
//        }
//        
//    }
    
    if (alertView.tag == 105) {//删除聊天记录
        
        if (buttonIndex == 1) {
            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId isDeleteMessages:YES completion:nil];

            [self.dataArray removeAllObjects];
            
            [self.tableView reloadData];

        }
        
    }
    
    if (alertView.tag == 101) {//继续红包接龙提示
        
        if (buttonIndex == 0) {
            dispatch_source_cancel(_timer_chaeckOutMax);

            [self performSelector:@selector(systemSendRedBag) withObject:nil afterDelay:30];
        }else{
            [self publishRedBagChain];

        }
        
    }
}

- (void)systemSendRedBag{
    [self publishRedBagChain];

}

- (RedpacketMessageModel *)toRedpacketMessageModel:(id <IMessageModel>)model
{
    RedpacketMessageModel *messageModel = [RedpacketMessageModel redpacketMessageModelWithDic:model.message.ext];
    if (self.conversation.type == EMConversationTypeGroupChat) {
        messageModel.redpacketSender = [self profileEntityWith:model.message.from];
        messageModel.toRedpacketReceiver = [self profileEntityWith:messageModel.toRedpacketReceiver.userId];
    }else{
        messageModel.redpacketSender = [self profileEntityWith:model.message.from];
    }
    return messageModel;
}

@end
