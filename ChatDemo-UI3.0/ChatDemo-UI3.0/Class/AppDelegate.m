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

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "AppDelegate+EaseMob.h"
#import "AppDelegate+UMeng.h"
#import "AppDelegate+Parse.h"
#import "RedPacketUserConfig.h"
#import <UserNotifications/UserNotifications.h>
#import "GeTuiSdk.h"
#import "LaunchIntroductionView.h"
#import "DrawCircleProgressButton.h"
#import <AlipaySDK/AlipaySDK.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
//新浪微博SDK头文件
//#import "WeiboSDK.h"
////新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

//============================================

//环信appkey
#define EaseMobAppKey       @"qq345890076#redbag"

//shareSDK
#define ShareSDKAppKey      @"1e3fbc008e630"
#define ShareSDKQQAPPID     @"1104815953"
#define ShareSDKQQAPPKey    @"uyV5ClrPVcy7utZZ"
#define ShareSDKWeChatAppID @"wx152259646f30ac77"
#define ShareSDKWeChatAppKey @"3452a4ead7b726796f5972882daff829"

/// 个推开发者网站中申请App时，注册的AppId、AppKey、AppSecret
#define kGtAppId            @"xrthZx8EKi53I4a1Z8w2V6"
#define kGtAppKey           @"8AxGAcF0ob8zRysS9EswU8"
#define kGtAppSecret        @"H0XQIXnyPh8qDUZrFuHhs2"

@interface AppDelegate () <UNUserNotificationCenterDelegate, GeTuiSdkDelegate, WXApiDelegate>

{
    NSInteger page;
    int second;
    
}

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) DrawCircleProgressButton *drawCircleView;
@property (nonatomic, strong) NSTimer *time;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    
    
    //设置引导页
//    [self setupGuidePage];

    //初始化个推SDK
    [self initGeTuiSDK];
    
    //初始化环信SDK
    [self initHuanXinSDKWith:application andOptions:launchOptions];
    

    //初始化shareSDK
    [self initShareSDK];

    [self.window makeKeyAndVisible];


    //设置启动页
    [self setupLanchImageView];
    
    //初始化微信支付
//    [self initWeChatPay];
    return YES;
}

- (void)initWeChatPay{
    [WXApi registerApp:@""];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [WXApi handleOpenURL:url delegate:self];
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [WXApi handleOpenURL:url delegate:self];
//    
//    
//    
//}

- (void)setupLanchImageView{
    
    second = 3;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = [UIScreen mainScreen].bounds;
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.image = [UIImage imageNamed:@"aq_lanch6"];
    [self.window addSubview:imageView];
    [self.window bringSubviewToFront:imageView];
    self.imageView = imageView;
    
    
    DrawCircleProgressButton *drawCircleView = [[DrawCircleProgressButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 55, 30, 30, 30)];
    drawCircleView.lineWidth = 2;
    [drawCircleView setTitle:@"3s" forState:UIControlStateNormal];
    [drawCircleView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    drawCircleView.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [drawCircleView addTarget:self action:@selector(removeProgress) forControlEvents:UIControlEventTouchUpInside];
    
    /**
     *  progress 完成时候的回调
     */
    [drawCircleView startAnimationDuration:3 withBlock:^{
        [drawCircleView removeFromSuperview];
    }];
    
    [self.imageView addSubview:drawCircleView];
    
    self.drawCircleView = drawCircleView;
    
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(action) userInfo:nil repeats:YES];
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(action) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

    self.time = timer;
    
}

- (void)action{
    second --;

    [self.drawCircleView setTitle:[NSString stringWithFormat:@"%ds",second] forState:UIControlStateNormal];
    
    if (second == 0) {
        [self.time invalidate];
        [self.drawCircleView removeFromSuperview];

        [self.imageView removeFromSuperview];
    }
    
}

- (void)removeProgress{
    [self.drawCircleView removeFromSuperview];
    [self.imageView removeFromSuperview];
    [self.time invalidate];
}


- (void)setupGuidePage{
    
    NSArray *imageNameArray = @[@"guidePageOne",@"guidePageTwo",@"guidePageThree"];
    [LaunchIntroductionView sharedWithImages:imageNameArray];
    
#if 1
    [LaunchIntroductionView sharedWithImages:imageNameArray];
#elif 0
    [LaunchIntroductionView sharedWithImages:imageNameArray buttonImage:@"login" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
#elif 0
    LaunchIntroductionView *launch = [LaunchIntroductionView sharedWithImages:imageNameArray buttonImage:@"login" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
    launch.currentColor = [UIColor redColor];
    launch.nomalColor = [UIColor greenColor];
#else
    //只有在存在该storyboard时才调用该方法，否则会引起crash
    [LaunchIntroductionView sharedWithStoryboard:@"Main" images:imageNameArray buttonImage:@"login" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
#endif

}

- (void)initShareSDK{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:ShareSDKAppKey
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeRenren),
                            @(SSDKPlatformTypeGooglePlus)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
//             case SSDKPlatformTypeSinaWeibo:
//                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                 break;
//             case SSDKPlatformTypeRenren:
//                 [ShareSDKConnector connectRenren:[RennClient class]];
//                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:ShareSDKWeChatAppID
                                       appSecret:ShareSDKWeChatAppKey];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:ShareSDKQQAPPID
                                      appKey:ShareSDKQQAPPKey
                                    authType:SSDKAuthTypeBoth];
                 break;
//             case SSDKPlatformTypeRenren:
//                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
//                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
//                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
//                                               authType:SSDKAuthTypeBoth];
//                 break;
//             case SSDKPlatformTypeGooglePlus:
//                 [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
//                                           clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
//                                            redirectUri:@"http://localhost"];
//                 break;
             default:
                 break;
         }
     }];
}

- (void)initHuanXinSDKWith:(UIApplication *)application andOptions:(NSDictionary *)launchOptions{
    //环信--------------------------------------------------
#ifdef REDPACKET_AVALABLE
    /**
     *  TODO: 通过环信的AppKey注册红包
     */
    [[RedPacketUserConfig sharedConfig] configWithAppKey:EaseMobAppKey];
#endif
    
    _connectionState = EMConnectionConnected;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 环信UIdemo中有用到友盟统计crash，您的项目中不需要添加，可忽略此处。
    [self setupUMeng];
    
    // 环信UIdemo中有用到Parse，您的项目中不需要添加，可忽略此处。
    [self parseApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    // Init SDK，detail in AppDelegate+EaseMob.m
    // SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
#if DEBUG
    //    apnsCertName = @"chatdemoui_dev";
    apnsCertName = @"aiqiang_push_development";
#else
    apnsCertName = @"chatdemoui";
#endif
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *appkey = EaseMobAppKey;
    if (!appkey) {
        appkey = EaseMobAppKey;
        [ud setObject:appkey forKey:@"identifier_appkey"];
    }
    
    [self easemobApplication:application
didFinishLaunchingWithOptions:launchOptions
                      appkey:appkey
                apnsCertName:apnsCertName
                 otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];

}

- (void)initGeTuiSDK{
    //使用个推初始化-------------------------------------------
    
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    // 注册 APNs
    [self registerRemoteNotification];
    
//是否允许SDK 后台运行（这个一定要设置，否则后台apns不会执行）
    [GeTuiSdk runBackgroundEnable:true];
    
    
    
    //重置角标计数
    page=0;
    [GeTuiSdk resetBadge];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:page];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    

}

/** 注册用户通知 APNs */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound |UIRemoteNotificationTypeBadge);
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}


//-----收到远程通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (_mainController) {
        [_mainController jumpToChatList];
    }
    [self easemobApplication:application didReceiveRemoteNotification:userInfo];
    
    application.applicationIconBadgeNumber = 0; // 标签
    
    NSLog(@"\n>>>[Receive RemoteNotification]:%@\n\n", userInfo);
    
}

/** 已登记用户通知 */
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // 注册远程通知（推送）
    [application registerForRemoteNotifications];
}

//* APP已经接收到“远程”通知(推送) - 透传推送消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    // 处理APNs代码，通过userInfo可以取到推送的信息（包括内容，角标，自定义参数等）。如果需要弹窗等其他操作，则需要自行编码。
    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    NSString *sysmsgOrcircle = userInfo[@"act"];
    NSDictionary *object = @{@"type" : sysmsgOrcircle, @"isShow" : @"1"};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowSysMsgOrCiecleRedView" object:object];
    
    if ([sysmsgOrcircle isEqualToString:@"sysmsg"]) {
        
    }
    
    if ([sysmsgOrcircle isEqualToString:@"circle"]) {
        
    }
    
    //静默推送收到消息后也需要将APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    
    [self performSelector:@selector(addBadge) withObject:self afterDelay:1];
}

- (void)addBadge{
    //设置角标
    page+=1;
    [GeTuiSdk setBadge:page];
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:page];  //可用全局变量累加消息
}

//---- -收到本地通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (_mainController) {
        [_mainController didReceiveLocalNotification:notification];
    }
}

#pragma mark - UNUserNotificationCenterDelegate 代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    [self easemobApplication:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
    
    NSLog(@"willPresentNotification：%@", notification.request.content.userInfo);
    
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
    
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    if (_mainController) {
        [_mainController didReceiveUserNotification:response.notification];
    }
    completionHandler();
    
    
    NSLog(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    
    completionHandler();
    
}

//后台刷新数据
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    /// Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - GeTuiSdkdelegate 注册回调，获取CID信息

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:clientId forKey:@"client_id"];
    [defaults synchronize];
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    //个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

//a个推透传消息通道---在线
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    
    // [4]: 收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"消息" message:payloadMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [view show];
        
        
    }
    
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@", taskId, msgId, payloadMsg, offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    
    
    
    
}

/** SDK收到sendMessage消息回调 */
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // 发送上行消息结果反馈
    NSString *msg = [NSString stringWithFormat:@"sendmessage=%@,result=%d", messageId, result];
    NSLog(@"\n>>[GTSdk DidSendMessage]:%@\n\n", msg);
}

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // 通知SDK运行状态
    NSLog(@"\n>>[GTSdk SdkState]:%u\n\n", aStatus);
}

/** SDK设置推送模式回调 */
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
    if (error) {
        NSLog(@"\n>>[GTSdk SetModeOff Error]:%@\n\n", [error localizedDescription]);
        return;
    }
    
    NSLog(@"\n>>[GTSdk SetModeOff]:%@\n\n", isModeOff ? @"开启" : @"关闭");
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
     [application setApplicationIconBadgeNumber:0];
}

-  (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    [GeTuiSdk resetBadge];
    page = 0;
    [application setApplicationIconBadgeNumber:0];
}


//支付宝
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    
    
    //调用其他SDK，例如支付宝SDK等
    /**
     *跳转支付宝钱包进行支付，处理支付结果
     */
    if([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary*resultDic) {
            NSLog(@"result safepay = %@",resultDic);
        }];
    }
    if([url.host isEqualToString:@"platformapi"]) {
        [[AlipaySDK defaultService]processOrderWithPaymentResult:url standbyCallback:^(NSDictionary*resultDic) {
            NSLog(@"result platformapi = %@",resultDic);
        }];
    }
    //微信的支付回调
    if([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }

    
    
    
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    
    //微信的支付回调
    if([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }

    
    return YES;
}



- (void)onResp:(BaseResp*)resp
{
    NSString* strMsg = [NSString stringWithFormat:@"errorCode: %d",resp.errCode];
    NSLog(@"strMsg: %@",strMsg);
    NSString* errStr= [NSString stringWithFormat:@"errStr: %@",resp.errStr];
    NSLog(@"errStr: %@",errStr);
    NSString* strTitle;
    //判断是微信消息的回调
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息的结果"];
    }
    NSString* wxPayResult;
    //判断是否是微信支付回调(注意是PayResp而不是PayReq)
    if([resp isKindOfClass:[PayResp class]])
    {
        //支付返回的结果,实际支付结果需要去微信服务器端查询
        strTitle = @"支付结果";
        switch(resp.errCode)
        {
            caseWXSuccess:
            {
                strMsg =@"支付结果:";
                NSLog(@"支付成功: %d",resp.errCode);
                wxPayResult =@"success";
                break;
            }
            caseWXErrCodeUserCancel:
            {
                strMsg =@"用户取消了支付";
                NSLog(@"用户取消支付: %d",resp.errCode);
                wxPayResult =@"cancle";
                break;
            }
            default:
            {
                strMsg = [NSString stringWithFormat:@"支付失败! code: %derrorStr: %@",resp.errCode,resp.errStr];
                NSLog(@":支付失败: code: %d str: %@",resp.errCode,resp.errStr);
                wxPayResult =@"faile";
                break;
            }
        }
        //发出通知
        NSNotification* notification = [NSNotification notificationWithName:@"WXPay"object:wxPayResult];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
    }
}


@end
