//
//  DBAddFriendViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/8.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBAddFriendViewController.h"
#import "FriendsListTool.h"

@interface DBAddFriendViewController ()<UITextViewDelegate>

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *sexAndAgeLabel;

@property (nonatomic, weak) UILabel *tipLabel;
@property (nonatomic, weak) UITextView *textView;

@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UIView *bottomView;

@property (nonatomic, copy) NSString *textViewStr;

@end

@implementation DBAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


- (UIView *)topView{
    if (_topView == nil) {
        UIView *topview= [[UIView alloc] init];
        topview.backgroundColor = [UIColor clearColor];
        topview.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 80);
        [self.view addSubview:topview];
        _topView = topview;
    }
    return _topView;
}


- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, 10, 60, 60);
        imageView.layer.masksToBounds = YES;
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.layer.cornerRadius = 30;
        [self.topView addSubview:imageView];
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 15, CGRectGetMinY(_iconImageView.frame), SCREEN_WIDTH - CGRectGetMaxX(_iconImageView.frame) - 5, 30);
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self.topView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)sexAndAgeLabel{
    if (_sexAndAgeLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_nameLabel.frame), _nameLabel.frame.size.width, 30);
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self.topView addSubview:label];
        _sexAndAgeLabel = label;
    }
    return _sexAndAgeLabel;
}

- (UIView *)bottomView{
    if (_bottomView == nil) {
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor clearColor];
        bottomView.frame = CGRectMake(10, CGRectGetMaxY(_topView.frame) + 10, SCREEN_WIDTH - 20, 200);
        bottomView.layer.masksToBounds = YES;
        bottomView.layer.cornerRadius = 5;
        [self.view addSubview:bottomView];
        _bottomView = bottomView;
    }
    return _bottomView;
}
- (UILabel *)tipLabel{
    if (_tipLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10,10, 200, 20);
        
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"请填写验证信息";
        [self.bottomView addSubview:label];
        _tipLabel = label;
    }
    return _tipLabel;
}

- (UITextView *)textView{
    if (_textView == nil) {
        UITextView *view = [[UITextView alloc] init];
        view.frame = CGRectMake(10, CGRectGetMaxY(self.tipLabel.frame)+ 10, _bottomView.frame.size.width - 20, 130);
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 5;
        view.delegate = self;
        view.font = [UIFont systemFontOfSize:14];
        view.backgroundColor = [UIColor whiteColor];
        view.textColor = [UIColor blackColor];
        [self.bottomView addSubview:view];
        _textView = view;
    }
    return _textView;
}

- (void)setupUI{
    self.view.backgroundColor = ColorTableViewBg;
    self.title = @"添加好友";
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(addFriend)];
    self.navigationItem.rightBarButtonItem = itme;
}

- (void)addFriend{
    [self.view endEditing:YES];
    NSString *message = self.textViewStr;
    NSString *buddyName = self.userInfoModel.uid;
    
    if (buddyName && buddyName.length > 0) {
        
        [self showHudInView:self.view hint:NSLocalizedString(@"friend.sendApply", @"sending application...")];
        NSDictionary *param = @{@"uid":User_ID,@"to_uid":buddyName,@"msg":message};
        [FriendsListTool sendFriendCheckWithParam:param successBlock:^(NSString *msg, NSNumber *status) {
            if ([status intValue] == 1) {
                EMError *error = [[EMClient sharedClient].contactManager addContact:buddyName message:message];
                [self hideHud];
                if (error) {
                    [self showHint:NSLocalizedString(@"friend.sendApplyFail", @"send application fails, please operate again")];
                }
                else{
                    [self showHint:NSLocalizedString(@"friend.sendApplySuccess", @"send successfully")];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                [self showHint:msg];
            }
        } errorBlock:^(NSError *error) {
            [self showHint:@"网络错误"];
        }];
    }
}


- (void)setUserInfoModel:(UserInfoModel *)userInfoModel{
    _userInfoModel = userInfoModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",www,userInfoModel.headimg]] placeholderImage:[UIImage imageNamed:@"head_placeholder"]];
    self.nameLabel.text = userInfoModel.nickname;

    NSString *sex = userInfoModel.sex.length > 0 ? userInfoModel.sex : @"";
    NSString *age = [NSString stringWithFormat:@"%@",userInfoModel.age];
    age = age.length > 0 ? age : @"";
    if (age.length == 0) {
        self.sexAndAgeLabel.text = [NSString stringWithFormat:@"%@",sex];

    }else{
        self.sexAndAgeLabel.text = [NSString stringWithFormat:@"%@  %@岁",sex,age];

    }
    NSString *textViewStr = [NSString stringWithFormat:@"我是%@",User_NickName];
    self.textView.text = textViewStr;
    self.textViewStr = textViewStr;
}


- (void)textViewDidChange:(UITextView *)textView{
    self.textViewStr = textView.text;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
