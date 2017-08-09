//
//  ChongZhiViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/16.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "ChongZhiViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "RSADataSigner.h"
#import "MyAccountTool.h"

#define AliPayAppScheme @"aiQiangAliPayScheme"

@interface ChongZhiViewController ()

@property (nonatomic, weak) UILabel *firstLabel;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UILabel *rightlabel;
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, copy) NSString *textFieldText;

@end

@implementation ChongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self firstLabel];
    [self textField];
    [self rightlabel];
    [self button];
}

- (void)setupUI{
    self.view.backgroundColor = ColorTableViewBg;
    self.title = @"充值";
}

- (void)setType:(int)type{
    _type = type;
  
}

- (UILabel *)firstLabel{
    if (_firstLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 20, 100, 40);
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"    充值金额";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = DBMaxFont;
        label.textColor = DBBlackColor;
        [self.view addSubview:label];
        _firstLabel = label;
    }
    return _firstLabel;
}

- (UITextField *)textField{
    if (_textField == nil) {
        UITextField *textfield = [[UITextField alloc] init];
        textfield.frame = CGRectMake(CGRectGetMaxX(self.firstLabel.frame), 20, CGRectGetMinX(self.rightlabel.frame) - CGRectGetMaxX(self.firstLabel.frame), 40);
        textfield.keyboardType = UIKeyboardTypeNumberPad;
        textfield.textAlignment = NSTextAlignmentRight;
        textfield.backgroundColor = [UIColor whiteColor];
        textfield.textColor = [UIColor blackColor];
        [textfield addTarget:self action:@selector(textfieldChangeValue:) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:textfield];
        _textField = textfield;
    }
    return _textField;
}


- (void)textfieldChangeValue:(UITextField *)textfield{
    self.textFieldText = textfield.text;
}

- (UILabel *)rightlabel{
    if (_rightlabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(SCREEN_WIDTH - 30, 20, 30, 40);
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = DBBlackColor;
        label.font = DBMaxFont;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"元";
        [self.view addSubview:label];
        _rightlabel = label;
    }
    return _rightlabel;
}

- (UIButton *)button{
    if (_button == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(20, CGRectGetMaxY(self.firstLabel.frame )+ 20, SCREEN_WIDTH - 40, 40);
        [button setTitle:@"充值" forState:UIControlStateNormal];
        button.titleLabel.font = DBMaxFont;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        button.layer.masksToBounds =YES;
        button.layer.cornerRadius = 5;
        button.backgroundColor = [UIColor redColor];
        [self.view addSubview:button];
        _button = button;
    }
    return _button;
}

- (void)buttonClicked{
    
    [self.view endEditing:YES];
    
    if (self.type == 1) {
        NSLog(@"微信充值");
    }else{
        NSLog(@"支付宝充值");
//
//        NSString *appID = ZhiFuBao_APPID;
//        
//        // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
//        // 如果商户两个都设置了，优先使用 rsa2PrivateKey
//        // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
//        // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
//        // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
//        NSString *rsa2PrivateKey = @"";
//        NSString *rsaPrivateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAIxoh4clrc7I5Jyf/EjH2muTBvzE4Byl3B3LRFQ9f1w0bXV4T+xfKNp4J3ERkazvyvv9R35o4iBgb8GJhNIFwzPWP6EcXHKU18FqBBQfm22IxeGcRQHK65VqRvavVa0bLXGdshZA4nuTMNeAp44FYMR2C98Nb3Z3c4VpoX0/ED+hAgMBAAECgYB7riQb7xvQN/Pw55hyf+Etu0B/bejAM3XWpNPWpKlIjkIRJN66JwS0lPyhQ8mfnUafe/b7KeZugKRQxhNCcaME9qMckTesBUr5OGlsaPhQbXeFTb3RQF4U6L5jhtmTM47njnDTEVJMCwZXxHjgXufT3vquJCjORvXmNuFOanyKwQJBAOBn6E+rXApNpUlbO3FOP1E9+iFYgRoErYwwXg3+qUIZa+JAkPDSNm7/XdZfW8BassQU4N+K5rOae7Pw1DaywpkCQQCgLSklgU8+1WEHgjIsCfS7uVPwNjRPZhvHWegPZ3CzjGfV3NIGVW7+LczKemi3sMJKqQ9qvAzlDFgvEJhgqBJJAkEAk4qdyivfcwLEBqwONBv/M1otZ9k54LJsrHxsioUCIex26yYKZdvAYFBUEQtXVuwLFzKm+zLnJfUPGirgTCpSGQJARaQc9a+JEtqXOzqCMd+KRmxHcHNAvxy4Cy6t1LS2rXnoU3WU4ygV//FNzuL10JfLgcaLa26jdJqvZJckiTHJ8QJAe+o5WSVeQNOq3kkFqs/2IIOBIhuGYrjwzjok5CnAdjpUXr3JvC/f2bvLJLIMC3TQHAVKoefarDK4XhjyH3/XKw==";
//        
//        /*
//         *生成订单信息及签名
//         */
//        //将商品信息赋予AlixPayOrder的成员变量
//        Order* order = [Order new];
//        order.notify_url = @"http://www.iiqiang.com/";
//        // NOTE: app_id设置
//        order.app_id = appID;
//        
//        // NOTE: 支付接口名称
//        order.method = @"alipay.trade.app.pay";
//        
//        // NOTE: 参数编码格式
//        order.charset = @"utf-8";
//        
//        // NOTE: 当前时间点
//        NSDateFormatter* formatter = [NSDateFormatter new];
//        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        order.timestamp = [formatter stringFromDate:[NSDate date]];
//        
//        // NOTE: 支付版本
//        order.version = @"1.0";
//        
//        // NOTE: sign_type 根据商户设置的私钥来决定
//        order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
//        
//        // NOTE: 商品数据
//        order.biz_content = [BizContent new];
//        order.biz_content.body = @"我是测试数据";
//        order.biz_content.subject = @"1";
//        order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
//        order.biz_content.timeout_express = @"30m"; //超时时间设置
//        order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
//
//        
//        //将商品信息拼接成字符串
//        NSString *orderInfo = [order orderInfoEncoded:NO];
//        NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
//        NSLog(@"orderSpec = %@",orderInfo);
//        
//        // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
//        //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
//        NSString *signedString = nil;
//        RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
//        if ((rsa2PrivateKey.length > 1)) {
//            signedString = [signer signString:orderInfo withRSA2:YES];
//        } else {
//            signedString = [signer signString:orderInfo withRSA2:NO];
//        }
//        
//        // NOTE: 如果加签成功，则继续执行支付
//        if (signedString != nil) {
//            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
//            NSString *appScheme = @"aiQiangAliPayScheme";
//            
//            // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
//            NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
//                                     orderInfoEncoded, signedString];
//            
//            
//            
//            NSString *sssssss = @"alipay_sdk=alipay-sdk-php-20161101&app_id=2017060607429952&biz_content=%7B%22body%22%3A%22%E6%88%91%E6%98%AF%E6%B5%8B%E8%AF%95%E6%95%B0%E6%8D%AE%22%2C%22subject%22%3A+%22App%E6%94%AF%E4%BB%98%E6%B5%8B%E8%AF%95%22%2C%22out_trade_no%22%3A+%2220500125test8798454654a%22%2C%22timeout_express%22%3A+%2230m%22%2C%22total_amount%22%3A+%220.01%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fwww.iiqiang.com%2Fapi.php%2FRecharge%2FalipayRecharge&sign_type=RSA&timestamp=2017-06-13+17%3A55%3A49&version=1.0&sign=ejp5DOLFJEGW%2BOY4ZxidzLu06XW98C9ppFwXw61q6GEejDTsAvoSodQsM%2F0rjv3euDeo82FKmRfWfBYbAzj6Bj0TQObBO6ZWXteBYGX7f6WSo46cMEI3Fv1jR0yBZ0ryVXe8rursLyHCNYK6CoUwzU8j5O3h%2FmEMiRSBv6jLBGE%3D";
//            // NOTE: 调用支付结果开始支付
////            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
////                NSLog(@"reslut = %@",resultDic);
////            }];
        
        /*
         @"alipay_sdk=alipay-sdk-php-20161101&app_id=2017060607429952&biz_content=%7B%22body%22%3A%22%5Cu7231%5Cu62a2-%5Cu5145%5Cu503c10%5Cu5143%22%2C%22subject%22%3A%22%5Cu7231%5Cu62a2-%5Cu5145%5Cu503c10%5Cu5143%22%2C%22out_trade_no%22%3A%222017061455100504%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A10%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fwww.iiqiang.com%2Fapi.php%2FRecharge%2FalipayRecharge&sign_type=RSA&timestamp=2017-06-14+15%3A18%3A00&version=1.0&sign=Z1y3wM0EUfc8vQlTJHakCj5n9pH1aTx%2BUiNTAzOmM4BNQTkWOrh4Vb3CCM3oavUOf2wGz8mmfBiIgWdRtswXWMjUE8PhTSjxZrDQccf1U4QBR0qEf6FkAM2dO93oDHTqGtwJwEINKq%2FfKUQWCsJ32RifeWx%2B9aK%2BZ57cL7UNxU0%3D"
         */
        
        if (self.textFieldText.length == 0) {
            [self showHint:@"请输入充值金额"];
            return;
        }
        NSString *appScheme = AliPayAppScheme;

        NSDictionary *param = @{@"uid":User_ID, @"total_amount":self.textFieldText};
        [MyAccountTool aliPayChongzhiWithParam:param successBlock:^(NSString *msg, NSString *data, NSNumber *status) {
            
            NSString *resultStr = data;
            NSString *afterStr = [resultStr stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            
            if ([status intValue] == 0) {
                [self showHint:msg];
            }else{
                [[AlipaySDK defaultService] payOrder:afterStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                }];
            }
        } errorBlock:^(NSError *error) {
            [self showHint:@"网络错误"];
        }];
        
//            [[AlipaySDK defaultService] payOrder:sssssss fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//                NSLog(@"reslut = %@",resultDic);
//            }];
        

        
       
    }
}

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
@end
