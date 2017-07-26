//
//  RecommendViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/18.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "RecommendViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#define GAP 20
#define imageViewWidth (SCREEN_WIDTH - 5 * GAP)/4
@interface RecommendViewController ()

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorTableViewBg;
    self.title =@"我要推荐";
    
    [self createUI];
}

- (void)createUI{
    
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"分享至：";
    label.frame = CGRectMake(20, 40, 100, 30);
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    NSArray *imageArray = @[@"sns_icon_22",@"sns_icon_23",@"sns_icon_24",@"sns_icon_6"];
    for (int i = 0; i<imageArray.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = 100 + i;

        [button setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        button.frame = CGRectMake(20 + (imageViewWidth + 20)*i, 160, imageViewWidth, imageViewWidth);

        [button addTarget:self action:@selector(imageViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    
    }
    
}

- (void)imageViewClicked:(UIButton *)btn{
    switch (btn.tag) {
        case 100:
            NSLog(@"微信好友");
            [self shareWitType:SSDKPlatformSubTypeWechatSession];
            break;
           
        case 101:
            NSLog(@"朋友圈");
            [self shareWitType:SSDKPlatformSubTypeWechatTimeline];
            break;
            
        case 102:
            NSLog(@"qq");
            [self shareWitType:SSDKPlatformSubTypeQQFriend];
            break;
        case 103:
            NSLog(@"qq空间");
            [self shareWitType:SSDKPlatformSubTypeQZone];
            
            break;

        default:
            break;
    }
}

- (void)shareWitType:(SSDKPlatformType)platformType{
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"aq_icon 1360"]];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"我在爱抢APP上抢红包，你也一起来玩吧！"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://47.93.114.245/aiqiang/"]
                                          title:@"爱抢"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        
        [ShareSDK share:platformType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            
            switch (state)
            {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@",error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }
                default:
                    break;
            }

            
        }];
//        //2、分享（可以弹出我们的分享菜单和编辑界面）
//        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
//                                 items:nil
//                           shareParams:shareParams
//                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                       
//                       switch (state)
//                       {
//                           case SSDKResponseStateSuccess:
//                           {
//                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                   message:nil
//                                                                                  delegate:nil
//                                                                         cancelButtonTitle:@"确定"
//                                                                         otherButtonTitles:nil];
//                               [alertView show];
//                               break;
//                           }
//                           case SSDKResponseStateFail:
//                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                               message:[NSString stringWithFormat:@"%@",error]
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"OK"
//                                                                     otherButtonTitles:nil, nil];
//                               [alert show];
//                               break;
//                           }
//                           default:
//                               break;
//                       }
//                   }
//         ];
    }
    
}

@end
