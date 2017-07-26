//
//  ConfigPasswordViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/18.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "ConfigPasswordViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "MySettingTool.h"

@interface ConfigPasswordViewController ()

@property (nonatomic, weak) TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, copy) NSString *firstStr;
@property (nonatomic, copy) NSString *seconfStr;
@property (nonatomic, copy) NSString *thirdStr;


@end

@implementation ConfigPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self createUI];
    [self scrollView];
    
}

- (void)setUI{
    self.view.backgroundColor = ColorTableViewBg;
    self.title =@"修改密码";
}


- (TPKeyboardAvoidingScrollView *)scrollView{
    if (_scrollView == nil) {
        TPKeyboardAvoidingScrollView *scrollView  = [[TPKeyboardAvoidingScrollView alloc] init];
        scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH  - 64);
        scrollView.backgroundColor = ColorTableViewBg;
        scrollView.scrollEnabled = NO;
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (void)createUI{
    NSArray *nameArray = @[@"原 密 码",@"新 密 码",@"确认密码"];
    NSArray *placeHoldArray = @[@"请输入您的密码",@"请输入新密码",@"请再次输入新密码"];
    
    for (int i = 0; i<3; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(20, 20 + 70 * i, SCREEN_WIDTH - 40, 50);
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 5;
        view.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:view];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 10, 80, 30);
        label.tag = 100 + i;
        label.text = nameArray[i];
        label.font = DBMaxFont;
        label.textColor = DBBlackColor;
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        
        UITextField *textfield = [[UITextField alloc] init];
        textfield.frame = CGRectMake(CGRectGetMaxX(label.frame), 10, CGRectGetMaxX(view.frame) - CGRectGetMaxX(label.frame), 30);
        textfield.tag = 200 + i;
        [textfield addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        textfield.font = DBMaxFont;
        textfield.textColor = DBBlackColor;
        textfield.placeholder = placeHoldArray[i];
        textfield.textAlignment = NSTextAlignmentLeft;
        textfield.secureTextEntry = YES;
        [view addSubview:textfield];
    }
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor colorWithRed:0.981 green:0.532 blue:0.036 alpha:1.000];
    button.frame = CGRectMake(20, 230, SCREEN_WIDTH - 40, 40);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"确认修改" forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    button.titleLabel.font = DBMaxFont;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.scrollView addSubview:button];
    
}

- (void)textFieldChanged:(UITextField*)textField{
    switch (textField.tag) {
        case 200:
            self.firstStr = textField.text;
            break;
        case 201:
            self.seconfStr = textField.text;
            break;
        case 202:
            self.thirdStr = textField.text;
            break;
        default:
            break;
    }
    
    
    
}
- (void)buttonClick{
    [self.scrollView endEditing:YES];
    if (self.firstStr.length == 0) {
        [self showHint:@"请输入原密码"];
        return;
    }
    
    if (self.seconfStr.length == 0) {
        [self showHint:@"请输入新密码"];
        return;
    }
    if (self.thirdStr.length == 0) {
        [self showHint:@"请再次输入新密码"];
        return;
    }
    
    
    NSDictionary *param = @{@"uid": User_ID,@"oldpassword":self.firstStr,@"password":self.seconfStr,@"repassword":self.thirdStr};
    
    [MySettingTool configPasswordWithParam:param successBlock:^(NSString *msg,NSNumber *num) {
        [self showHint:msg];
       
        if ([num isEqualToNumber:@1]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorBlock:^(NSError *error) {
        
    }];
    
    
    
}


@end
