//
//  RedBagChainViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/23.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "RedBagChainViewController.h"
#import "InPutPasswordview.h"
#import "RedBagChainTool.h"
#import "RedPacketChatViewController.h"
#import "ChatViewController.h"
#import "DBWebViewViewController.h"
#import "PasswordViewController.h"
#define LeftAndRightGap 30
#define TopAndBottomGap 50
#define ImageWidth (SCREEN_WIDTH - LeftAndRightGap * 3)/2
#define ImageHeight (SCREEN_HEIGHT - 64 - TopAndBottomGap * 3)/2


@interface RedBagChainViewController ()<UIAlertViewDelegate>

@property (nonatomic, weak) UIImageView *bgImageView;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, weak) UIView *blackview;
@property (nonatomic, weak) InPutPasswordview *contentView;


@property (nonatomic, strong) NSArray *publickGroupListArray;

@end

@implementation RedBagChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadPublickGroup];
    [self setupUI];
    [self bgImageView];
    [self createUI];

}



- (NSArray *)publickGroupListArray{
    if (_publickGroupListArray == nil) {
        NSArray *array = [NSArray array];
        _publickGroupListArray = array;
    }
    return _publickGroupListArray;
}
- (void)loadPublickGroup{
    //获取公开群的数组
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        EMCursorResult *result = [[EMClient sharedClient].groupManager getPublicGroupsFromServerWithCursor:nil pageSize:-1 error:&error];
        NSArray *publickGrouprray = result.list;
        
        EMGroup *oneGroup;
        EMGroup *twoGroup;
        EMGroup *threeGroup;
        EMGroup *fourGroup;
        for (int i = 0; i< publickGrouprray.count; i++) {
            EMGroup *group = publickGrouprray[i];
            
            if ([group.groupId isEqualToString:OneGroupId]) {
                oneGroup = group;
                
                //退出群聊
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
                    EMError *error = nil;
                    [[EMClient sharedClient].groupManager leaveGroup:group.groupId error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error) {
                            
                        }else{
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitGroup" object:nil];
                        }
                    });
                });
                
            }
            
            if ([group.groupId isEqualToString:TwoGroupId]) {
                twoGroup = group;
                //退出群聊
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
                    EMError *error = nil;
                    [[EMClient sharedClient].groupManager leaveGroup:group.groupId error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error) {
                            
                        }else{
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitGroup" object:nil];
                        }
                    });
                });
            }
            
            if ([group.groupId isEqualToString:ThreeGroupId]) {
                threeGroup = group;
                //退出群聊
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
                    EMError *error = nil;
                    [[EMClient sharedClient].groupManager leaveGroup:group.groupId error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error) {
                            
                        }else{
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitGroup" object:nil];
                        }
                    });
                });
            }
            
            if ([group.groupId isEqualToString:FourGroupId]) {
                fourGroup = group;
                //退出群聊
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
                    EMError *error = nil;
                    [[EMClient sharedClient].groupManager leaveGroup:group.groupId error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error) {
                            
                        }else{
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitGroup" object:nil];
                        }
                    });
                });
            }
        }
        
        self.publickGroupListArray = @[oneGroup,twoGroup,threeGroup,fourGroup];
        //三元群组  15711465439233
        //五元群组  15711490605057
        //一元群组   15710997774339
        //0.5元群组 15711408816129
    });
}

- (UIView *)blackview{
    if (_blackview == nil) {
        UIView *view = [[UIView alloc] init];
        view.userInteractionEnabled = YES;
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.7;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackViwClicked)];
        [view addGestureRecognizer:tap];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        _blackview = view;
    }
    return _blackview;
}

- (void)blackViwClicked{
    [self.contentView.passwordView.textField resignFirstResponder];
    [self.blackview removeFromSuperview];
    [self.contentView removeFromSuperview];
}

- (InPutPasswordview *)contentView{
    if (_contentView == nil) {
        InPutPasswordview *contentView = [InPutPasswordview viewWithFrame:CGRectMake(20, SCREEN_HEIGHT/4, SCREEN_WIDTH - 40, (SCREEN_WIDTH - 40)/6 + 150)];
        [[UIApplication sharedApplication].keyWindow addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        imageView.image = [UIImage imageNamed:@"redBagBGview"];
        imageView.userInteractionEnabled = YES;
        [self.view addSubview:imageView];
        _bgImageView = imageView;
    }
    return _bgImageView;
}

- (void)setupUI{
    self.title = @"红包接龙";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tips"] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItemClicked)];
    self.navigationItem.rightBarButtonItem = item;
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

- (void)createUI{
    
    NSArray *imageNameArray = @[@"new_area",@"low_area",@"middle_area",@"height_area"];
    for (int i = 0; i<imageNameArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(LeftAndRightGap + (LeftAndRightGap + ImageWidth) * (i%2), TopAndBottomGap + (TopAndBottomGap + ImageHeight) * (i/2), ImageWidth, ImageHeight);
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];

        [imageView addGestureRecognizer:tap];
        
        imageView.image = [UIImage imageNamed:imageNameArray[i]];
        
        [self.view addSubview:imageView];
        
        
    }
}

- (void)imageViewClicked:(UITapGestureRecognizer *)tap{
    if ([User_pay_password intValue] == 1) {
        NSLog(@"已经设置支付密码");
        self.tag = tap.view.tag;
        
        NSString *moneyStr = @"";
        
        if (tap.view.tag == 100) {
            moneyStr = @"0.5";
        }else if (tap.view.tag == 101){
            moneyStr = @"1.0";
        }else if (tap.view.tag == 102){
            moneyStr = @"3.0";
        }else{
            moneyStr = @"5.0";
        }
        
        NSString *messageStr = [NSString stringWithFormat:@"进入本群需要支付¥%@元押金，押金将在退出群组时返回到您的余额。",moneyStr];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];

    }else{
        [self showHint:@"请先设置支付密码"];
        NSLog(@"设置支付密码");
        PasswordViewController *vc = [[PasswordViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSLog(@"确定");
        
        
        [self performSelector:@selector(showView) withObject:self afterDelay:0.5];
        
        
    }
}

- (void)showView{
    [self blackview];
    NSString *moneyStr = @"";
    if (self.tag == 100) {
        moneyStr = @"0.5";
    }else if (self.tag == 101){
        moneyStr = @"1.0";
    }else if (self.tag == 102){
        moneyStr = @"3.0";
    }else{
        moneyStr = @"5.0";
    }
    [self.contentView.passwordView.textField becomeFirstResponder];
    self.contentView.moneyLabel.text = [NSString stringWithFormat:@"¥%@",moneyStr];
    [self.contentView setCancelButtonBlock:^{
        [self.contentView.passwordView.textField resignFirstResponder];
        [self.blackview removeFromSuperview];
        [self.contentView removeFromSuperview];
    }];
    
    [self.contentView.passwordView setSixNumberBlock:^(NSString *password){
        [self loadPasswordRequestWirhPassword:password andType:moneyStr];
    }];
}

- (void)loadPasswordRequestWirhPassword:(NSString *)password andType:(NSString *)money{
    NSString *type;
    int index = 0;
    
    if ([money isEqualToString:@"0.5"]) {
        type = @"1";
        index = 0;
    }
    
    if ([money isEqualToString:@"1.0"]) {
        type = @"2";
        index = 1;
    }
    
    if ([money isEqualToString:@"3.0"]) {
        type = @"3";
        index = 2;
    }
    
    if ([money isEqualToString:@"5.0"]) {
        type = @"4";
        index = 3;
    }
    NSDictionary *param = @{@"uid":User_ID,@"pay_password":password};
    [RedBagChainTool checkPayPasswordWithParam:param successBlock:^(NSString *msg,NSNumber *status) {
       
        [self.contentView.passwordView.textField resignFirstResponder];
        [self.blackview removeFromSuperview];
        [self.contentView removeFromSuperview];
        
        if ([status isEqualToNumber:@1]) {
            
            NSDictionary *param = @{@"uid":User_ID,@"type":type};
            [RedBagChainTool redBagChainPaymentDepositWithParam:param successBlock:^(NSString *msg, NSNumber *status) {
                [self showHint:msg];
                if ([status intValue] == 1) {
//                    支付押金成功
                    //进去群组
                    EMGroup *group = self.publickGroupListArray[index];
                    
                    [self showHudInView:self.view hint:NSLocalizedString(@"group.join.ongoing", @"join the group...")];
                    __weak RedBagChainViewController *weakSelf = self;
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        EMError *error = nil;
                        [[EMClient sharedClient].groupManager joinPublicGroup:group.groupId error:&error];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf hideHud];
                            if(!error) {

                                UIViewController *chatController = nil;
#ifdef REDPACKET_AVALABLE
                                chatController = [[RedPacketChatViewController alloc] initWithConversationChatter:group.groupId conversationType:EMConversationTypeGroupChat];
                                
#else
     
                                chatController = [[ChatViewController alloc] initWithConversationChatter:group.groupId conversationType:EMConversationTypeGroupChat];
                            
#endif
                                chatController.title = group.subject;
                                chatController.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:chatController animated:YES];
                            
                            } else {
                                [weakSelf showHint:NSLocalizedString(@"group.join.fail", @"again failed to join the group, please")];
                            }
                        });
                    });
                    

                }else{
                    [self showHint:msg];
                }
            } errorBlock:^(NSError *error) {
                [self showHint:@"网络错误"];
            }];
        }else{
            [self showHint:msg];
        }
        
    } errorBlock:^(NSError *error) {
        
        [self showHint:@"网络错误"];
    }];
    
    
}
@end
