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

#import "LoginViewController.h"
#import <Hyphenate/EMError.h>
#import "ChatDemoHelper.h"
#import "MBProgressHUD.h"
#import "RedPacketUserConfig.h"
#import "RegisterViewController.h"
#import "GetPasswordViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface LoginViewController ()<UITextFieldDelegate, CLLocationManagerDelegate>

{
    CLLocationManager *locationManager;
    
    NSString *currentCity;
    NSString *latitude;//纬度
    NSString *longitude;//经度
    
    BOOL successGetLocaltion;
}

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@property (nonatomic, copy) NSString *uid;
@end

@implementation LoginViewController

@synthesize usernameTextField = _usernameTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize loginButton = _loginButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    
    NSString *username = [self lastLoginUsername];
    if (username && username.length > 0) {
        _usernameTextField.text = User_mobile;
    }
    _loginButton.layer.cornerRadius = 5;
    _loginButton.clipsToBounds = YES;
    
    self.usernameTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    successGetLocaltion = NO;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self getLocation];

}

- (void)getLocation{
    
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 5.0;
        [locationManager startUpdatingLocation];
    }else{
        NSLog(@"[CLLocationManager locationServicesEnabled] == NO");
    }
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    successGetLocaltion = NO;
    //设置提醒用户打开定位服务
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"定位服务未开启" message:@"请在系统设置中开启定位服务" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"暂不" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [vc addAction:ok];
    [vc addAction:cancel];
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    successGetLocaltion = YES;
    
    [locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    latitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];//纬度
    longitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];//经度
    NSLog(@"当前经度==%f,当前纬度==%f",currentLocation.coordinate.longitude, currentLocation.coordinate.latitude);
    
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    [geo reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            CLPlacemark *mark = placemarks[0];
            self->currentCity = [NSString stringWithFormat:@"%@%@",mark.administrativeArea, mark.locality];
            if (!self->currentCity) {
                self->currentCity = @"无法定位当前城市";
            }
            
            NSLog(@"mark.locality==%@",mark.locality);//郑州市
            
            NSLog(@"mark.subLocality%@",mark.subLocality);//金水区
            
            NSLog(@"administrativeArea==%@",mark.administrativeArea);//河南省
            
        }else if (error == nil && placemarks.count == 0){
            
            NSLog(@"No localtion and error return");
            
        }else if (error){
            NSLog(@"error.description==%@",error.description);
        }
        
    }];
    
}

#pragma mark - Action

//注册账号
- (IBAction)registerAction:(id)sender {
    RegisterViewController *vc = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];

}

//忘记密码
- (IBAction)forgetPassword:(id)sender {
    GetPasswordViewController *vc = [[GetPasswordViewController alloc] initWithNibName:@"GetPasswordViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
    
}

//登陆账号
- (IBAction)doLogin:(id)sender {
    NSString *username = _usernameTextField.text;
    NSString *password = _passwordTextField.text;
    if (username.length == 0 || password.length == 0) {
        [self showHint:@"账号或密码不能为空"];
        return;
    }
    
    [self.view endEditing:YES];
    //支持是否为中文
    if ([self.usernameTextField.text isChinese]) {
        [self showHint:@"不能为中文"];
        return;
    }
    [self loginWithUsername:_usernameTextField.text password:_passwordTextField.text];
}

//点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    [self showHudInView:self.view hint:@"登录中"];
    
    NSString *token = DeviceToken;
    
    NSDictionary *param;
    if (successGetLocaltion == YES) {
        param = @{@"username": _usernameTextField.text, @"password": _passwordTextField.text, @"client_id" : token.length > 0?token:@"", @"location":currentCity, @"lng":longitude, @"lat":latitude};

    }else{
        param = @{@"username": _usernameTextField.text, @"password": _passwordTextField.text, @"client_id" : token.length > 0?token:@""};
    }
    

    [[NetworkManager new] postWithURL:[NSString stringWithFormat:@"%@/api.php/Public/login", www] parameter:param success:^(id obj) {
        if ([obj[@"status"] isEqualToNumber:@1])
        {
            self.uid = obj[@"data"][@"uid"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:obj[@"data"][@"address"] forKey:@"address"];
            [defaults setObject:obj[@"data"][@"aq_id"] forKey:@"aq_id"];
            [defaults setObject:obj[@"data"][@"balance"] forKey:@"balance"];
            [defaults setObject:obj[@"data"][@"birthdy"] forKey:@"birthdy"];
            [defaults setObject:obj[@"data"][@"headimg"] forKey:@"headimg"];
            [defaults setObject:obj[@"data"][@"hx_id"] forKey:@"hx_id"];
            [defaults setObject:obj[@"data"][@"mobile"] forKey:@"mobile"];
            [defaults setObject:obj[@"data"][@"nickname"] forKey:@"nickname"];
            [defaults setObject:obj[@"data"][@"pay_password"] forKey:@"pay_password"];
            [defaults setObject:obj[@"data"][@"sex"] forKey:@"sex"];
            [defaults setObject:obj[@"data"][@"uid"] forKey:@"uid"];
            [defaults setObject:obj[@"data"][@"zuan"] forKey:@"zuan"];
            [defaults setObject:obj[@"data"][@"is_recommend"] forKey:@"is_recommend"];

            [defaults synchronize];
            
            NSLog(@"-----服务器登录成功");
            NSLog(@"%@",obj);
            NSLog(@"-------");
            
            //异步登陆账号
            __weak typeof(self) weakself = self;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                EMError *error = [[EMClient sharedClient] loginWithUsername:self.uid password:self.uid];

                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself hideHud];
                    if (!error) {
                        //保存最近一次登录用户名
                        [weakself saveLastLoginUsername];
                        //设置是否自动登录
                        [[EMClient sharedClient].options setIsAutoLogin:YES];
                        BOOL loginSuccess = [EMClient sharedClient].isLoggedIn;
                        BOOL isConnectedSuccess = [EMClient sharedClient].isConnected;
                        NSLog(@"loginSuccess--------%d isConnectedSuccess-----------%d",loginSuccess,isConnectedSuccess);
                        
                        [MBProgressHUD showHUDAddedTo:weakself.view animated:YES];
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            [[EMClient sharedClient] migrateDatabaseToLatestSDK];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[ChatDemoHelper shareHelper] asyncGroupFromServer];
                                [[ChatDemoHelper shareHelper] asyncConversationFromDB];
                                [[ChatDemoHelper shareHelper] asyncPushOptions];
                                [MBProgressHUD hideAllHUDsForView:weakself.view animated:YES];
                                //发送自动登陆状态通知
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@([[EMClient sharedClient] isLoggedIn])];
                            });
                        });
                    } else {//  不走次方法
                        switch (error.code)
                        {
                            case EMErrorNetworkUnavailable:
                                TTAlertNoTitle(@"网络错误");
                                break;
                            case EMErrorServerNotReachable:
                                TTAlertNoTitle(@"连接服务器错误");
                                break;
                            case EMErrorUserAuthenticationFailed:
                                TTAlertNoTitle(error.errorDescription);
                                break;
                            case EMErrorServerTimeout:
                                TTAlertNoTitle(@"连接服务器超时");
                                break;
                            case EMErrorServerServingForbidden:
                                TTAlertNoTitle(@"服务被禁用");
                                break;
                            default:
                                TTAlertNoTitle(@"登录失败");
                                break;
                        }
                    }
                });
            });
        }else{
            [self hideHud];
            [self showHint:obj[@"msg"]];
        }
    } fail:^(NSError *error) {
        [self hideHud];
        [self showHint:@"网络错误"];
        NSLog(@"-----服务器登录失败");
    }];
}

#pragma mark - UIAlertViewDelegate

//弹出提示的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView cancelButtonIndex] != buttonIndex) {
        //获取文本输入框
        UITextField *nameTextField = [alertView textFieldAtIndex:0];
        if(nameTextField.text.length > 0)
        {
            //设置推送设置
            [[EMClient sharedClient] setApnsNickname:nameTextField.text];
        }
    }
    //登陆
    [self loginWithUsername:_usernameTextField.text password:_passwordTextField.text];
}


#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _usernameTextField) {
        _passwordTextField.text = @"";
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _usernameTextField) {
        [_usernameTextField resignFirstResponder];
        [_passwordTextField becomeFirstResponder];
    } else if (textField == _passwordTextField) {
        [_passwordTextField resignFirstResponder];
        [self doLogin:nil];
    }
    return YES;
}

#pragma mark - private

- (void)saveLastLoginUsername
{
    NSString *username = [[EMClient sharedClient] currentUsername];
    if (username && username.length > 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:username forKey:[NSString stringWithFormat:@"em_lastLogin_username"]];
        [ud synchronize];
    }
}

- (NSString*)lastLoginUsername
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username = [ud objectForKey:[NSString stringWithFormat:@"em_lastLogin_username"]];
    if (username && username.length > 0) {
        return username;
    }
    return nil;
}

@end
