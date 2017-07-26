//
//  PasswordViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/16.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "PasswordViewController.h"
#import "SYPasswordView.h"
#import "MyAccountTool.h"

@interface PasswordViewController ()<UIAlertViewDelegate>
@property (nonatomic, weak) UILabel *topLabel;
@property (nonatomic, weak) SYPasswordView *passWordView;
@property (nonatomic, weak) UILabel *tipLabel;
@property (nonatomic, assign) int inputCount;
@property (nonatomic, copy) NSString *firstPassword;
@property (nonatomic, copy) NSString *secondPassword;

@end

@implementation PasswordViewController



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.passWordView.textField removeFromSuperview];
    [self.passWordView.textField resignFirstResponder];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self initData];
    [self tipLabel];
    [self passWordView];
}

- (void)setupUI{
    self.view.backgroundColor = ColorTableViewBg;
    self.title = @"密码管理";
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
- (void)initData{
    self.inputCount = 0;
}

- (UILabel *)tipLabel{
    if (_tipLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 30, SCREEN_WIDTH, 40);
        label.backgroundColor = [UIColor clearColor];
        label.text = @"请输入六位数字支付密码（1/2）";
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        _tipLabel = label;
    }
    return _tipLabel;
}
- (SYPasswordView *)passWordView{
    if (_passWordView == nil) {
        SYPasswordView *view = [[SYPasswordView alloc] initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH - 40, (SCREEN_WIDTH - 40)/6)];
        typeof(view) weakView = view;
        [view setSixNumberBlock:^(NSString *password){
            self.inputCount ++;
            if (self.inputCount == 1) {
                self.firstPassword = password;
                self.tipLabel.text = @"请再次输入六位数字支付密码（2/2）";
                [weakView clearUpPassword];
            }else if (self.inputCount == 2){
                self.secondPassword = password;
                if ([self.firstPassword isEqualToString:self.secondPassword]) {
                    NSLog(@"密码一致");
                    [self loadData];
                }else{
                    NSLog(@"密码不一致");
                    self.inputCount = 0;
                    [MBProgressHUD showSuccess:@"密码不一致，请重新输入" toView:self.view];

                    self.tipLabel.text = @"请输入六位数字支付密码（1/2）";
                    [weakView clearUpPassword];
                    
                }
            
            }else{

            }
            
        }];
        
        [self.view addSubview:view];
        _passWordView = view;
    }
    return _passWordView;
}

- (void)loadData{
    
    NSDictionary *param = @{@"uid":User_ID,@"pay_password":self.secondPassword};
    
    [MyAccountTool setupPasswordWithParam:param successBlock:^(NSString *msg) {
        
        [MBProgressHUD showSuccess:msg toView:self.view];
        self.inputCount = 0;
        self.tipLabel.text = @"请输入六位数字支付密码（1/2）";
        [self.passWordView clearUpPassword];
        [self.passWordView.textField resignFirstResponder];
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付密码设置成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [view show];
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误" toView:self.view];
        self.inputCount = 0;
        self.tipLabel.text = @"请输入六位数字支付密码（1/2）";
        [self.passWordView clearUpPassword];
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.passWordView.textField resignFirstResponder];
    if (buttonIndex == 1) {
        [self performSelector:@selector(popview) withObject:nil afterDelay:0.5];
    }
}

- (void)popview
{
    [self.navigationController popViewControllerAnimated:YES];

    
}
@end
