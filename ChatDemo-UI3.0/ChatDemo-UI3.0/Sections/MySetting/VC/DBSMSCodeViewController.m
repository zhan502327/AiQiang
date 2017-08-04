//
//  DBSMSCodeViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/20.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBSMSCodeViewController.h"
#import "LoginTool.h"
#import "MySettingTool.h"
#import "PasswordViewController.h"

@interface DBSMSCodeViewController ()
{
    NSInteger _second;

}
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *getButton;
@property (strong, nonatomic) NSTimer *time;

@property (nonatomic, copy) NSString *textfieldtext;
@end

@implementation DBSMSCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI{
    self.title = @"验证码";
    self.view.backgroundColor = ColorTableViewBg;
    

    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 30);
    label.textColor = [UIColor grayColor ];
    label.text = @"短信验证码会发送至您的手机，请注意查收";
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    UITextField *textfield = [[UITextField alloc] init];
    textfield.frame = CGRectMake(10, CGRectGetMaxY(label.frame), SCREEN_WIDTH - 10 - 100 - 0.5, 40);
    textfield.backgroundColor = [UIColor whiteColor];
    textfield.font = DBMaxFont;
    textfield.textColor = DBBlackColor;
    textfield.layer.masksToBounds = YES;
    textfield.layer.cornerRadius = 4;
    [textfield addTarget:self action:@selector(textfieldchangeValue:) forControlEvents:UIControlEventEditingChanged];
    
    textfield.placeholder = @"请填写短信验证码";
    [self.view addSubview:textfield];
    self.textField = textfield;
    
    UIButton *getbutton = [[UIButton alloc] init];
    getbutton.backgroundColor =[UIColor colorWithRed:0.981 green:0.532 blue:0.036 alpha:1.000];
    getbutton.frame = CGRectMake(CGRectGetMaxX(self.textField.frame) + 0.5, CGRectGetMinY(self.textField.frame), 90, 40);
    [getbutton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getbutton addTarget:self action:@selector(getYanZhengMa) forControlEvents:UIControlEventTouchUpInside];
    getbutton.layer.masksToBounds = YES;
    getbutton.layer.cornerRadius = 4;
    getbutton.titleLabel.font = DBMaxFont;
    [getbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:getbutton];
    self.getButton = getbutton;
    
    UIButton *sendButton = [[UIButton alloc] init];
    sendButton.frame = CGRectMake(10, CGRectGetMaxY(self.textField.frame) + 10, SCREEN_WIDTH - 20, 40);
    
    sendButton.titleLabel.textColor = [UIColor whiteColor];
    [sendButton setTitle:@"确定" forState:UIControlStateNormal];
    sendButton.backgroundColor = [UIColor colorWithRed:0.981 green:0.532 blue:0.036 alpha:1.000];;
    sendButton.layer.masksToBounds = YES;
    sendButton.layer.cornerRadius = 4;
    sendButton.titleLabel.font = DBMaxFont;
    [sendButton addTarget:self action:@selector(checkoutMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
}

- (void)textfieldchangeValue:(UITextField *)textfield{
    self.textfieldtext = textfield.text;
}

- (void)getYanZhengMa{
    
    NSLog(@"获取验证码");

    NSDictionary *param = @{@"phone":User_mobile,@"type":@"3"};
    [LoginTool sendMessageWithParam:param successBlock:^(NSString *msg, NSNumber *stasus) {
        if ([stasus intValue] == 1) {
            self.getButton.backgroundColor = [UIColor grayColor];
            self.getButton.userInteractionEnabled = NO;
            //发送成功,倒计时开始
            self->_second = 60;
            self.time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(less) userInfo:nil repeats:YES];
            
        }else{
            [self showHint:msg];
        }
    } errorBlcok:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
    
}

- (void)less {
    _second--;
    [self.getButton setTitle:[NSString stringWithFormat:@"%ld", (long)_second] forState:UIControlStateNormal];
    if (_second == 0) {
        [self.time invalidate];
        [self.getButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getButton.userInteractionEnabled = YES;
        self.getButton.backgroundColor =[UIColor colorWithRed:0.981 green:0.532 blue:0.036 alpha:1.000];
    }
    
}

- (void)checkoutMessage{
    NSLog(@"校验短信验证码");
    
    NSDictionary *param = @{@"uid":User_ID, @"code":self.textfieldtext, @"type" : @"3"};
    [MySettingTool chectoutMessageCodeWithParam:param successBlock:^(NSString *msg, NSNumber *num) {
        [self showHint:msg];
        if ([num intValue] == 1) {
            PasswordViewController *vc = [[PasswordViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

@end
