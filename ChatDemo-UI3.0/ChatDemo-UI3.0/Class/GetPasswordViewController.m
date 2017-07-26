//
//  GetPasswordViewController.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/10.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "GetPasswordViewController.h"
#import "LoginTool.h"

@interface GetPasswordViewController ()<UITextFieldDelegate> {
    NSInteger _second;
}

@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengma;
@property (weak, nonatomic) IBOutlet UIButton *getYanzhengmaButton;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repeatPassword;
@property (weak, nonatomic) IBOutlet UIButton *querenButton;
@property (weak, nonatomic) IBOutlet UIView *bigView;


@property (nonatomic, copy) NSString *phoneText;
@property (nonatomic, copy) NSString *yanzhengmaText;
@property (nonatomic, copy) NSString *passwordText;
@property (nonatomic, copy) NSString *repeartPassWordText;
@property (nonatomic, copy) NSString *rightPassword;

@property (strong, nonatomic) NSTimer *time;

@end

@implementation GetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    
    for (UIView *view in self.bigView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            if (view.tag != 1000) {
                view.layer.cornerRadius = 5;
                view.clipsToBounds = YES;
            }
        }
    }
    self.phone.keyboardType = UIKeyboardTypeNumberPad;
    self.yanzhengma.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.phone addTarget:self action:@selector(getPhoneText:) forControlEvents:UIControlEventEditingChanged];
    [self.yanzhengma addTarget:self action:@selector(getPWYanzhengma:) forControlEvents:UIControlEventEditingChanged];
    
    [self.password addTarget:self action:@selector(getPasswordText:) forControlEvents:UIControlEventEditingChanged];
    
    [self.repeatPassword addTarget:self action:@selector(getRepeatPasswordText:) forControlEvents:UIControlEventEditingChanged];
    
    _querenButton.layer.cornerRadius = 5;
    _querenButton.clipsToBounds = YES;
}

- (void)getPasswordText:(UITextField *)textfield{
    self.passwordText = textfield.text;
}

- (void)getRepeatPasswordText:(UITextField *)textfield{
    self.repeartPassWordText = textfield.text;
}

- (void)getPhoneText:(UITextField *)textfield{
    
    self.phoneText = textfield.text;
}

- (void)getPWYanzhengma:(UITextField *)textfield{
    self.yanzhengmaText = textfield.text;
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)querenAction:(id)sender {
    
    [self.phone resignFirstResponder];
    [self. yanzhengma resignFirstResponder];
    [_repeatPassword resignFirstResponder];
    [_password resignFirstResponder];
    if (!(self.phoneText.length == 11)) {
        [self showHint:@"请输入正确手机号码"];
        return;
    }
    
    if (!(self.yanzhengmaText.length == 6)) {
        [self showHint:@"请输入正确验证码"];
        return;
    }
    
    if (self.passwordText.length == 0) {
        [self showHint:@"请输入密码"];
        return;
    }
    
    if (self.repeartPassWordText.length == 0) {
        [self showHint:@"请输入确认密码"];
        return;
    }
    
    if (![self.passwordText isEqualToString:self.repeartPassWordText]) {
        [self showHint:@"密码不一致，请重新输入"];
        return;
    }
    
    if ([self.passwordText isEqualToString:self.repeartPassWordText]) {
        self.rightPassword = self.passwordText;
    }
    
    NSDictionary *param = @{@"mobile":self.phoneText , @"code":self.yanzhengmaText, @"password":self.rightPassword};
    [LoginTool getPasswordWithParam:param successBlock:^(NSString *msg, NSNumber *stasus) {
        [self showHint:msg];
        if ([stasus intValue] == 1) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } errorBlcok:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

- (IBAction)getYanzhengma:(id)sender {
    [self.phone resignFirstResponder];
    [self. yanzhengma resignFirstResponder];
    [_repeatPassword resignFirstResponder];
    [_password resignFirstResponder];
    
    if (!(self.phoneText.length == 11)) {
        [self showHint:@"请输入正确手机号码"];
        return;
    }
    
    _getYanzhengmaButton.backgroundColor = [UIColor grayColor];
    _getYanzhengmaButton.userInteractionEnabled = NO;
    //发送成功,倒计时开始
    _second = 60;
    self.time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(less) userInfo:nil repeats:YES];
    
    
    NSDictionary *param = @{@"phone": self.phoneText,@"type":@"2"};
    [LoginTool sendMessageWithParam:param successBlock:^(NSString *msg, NSNumber *stasus) {
        [self showHint:msg];
        
    } errorBlcok:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
    
    
}


- (void)less {
    _second--;
    [_getYanzhengmaButton setTitle:[NSString stringWithFormat:@"%ld", (long)_second] forState:UIControlStateNormal];
    if (_second == 0) {
        [self.time invalidate];
        [_getYanzhengmaButton setTitle:@"获取" forState:UIControlStateNormal];
        _getYanzhengmaButton.userInteractionEnabled = YES;
        _getYanzhengmaButton.backgroundColor =[UIColor colorWithRed:0.981 green:0.532 blue:0.036 alpha:1.000];
    }
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_phone resignFirstResponder];
    [_yanzhengma resignFirstResponder];
    [_repeatPassword resignFirstResponder];
    [_password resignFirstResponder];
    
    return YES;
}



@end
