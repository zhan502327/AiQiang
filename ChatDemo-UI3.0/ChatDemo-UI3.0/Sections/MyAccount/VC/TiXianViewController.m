//
//  TiXianViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/16.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "TiXianViewController.h"
#import "MyAccountTool.h"

@interface TiXianViewController ()

@property (nonatomic, weak) UILabel *firstLabel;
@property (nonatomic, weak) UILabel *secondLabel;
@property (nonatomic, weak) UITextField *firsttextField;

@property (nonatomic, weak) UITextField *secondTextField;
@property (nonatomic, weak) UILabel *rightLabel;
@property (nonatomic, weak) UILabel *tipLabel;
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, copy) NSString *firstTextFieldtext;

@property (nonatomic, copy) NSString *secondTextFieldtext;
@end

@implementation TiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self firstLabel];
    

    [self secondLabel];
    [self firsttextField];
    [self secondTextField];
    [self rightLabel];
    [self tipLabel];
    [self button];
    
    if (self.type == 3) {
        self.firstLabel.hidden = YES;
        self.firsttextField.hidden = YES;
        self.secondLabel.frame = CGRectMake(0, 15, 100, 40);
        self.secondTextField.frame = CGRectMake(CGRectGetMaxX(self.secondLabel.frame), CGRectGetMinY(self.secondLabel.frame), CGRectGetMinX(self.rightLabel.frame) - CGRectGetMaxX(self.secondLabel.frame), 40);
        self.rightLabel.frame = CGRectMake(SCREEN_WIDTH - 30, CGRectGetMinY(self.secondLabel.frame), 30, 40);
        
        
    }
}

- (void)setupUI{
    
    self.view.backgroundColor = ColorTableViewBg;
    self.title = @"提现";
    
}


- (UILabel *)firstLabel{
    if (_firstLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 15, 180, 40);
        label.font = DBMaxFont;
        
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = DBBlackColor;
        label.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:label];
        _firstLabel = label;
    }
    return _firstLabel;
}

- (UILabel *)secondLabel{
    if (_secondLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, CGRectGetMaxY(self.firstLabel.frame) + 1, 100, 40);
        label.font = DBMaxFont;
        label.text = @"    提现金额";
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = DBBlackColor;
        label.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:label];
        _secondLabel = label;
    }
    return _secondLabel;
}

- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(SCREEN_WIDTH - 30, CGRectGetMinY(self.secondLabel.frame), 30, 40);
        label.text = @"元";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = DBBlackColor;
        label.font =DBMaxFont;
        label.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:label];
        _rightLabel = label;
    }
    return _rightLabel;
}

- (UITextField *)firsttextField{
    if (_firsttextField == nil) {
        UITextField *textfield = [[UITextField alloc] init];
        textfield.frame = CGRectMake(CGRectGetMaxX(self.firstLabel.frame), CGRectGetMinY(self.firstLabel.frame), SCREEN_WIDTH - CGRectGetMaxX(self.firstLabel.frame), 40);
        textfield.textAlignment = NSTextAlignmentRight;
        [textfield addTarget:self action:@selector(textfieldtext:) forControlEvents:UIControlEventEditingChanged];
        textfield.keyboardType = UIKeyboardTypeNumberPad;
        textfield.backgroundColor = [UIColor whiteColor];
        textfield.tag = 100 + 1;
        textfield.font = DBMaxFont;
        textfield.textColor = DBBlackColor;
        textfield.placeholder = @"请输入账号";
        [self.view addSubview:textfield];
        _firsttextField = textfield;

    }
    return _firsttextField;
}

- (UITextField *)secondTextField{
    if (_secondTextField == nil) {
        UITextField *textfield = [[UITextField alloc] init];
        textfield.frame = CGRectMake(CGRectGetMaxX(self.secondLabel.frame), CGRectGetMinY(self.secondLabel.frame), CGRectGetMinX(self.rightLabel.frame) - CGRectGetMaxX(self.secondLabel.frame), 40);
        textfield.textAlignment = NSTextAlignmentRight;
        [textfield addTarget:self action:@selector(textfieldtext:) forControlEvents:UIControlEventEditingChanged];
        textfield.keyboardType = UIKeyboardTypeNumberPad;
        textfield.backgroundColor = [UIColor whiteColor];
        textfield.tag = 100 + 2;
        textfield.textColor = DBBlackColor;
        textfield.font = DBMaxFont;
        textfield.placeholder = @"请输入金额";
        [self.view addSubview:textfield];
        _secondTextField = textfield;
    }
    return _secondTextField;
}

- (void)textfieldtext:(UITextField *)textfield{
    if (textfield.tag == 100 + 1) {
        self.firstTextFieldtext = textfield.text;
    }
    
    
    if (textfield.tag == 100 + 2) {
        self.secondTextFieldtext = textfield.text;
    }
}

- (UILabel *)tipLabel{
    if (_tipLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, CGRectGetMaxY(self.secondLabel.frame)+10, SCREEN_WIDTH, 20);
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        
//        label.text = @"温馨提示：剩余金额¥     24小时到账";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:label];
        _tipLabel = label;
    }
    return _tipLabel;
}

- (UIButton *)button{
    if (_button == nil) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(20, CGRectGetMaxY(self.tipLabel.frame) + 20, SCREEN_WIDTH - 40, 40);
        button.titleLabel.font = DBMaxFont;
        [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor redColor];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5;
        [self.view addSubview:button];
        _button = button;
    }
    return _button;
}

- (void)buttonClicked{
    NSLog(@"buttonClicked");
    [self.view endEditing:YES];
    
    if (self.type == 1) {//提现到支付宝
        if (self.firstTextFieldtext.length == 0) {
            [self showHint:@"请输入账号"];
            return;
        }
        
        if (self.secondTextFieldtext.length == 0) {
            [self showHint:@"请输入提现金额"];
            return;
        }
        
        NSDictionary *param = @{@"uid":User_ID, @"total_amount":self.secondTextFieldtext, @"type" : @"2", @"to" : self.firstTextFieldtext};
        [MyAccountTool rmbWithDrawWithParam:param successBlock:^(NSString *msg) {
            [self showHint:msg];
        } errorBlock:^(NSError *error) {
            
        }];
        
    }
    
    if (self.type == 2) {//提现到微信
        
        if (self.firstTextFieldtext.length == 0) {
            [self showHint:@"请输入账号"];
            return;
        }
        
        if (self.secondTextFieldtext.length == 0) {
            [self showHint:@"请输入提现金额"];
            return;
        }
        NSDictionary *param = @{@"uid":User_ID, @"total_amount":self.secondTextFieldtext, @"type" : @"3", @"to" : self.firstTextFieldtext};
        [MyAccountTool rmbWithDrawWithParam:param successBlock:^(NSString *msg) {
            [self showHint:msg];
        } errorBlock:^(NSError *error) {
            
        }];
    }
    
    if (self.type == 3) {//红包余额提现到现金余额
        
        NSDictionary *param = @{@"uid":User_ID , @"total_amount" : self.secondTextFieldtext};
        [MyAccountTool redBagTixainToRMBWithParam:param successBlock:^(NSString *msg) {
            [self showHint:msg];
        } errorBlock:^(NSError *error) {
            
        }];
    }
    
    
    
}

- (void)setType:(int)type{
    _type = type;
    if (type == 1) {
        self.firsttextField.hidden = NO;
        self.firstLabel.text = @"    提现到支付宝";
        [self.button setTitle:@"提现到支付宝" forState:UIControlStateNormal];

    }
    
    if (type == 2){
        self.firsttextField.hidden = NO;
        self.firstLabel.text = @"    提现到微信";
        [self.button setTitle:@"提现到微信" forState:UIControlStateNormal];

    }
    
    if (type == 3){
        self.firsttextField.hidden = YES;
        self.firstLabel.hidden = YES;
        
        [self.button setTitle:@"提现到现金余额" forState:UIControlStateNormal];
        
    }
}

@end
