//
//  RegisterViewController.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/10.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginTool.h"
#import "DBWebViewViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate> {
    NSInteger _second;
}

@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengma;
@property (weak, nonatomic) IBOutlet UIButton *getYanzhengmaButton;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repeatPassword;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UITextField *tuijiamma;

@property (strong, nonatomic) NSTimer *time;


@property (nonatomic, copy) NSString *phoneText;
@property (nonatomic, copy) NSString *yanzhengmaText;
@property (nonatomic, copy) NSString *passwordText;
@property (nonatomic, copy) NSString *repeartPassWordText;
@property (nonatomic, copy) NSString *rightPassword;
@property (nonatomic, copy) NSString *tuijianmaText;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            if (view.tag != 1000) {
                view.layer.cornerRadius = 5;
                view.clipsToBounds = YES;
            }
        }
    }
    _registerButton.layer.cornerRadius = 5;
    _registerButton.clipsToBounds = YES;
    
    
    self.phone.keyboardType = UIKeyboardTypeNumberPad;
    self.yanzhengma.keyboardType = UIKeyboardTypeNumberPad;
    self.tuijiamma.keyboardType = UIKeyboardTypeNumberPad;
    
    
    
    [self.phone addTarget:self action:@selector(getPhoneText:) forControlEvents:UIControlEventEditingChanged];
    [self.yanzhengma addTarget:self action:@selector(getPWYanzhengma:) forControlEvents:UIControlEventEditingChanged];
    
    [self.password addTarget:self action:@selector(getPasswordText:) forControlEvents:UIControlEventEditingChanged];
    
    [self.repeatPassword addTarget:self action:@selector(getRepeatPasswordText:) forControlEvents:UIControlEventEditingChanged];
    
    [self.tuijiamma addTarget:self action:@selector(getTuiJianMaText:) forControlEvents:UIControlEventEditingChanged];
}

- (void)getTuiJianMaText:(UITextField *)textField{
    self.tuijianmaText = textField.text;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerAction:(id)sender {
    [_phone resignFirstResponder];
    [_yanzhengma resignFirstResponder];
    [_repeatPassword resignFirstResponder];
    [_password resignFirstResponder];
    if (self.phoneText.length == 0) {
        [self showHint:@"手机号不能为空"];
        return;
    }
    if (!(self.phoneText.length == 11)) {
        [self showHint:@"请输入正确的手机号码"];
        return;
    }
    
    
    if (self.yanzhengmaText.length == 0) {
        [self showHint:@"验证码不能为空"];
        return;
    }
    
    if (!(self.yanzhengmaText.length == 6)) {
        [self showHint:@"请输入正确验证码"];
        return;
    }
    
    if (self.passwordText.length == 0) {
        [self showHint:@"密码不能为空"];
        return;
    }
    if (self.repeartPassWordText.length == 0) {
        [self showHint:@"确认密码不能为空"];
        return;
    }

    if (self.tuijianmaText.length > 0 &&  !(self.tuijianmaText.length == 6)) {
        [self showHint:@"请输入正确六位推荐码，没有可不填"];
        return;
    }
    
    NSDictionary *param =@{@"username": self.phoneText, @"mobile": self.phoneText, @"password": self.passwordText, @"repassword": self.repeartPassWordText,@"code": self.yanzhengmaText,@"recommend":self.tuijianmaText};
    [[NetworkManager new] postWithURL:[NSString stringWithFormat:@"%@/api.php/Public/register", www] parameter:param success:^(id obj) {
        [self showHint:obj[@"msg"]];
        if ([obj[@"status"] isEqualToNumber:@1]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } fail:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];

}

#pragma mark - 获取验证码
- (IBAction)getYanzhengma:(id)sender {
    
    [self.phone resignFirstResponder];
    [self.yanzhengma resignFirstResponder];
    [self.password resignFirstResponder];
    [self.repeatPassword resignFirstResponder];
    
    
    if (!(_phone.text.length == 11)) {
        [self showHint:@"请输入正确的手机号码"];
        return;
    }

    NSDictionary *param = @{@"phone":_phone.text,@"type":@"1"};
    [LoginTool sendMessageWithParam:param successBlock:^(NSString *msg, NSNumber *stasus) {
        if ([stasus intValue] == 1) {
            self->_getYanzhengmaButton.backgroundColor = [UIColor grayColor];
            self->_getYanzhengmaButton.userInteractionEnabled = NO;
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

- (IBAction)userAgreement:(id)sender {
    NSLog(@"用户协议");
    DBWebViewViewController *vc = [[DBWebViewViewController alloc] init];
    vc.type = @"yong_hu_xie_yi";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
