//
//  DBShareView.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/9.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBShareView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#define imageGAP 30
#define imageViewWidth (SCREEN_WIDTH - 5 * imageGAP)/4

#define labelGAP 15
#define labelWidth (SCREEN_WIDTH - 5 * labelGAP)/4

@interface DBShareView ()

@property (nonatomic, copy) NSString *contentText;

@end

@implementation DBShareView


+ (DBShareView *)viewWithFrame:(CGRect)frame andShareType:(int)type andMoney:(NSString *)money{
    DBShareView *shareview = [[DBShareView alloc] init];
    shareview.frame = frame;
    shareview.backgroundColor = [UIColor whiteColor];
    
    if (type == 1) {//我要推荐
        shareview.contentText = @"我在爱抢APP上抢红包，你也一起来玩吧！";
    }
    
    if (type == 2) {//偷抢好友红包
        shareview.contentText = [NSString stringWithFormat:@"我在爱抢APP里偷到好友\"%.2f\"元，快来跟我一起偷好友红包吧！",[money floatValue]];

    }
    
    if (type == 3) {//全民红包
        shareview.contentText = [NSString stringWithFormat:@"我在爱抢APP的全民红包抢到\"%.2f\"元，快来跟我一起抢红包吧！",[money floatValue]];
    }
    
    if (type == 4) {//特约红包
        shareview.contentText = [NSString stringWithFormat:@"我在爱抢APP的特约红包抢到\"%.2f\"元，快来跟我一起抢红包吧！",[money floatValue]];
    }
    
    if (type == 5) {//分享评论和点赞
        shareview.contentText = @"我在爱抢APP上发表了一篇动态，快来点赞和评论吧！";
    }
    
    [shareview createUI];
    
    return shareview;
    
}

- (void)createUI{
        
    NSArray *imageArray = @[@"sns_icon_22",@"sns_icon_23",@"sns_icon_24",@"sns_icon_6"];
    
    NSArray *titleArray = @[@"微信好友",@"微信朋友圈",@"QQ好友",@"QQ空间"];
    for (int i = 0; i<imageArray.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = 100 + i;
        
        [button setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        button.frame = CGRectMake(imageGAP + (imageViewWidth + imageGAP)*i, 10, imageViewWidth, imageViewWidth);
        
        [button addTarget:self action:@selector(imageViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(labelGAP + (labelWidth + labelGAP)*i, CGRectGetMaxY(button.frame) + 10, labelWidth, 20);
        label.text = titleArray[i];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
        
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
        [shareParams SSDKSetupShareParamsByText:self.contentText
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
