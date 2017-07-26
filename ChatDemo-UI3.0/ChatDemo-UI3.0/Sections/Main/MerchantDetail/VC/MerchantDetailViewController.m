//
//  MerchantDetailViewController.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/14.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "MerchantDetailViewController.h"
#import "GotRedPacket.h"
#import "MerchantCommentViewController.h"
#import "AllManRedPacketDetailTool.h"
#import "AllManRedPacketDetailModel.h"

@interface MerchantDetailViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *grabButton;

@property (weak, nonatomic) IBOutlet UILabel *zanNumber;
@property (weak, nonatomic) IBOutlet UILabel *commentNumber;
@property (weak, nonatomic) IBOutlet UILabel *collectNumber;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UITextField *inPut;

@property (nonatomic, strong) AllManRedPacketDetailModel *detailModel;

@end

@implementation MerchantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommentView];
    [self setupUI];
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupCommentView{
    self.commentView.layer.cornerRadius = 5;
    self.commentView.clipsToBounds = YES;
    self.commentView.layer.borderColor = [UIColor colorWithRed:0.900 green:0.216 blue:0.205 alpha:1.000].CGColor;
    self.commentView.layer.borderWidth = 1;
    
    self.grabButton.layer.cornerRadius = 5;
    self.grabButton.clipsToBounds = YES;

}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"红包详情";
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 26, 40)];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:backButton]];
    
    UIButton *locationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 46)];
    [locationButton setImage:[UIImage imageNamed:@"location.png"] forState:UIControlStateNormal];
    [locationButton addTarget:self action:@selector(location:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:locationButton]];
}

- (void)loadData{
//    NSString *rid = self.model.ID;
    
//    NSDictionary *dic = @{@"uid":User_ID,@"rid":rid};
//    [AllManRedPacketDetailTool getRedPacketDetailWithSuccessBlockWithPram:dic andRedBagType:2 successBlock:^(AllManRedPacketDetailModel *model) {
//        
//        self.detailModel = model;
//
//    } errorBlock:^(NSError *error) {
//        [self showHint:@"网络错误"];
//    }];
    
}
- (void)keyboardShow:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];    
    _bottom.constant = rect.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboardHide:(NSNotification *)noti {
    _bottom.constant = 30;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - ButtonAction

- (IBAction)grabAction:(id)sender {
    [[NetworkManager new] postWithURL:[NSString stringWithFormat:@"%@/api.php/RedBags/doRedbag", www] parameter:@{@"uid": User_ID, @"id": _redPacketID} success:^(id obj) {
        if ([obj[@"status"] isEqualToNumber:@1]) {
            CATransition *transition = [CATransition animation];
            transition.duration = 0.3;
            transition.type = @"fade";
            [self.view.layer addAnimation:transition forKey:nil];
            GotRedPacket *view = [[[NSBundle mainBundle] loadNibNamed:@"GotRedPacket" owner:nil options:nil] objectAtIndex:0];
            [view setType:1 AndNumber:obj[@"data"][@"price"]];
            view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
            [self.view addSubview:view];
        } else if ([obj[@"status"] isEqualToNumber:@6]) {
            CATransition *transition = [CATransition animation];
            transition.duration = 0.3;
            transition.type = @"fade";
            [self.view.layer addAnimation:transition forKey:nil];
            GotRedPacket *view = [[[NSBundle mainBundle] loadNibNamed:@"GotRedPacket" owner:nil options:nil] objectAtIndex:0];
            [view setType:0 AndNumber:@0];
            view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
            [self.view addSubview:view];
        } else {
            [self showHint:obj[@"msg"]];
        }
    } fail:^(NSError *error) {
        
    }];

}

- (IBAction)zanAction:(id)sender {
    UIButton *button = sender;
    NSString *act = @"";
    if (button.selected) {
        act = @"unliked";
    } else {
        act = @"liked";
    }
    [[NetworkManager new] postWithURL:[NSString stringWithFormat:@"%@/api.php/RedBags/setLiked", www] parameter:@{@"uid": User_ID, @"id": self.redPacketID, @"act": act} success:^(id obj) {
        if ([obj[@"status"] isEqualToNumber:@1]) {
            if (button.selected) {
                button.selected = NO;
                self->_zanNumber.text = [NSString stringWithFormat:@"%ld", [self->_zanNumber.text integerValue] - 1];
            } else {
                self->_zanNumber.text = [NSString stringWithFormat:@"%ld", [self->_zanNumber.text integerValue] + 1];
                button.selected = YES;
            }
        }
        [self showHint:obj[@"msg"]];
    } fail:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
    
}

- (IBAction)commentAction:(id)sender {
    [self performSegueWithIdentifier:@"comment" sender:nil];
}

- (IBAction)collectAction:(id)sender {
    UIButton *button = sender;
    NSString *act = @"";
    if (button.selected) {
        act = @"unfollowed";
    } else {
        act = @"followed";
    }
    [[NetworkManager new] postWithURL:[NSString stringWithFormat:@"%@/api.php/RedBags/setFollowed", www] parameter:@{@"uid": User_ID, @"id": self.redPacketID, @"act": act} success:^(id obj) {
        if ([obj[@"status"] isEqualToNumber:@1]) {
            if (button.selected) {
                button.selected = NO;
                self->_collectNumber.text = [NSString stringWithFormat:@"%ld", [self->_collectNumber.text integerValue] - 1];
            } else {
                self->_collectNumber.text = [NSString stringWithFormat:@"%ld", [self->_collectNumber.text integerValue] + 1];
                button.selected = YES;
            }
        }
        [self showHint:obj[@"msg"]];

    } fail:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

- (IBAction)sendAction:(id)sender {
    [_inPut resignFirstResponder];
    if (!_inPut.text.length) {
        [self showHint:@"评论内容不能为空"];
        return;
    }
    [[NetworkManager new] postWithURL:[NSString stringWithFormat:@"%@/api.php/RedBags/sendComment", www] parameter:@{@"uid": User_ID, @"id": self.redPacketID, @"comment": _inPut.text} success:^(id obj) {
        if ([obj[@"status"] isEqualToNumber:@1]) {
            self->_inPut.text = @"";
            self->_commentNumber.text = [NSString stringWithFormat:@"%ld", [self->_commentNumber.text integerValue] + 1];
        }
        [self showHint:obj[@"msg"]];
    } fail:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}



- (void)back:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)location:(UIButton *)button {
    NSLog(@"定位");
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_inPut resignFirstResponder];
    if (!_inPut.text.length) {
        [self showHint:@"评论内容不能为空"];
        return YES;
    }
    [[NetworkManager new] postWithURL:[NSString stringWithFormat:@"%@/api.php/RedBags/sendComment", www] parameter:@{@"uid": User_ID, @"id": self.redPacketID, @"comment": _inPut.text} success:^(id obj) {
        if ([obj[@"status"] isEqualToNumber:@1]) {
            self->_commentNumber.text = [NSString stringWithFormat:@"%ld", [self->_commentNumber.text integerValue] + 1];
            self->_inPut.text = @"";
        }
        [self showHint:obj[@"msg"]];

    } fail:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"comment"]) {
        MerchantCommentViewController *vc = [segue destinationViewController];
        vc.redPacketID = _redPacketID;
    }
}


@end
