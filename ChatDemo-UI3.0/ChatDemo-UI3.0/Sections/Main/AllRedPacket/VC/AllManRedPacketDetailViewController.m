//
//  AllManRedPacketDetailViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "AllManRedPacketDetailViewController.h"
#import "AllManRedPacketDetailTool.h"
#import "AllManRedPacketTool.h"
#import "AllManRedPacketPinglunViewController.h"
#import "SellerRedBagTool.h"
#import "StealRedBagView.h"
#import <WebKit/WebKit.h>
#import "OtherPersonInfoViewController.h"

#define FromeAllMan @"allMan"
#define FromMyCollection @"myCollection"
#define FromMyRedBag @"myRedBag"
#define FromSellerRedBag @"sellerRedBag"

#define BottomViewHeight 200
#define PlaceHolderStr @"我有话要说~~"


@interface AllManRedPacketDetailViewController ()<UIWebViewDelegate>
{
    BOOL clickZan;
    BOOL clickShouCang;
    BOOL firstZan;
    BOOL firstShoucang;
    
    int addZan;
    int addShouCang;
    
    NSString *rid;
    NSString *ID;
    
    int second;
}

@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) UIButton *redPacketButton;
@property (nonatomic, weak) UIButton *zanButton;
@property (nonatomic, weak) UIButton *pinglunButton;
@property (nonatomic, weak) UIButton *shoucangButton;

@property (nonatomic, copy) NSString *fromWhere;
@property (nonatomic, strong) AllManRedPacketDetailModel *detailModel;
@property (nonatomic, weak) StealRedBagView *stealView;


//
@property (nonatomic, assign) CGFloat webViewHeight;
@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, weak) UIView *buttonView;
@property (nonatomic, weak) UIView *inputView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIButton *sendMessageButton;

@property (nonatomic, copy) NSString *textFieldtext;

@property (nonatomic, assign) BOOL showRightItem;

@property (nonatomic, strong) NSTimer *time;

@end

@implementation AllManRedPacketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
    [self initData];
    [self loadData];
    [self webView];
    
    
    self.time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(less) userInfo:nil repeats:YES];
    self.redPacketButton.backgroundColor = [UIColor grayColor];
    self.redPacketButton.userInteractionEnabled = NO;
    //发送成功,倒计时开始
    second = 10;
}

- (void)less {
    second--;
    [self.redPacketButton setTitle:[NSString stringWithFormat:@"倒计时：%ld s", (long)second] forState:UIControlStateNormal];
    if (second == 0) {
        [self.time invalidate];
        [self.redPacketButton setTitle:@"开始抢红包" forState:UIControlStateNormal];
        self.redPacketButton.userInteractionEnabled = YES;
        self.redPacketButton.backgroundColor = [UIColor redColor];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    // 添加对键盘的监控
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyBoardWillShow:(NSNotification *) note {
    self.textField.text = nil;
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘高度
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [self.view bringSubviewToFront:self.inputView];
    // 定义好动作
    void (^animation)(void) = ^void(void) {
//        self.inputView.transform = CGAffineTransformMakeTranslation(0, - keyBoardHeight);
        self.bottomView.transform = CGAffineTransformMakeTranslation(0, - keyBoardHeight);
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
    
}

- (void)keyBoardWillHide:(NSNotification *) note {
    self.textField.text = nil;
    self.textField.placeholder = PlaceHolderStr;
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 定义好动作
    void (^animation)(void) = ^void(void) {
//        self.inputView.transform = CGAffineTransformIdentity;
        self.bottomView.transform = CGAffineTransformIdentity;
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}

- (void)keyBoardDidHide:(NSNotification *)note{
    self.textFieldtext = nil;
}

- (UIView *)inputView{
    if (_inputView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        view.layer.masksToBounds = YES;
        view.layer.borderColor = [UIColor grayColor].CGColor;
        view.layer.borderWidth = 0.5;
        view.frame = CGRectMake(0, BottomViewHeight - 45, SCREEN_WIDTH, 45);

        [self.bottomView addSubview:view];
        
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(SCREEN_WIDTH - 10 - 60 , 5, 60, 35);
        button.backgroundColor = [UIColor redColor];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5;
        [button setTitle:@"发送" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sendMessageButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [view addSubview:button];
        _sendMessageButton = button;
        
        
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(10, 5, SCREEN_WIDTH - 100, 35);
        textField.layer.masksToBounds = YES;
        textField.layer.borderColor = [UIColor grayColor].CGColor;
        textField.layer.borderWidth = 0.5;
        textField.layer.cornerRadius = 4;
        textField.backgroundColor = [UIColor whiteColor];
        textField.placeholder = PlaceHolderStr;
        textField.textAlignment = NSTextAlignmentLeft;
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor = [UIColor blackColor];
        [textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
        [view addSubview:textField];
        _textField = textField;
        
        _inputView = view;
    }
    return _inputView;
}

- (void)textFieldValueChanged:(UITextField *)textfield{
    
    self.textFieldtext = textfield.text;
}
- (void)sendMessageButtonClicked{
    
    [self.textField resignFirstResponder];
    if (self.textFieldtext.length == 0) {
        [self showHint:@"请输入评论内容"];
        return;
    }
    
    
    NSLog(@"发送评论");
    if ([self.fromWhere isEqualToString:FromSellerRedBag]) {//商家红包
        NSDictionary *param = @{@"uid":User_ID, @"id":self.detailModel.ID ,@"comment":self.textFieldtext};

        [self sendCommentSellerRedBagWithParam:param];
    }
    
    
    if ([self.fromWhere isEqualToString:FromeAllMan]) {//全民红包
        NSDictionary *param = @{@"uid":User_ID, @"rid":self.detailModel.ID ,@"comment":self.textFieldtext};
        
        [self sendCommentAllManRedBagWithParam:param];
    }
    
    
    if ([self.fromWhere isEqualToString:FromMyCollection]) {
        NSString *redBagType = self.mycollectionModel.type;
        if ([redBagType intValue] == 1) {//商家红包
            
            NSDictionary *param = @{@"uid":User_ID, @"id":self.detailModel.ID ,@"comment":self.textFieldtext};
            
            [self sendCommentSellerRedBagWithParam:param];
            
        }else{
            NSDictionary *param = @{@"uid":User_ID, @"rid":self.detailModel.ID ,@"comment":self.textFieldtext};
            
            [self sendCommentAllManRedBagWithParam:param];
        }
    }
    
}

- (void)sendCommentAllManRedBagWithParam:(NSDictionary *)param{
    
    [AllManRedPacketTool allManRedBagSendCommentWithParam:param successBlock:^(NSString *msg, NSNumber *num) {
        [self showHint:msg];
        if ([num intValue] == 1) {
            [self loadData];
        }
        
    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
    
}

- (void)sendCommentSellerRedBagWithParam:(NSDictionary *)param{
    
    [SellerRedBagTool selletRedBagSendCommnetWithParam:param successBlock:^(NSString *msg, NSNumber *num) {
        
        [self showHint:msg];
        if ([num intValue] == 1) {
            [self loadData];
        }

    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];

    }];
}
- (UIView *)bottomView{
    if (_bottomView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        
        [self.webView.scrollView addSubview:view];
        _bottomView = view;
    }
    return _bottomView;
}

- (UIView *)buttonView{
    if (_buttonView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        [self.bottomView addSubview:view];
        _buttonView = view;
    }
    return _buttonView;
}


- (UIWebView *)webView{
    if (_webView == nil) {
        UIWebView *view = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        view.delegate = self;
        view.userInteractionEnabled = YES;
        view.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
        
        [self.view addSubview:view];
        
        _webView = view;
    }
    return _webView;
}

#pragma msrk - webview delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, BottomViewHeight, 0);
    
    CGFloat webViewHeight = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    
    self.webViewHeight = webViewHeight;
    
    self.bottomView.frame = CGRectMake(0, webViewHeight, SCREEN_WIDTH, BottomViewHeight);
    
    self.buttonView.frame = CGRectMake(0, 0, SCREEN_WIDTH, BottomViewHeight - 40);
    
    self.redPacketButton.frame = CGRectMake(100, 10, SCREEN_WIDTH - 200, 40);
    
    self.zanButton.frame = CGRectMake(SCREEN_WIDTH/2 - 25 - 20 - 50, CGRectGetMaxY(_redPacketButton.frame) + 50, 50, 20);

    self.pinglunButton.frame = CGRectMake(CGRectGetMaxX(_zanButton.frame) + 20 , CGRectGetMinY(_zanButton.frame), 50, 20);
    
    self.shoucangButton.frame = CGRectMake(CGRectGetMaxX(_pinglunButton.frame) + 20 , CGRectGetMinY(_zanButton.frame), 50, 20);

    [self inputView];
}

- (void)initData{
    clickZan = NO;
    clickShouCang = NO;
    firstZan = NO;
    firstShoucang = NO;
    
    self.showRightItem = NO;
    
    addZan = 0;
    addShouCang = 0;
}

- (StealRedBagView *)stealView{
    if (_stealView == nil) {
        StealRedBagView *view = [[StealRedBagView alloc] init];
        _stealView = view;
    }
    return _stealView;
}

- (void)setAllManmodel:(AllManRedPacketListModel *)allManmodel{
    _allManmodel = allManmodel;
    rid = allManmodel.ID;
    self.fromWhere = FromeAllMan;
}

- (void)setMycollectionModel:(MyCollectionListModel *)mycollectionModel{
    _mycollectionModel = mycollectionModel;
    rid = mycollectionModel.rid;
    self.fromWhere = FromMyCollection;
    
}

- (void)setMyRedBagModel:(MyRedBagListModel *)myRedBagModel{
    _myRedBagModel = myRedBagModel;
    rid = myRedBagModel.ID;
    self.fromWhere = FromMyRedBag;
}

- (void)setSellerRedBagModel:(SellerRedBagListModel *)sellerRedBagModel{
    _sellerRedBagModel = sellerRedBagModel;
    ID = sellerRedBagModel.ID;
    self.fromWhere = FromSellerRedBag;
}
- (void) loadData{
    
    NSString *redbagType;
    NSDictionary *dic;
    
    if ([self.fromWhere isEqualToString:FromSellerRedBag]) {
        redbagType = Seller_RedBagType;
        dic = @{@"uid":User_ID,@"id":self.sellerRedBagModel.ID};
        
    }

    if ([self.fromWhere isEqualToString:FromeAllMan]) {
        redbagType = AllMan_RedBagType;
        dic = @{@"uid":User_ID,@"rid":self.allManmodel.ID};
        
    }
    
    if ([self.fromWhere isEqualToString:FromMyCollection]) {
        
        if ([self.mycollectionModel.type isEqualToString:@"1"]) {
            redbagType = Seller_RedBagType;
            dic = @{@"uid":User_ID,@"id":self.mycollectionModel.rid};
            
        }else{
            redbagType = AllMan_RedBagType;
            dic = @{@"uid":User_ID,@"rid":self.mycollectionModel.rid};
            
        }
    }
    
    if ([self.fromWhere isEqualToString:FromMyRedBag]) {
        redbagType = AllMan_RedBagType;
        dic = @{@"uid":User_ID,@"rid":self.myRedBagModel.ID};
        
    }
    

    [AllManRedPacketDetailTool getRedPacketDetailWithSuccessBlockWithPram:dic andRedBagType:redbagType successBlock:^(AllManRedPacketDetailModel *model) {
        self.detailModel = model;
        
        NSString *HTMLData = self.detailModel.Description;
        [self.webView loadHTMLString:HTMLData baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        
        if ([model.is_liked isEqualToString:@"0"]) {
            self.zanButton.selected = NO;
            self->firstZan = NO;
            self->clickZan = NO;
        }else{
            self.zanButton.selected = YES;
            self->firstZan = YES;
            self->clickZan = YES;
        }
        
        if ([model.is_followed isEqualToString:@"0"]) {
            self.shoucangButton.selected = NO;
            self->firstShoucang = NO;
            self->clickShouCang = NO;
        }else{
            self.shoucangButton.selected = YES;
            self->firstShoucang = YES;
            self->clickShouCang = YES;
        }
        
        [self.zanButton setTitle:model.liked forState:UIControlStateNormal];
        [self.pinglunButton setTitle:model.comment forState:UIControlStateNormal];
        [self.shoucangButton setTitle:model.followed forState:UIControlStateNormal];

    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
  
}
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"红包详情";
    
    if ([self.fromWhere isEqualToString:FromeAllMan]) {
        
        UIBarButtonItem *iteme = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"group_detail@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
        self.navigationItem.rightBarButtonItem = iteme;
    }
}


- (void)rightBarButtonItemClick{
    
    NSString *uid = @"";
    if ([self.fromWhere isEqualToString:FromeAllMan]) {
        uid = self.allManmodel.uid;
    }
    OtherPersonInfoViewController *vc = [[OtherPersonInfoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.uid = uid;
    [self.navigationController pushViewController:vc animated:YES];
}


- (UIButton *)redPacketButton{
    if (_redPacketButton == nil) {
        UIButton *button = [[UIButton alloc] init];
//        button.frame = CGRectMake(100, 10, SCREEN_WIDTH - 200, 40);
        [button setTitle:@"倒计时：10 s" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor redColor];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5;
        [button addTarget:self action:@selector(setealRedBagClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:button];
        _redPacketButton = button;
    }
    return _redPacketButton;
}

- (void)setealRedBagClicked{
    NSLog(@"偷抢红包按钮被点击");
    if ([self.fromWhere isEqualToString:FromSellerRedBag]) {//商家红包
        NSDictionary *param = @{@"uid":User_ID,@"id":self.sellerRedBagModel.ID};
        [self stealSellerRedBagWith:param];
    }
    
    
    if ([self.fromWhere isEqualToString:FromeAllMan]) {//全民红包
        NSDictionary *param = @{@"uid":User_ID,@"rid":self.allManmodel.ID};
        [self stealAllManRedBagWith:param];
    }
    
    
    if ([self.fromWhere isEqualToString:FromMyCollection]) {
        NSString *redBagType = self.mycollectionModel.type;
        if ([redBagType intValue] == 1) {//商家红包
            NSDictionary *param = @{@"uid":User_ID,@"id":self.mycollectionModel.rid};
            [self stealSellerRedBagWith:param];
        }else{
            NSDictionary *param = @{@"uid":User_ID,@"rid":self.mycollectionModel.rid};
            [self stealAllManRedBagWith:param];
        }
    }
    
}

- (void)stealSellerRedBagWith:(NSDictionary *)param{
    
    [SellerRedBagTool stealSellerRedBagWirthParam:param successBlock:^(StealRedBagResult *result) {
        
        switch ([result.status intValue]) {
            case 0:
                [self showHint:result.msg];
                break;
            case 1:
                [self.stealView configViewWithStatus:1 Moeny:result.monsyStr andNickName:self.sellerRedBagModel.title andImageName:[NSString stringWithFormat:@"%@%@",www,self.sellerRedBagModel.img]];
                break;
            case 2:
                [self showHint:result.msg];
                
                break;
            case 3:
                [self showHint:result.msg];
                
                break;
            case 4:
                [self showHint:result.msg];
                
                break;
            case 5:
                [self showHint:result.msg];
                
                break;
            case 6:
                
                [self.stealView configViewWithStatus:0 Moeny:nil andNickName:nil andImageName:[NSString stringWithFormat:@"%@%@",www,self.sellerRedBagModel.img]];
                break;
            default:
                break;
        }
    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

- (void)stealAllManRedBagWith:(NSDictionary *)param{
    [AllManRedPacketTool stealAllManRedBagWithParam:param successBlock:^(StealRedBagResult *result) {
        if ([result.status intValue] == 1) {
            [self.stealView configViewWithStatus:1 Moeny:result.monsyStr andNickName:self.allManmodel.nickname andImageName:[NSString stringWithFormat:@"%@%@",www,self.allManmodel.headimg]];
            
        }else if ([result.status intValue] == 5){
            [self.stealView configViewWithStatus:0 Moeny:nil andNickName:nil andImageName:[NSString stringWithFormat:@"%@%@",www,self.allManmodel.headimg]];
        }else{
            [self showHint:result.msg];
        }
    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

- (UIButton *)zanButton{
    if (_zanButton == nil) {
        UIButton *button = [[UIButton alloc] init];
//        button.frame = CGRectMake(SCREEN_WIDTH/2 - 25 - 20 - 50, CGRectGetMaxY(_redPacketButton.frame) + 50, 50, 20);
        [button setImage:[UIImage imageNamed:@"zan_unselect"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"zan_"] forState:UIControlStateSelected];
        [button setTitle:@"0" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(zanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        button.imageEdgeInsets = UIEdgeInsetsMake(0.0, -10, 0.0, 0.0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.buttonView addSubview:button];
        _zanButton = button;
    }
    return _zanButton;
}

- (void)zanButtonClicked{
    NSString *resultStr = nil;
    if (clickZan == YES) {
        resultStr = @"unliked";
    }else{
        resultStr = @"liked";
    }
    
    NSString *redbagType;
    NSDictionary *dic;
    if ([self.fromWhere isEqualToString:FromSellerRedBag]) {
        redbagType = Seller_RedBagType;
        dic = @{@"uid":User_ID,@"id":self.detailModel.ID,@"act":resultStr};

    }
    
    if ([self.fromWhere isEqualToString:FromeAllMan]) {
        redbagType = AllMan_RedBagType;
        dic = @{@"uid":User_ID,@"rid":self.detailModel.ID,@"act":resultStr};

    }
    
    if ([self.fromWhere isEqualToString:FromMyCollection]) {
    
        if ([self.mycollectionModel.type isEqualToString:@"1"]) {
            redbagType = Seller_RedBagType;
            dic = @{@"uid":User_ID,@"id":self.detailModel.ID,@"act":resultStr};

        }else{
            redbagType = AllMan_RedBagType;
            dic = @{@"uid":User_ID,@"rid":self.detailModel.ID,@"act":resultStr};

        }
    }
    
    if ([self.fromWhere isEqualToString:FromMyRedBag]) {
        redbagType = AllMan_RedBagType;
        dic = @{@"uid":User_ID,@"rid":self.detailModel.ID,@"act":resultStr};

    }
    
    [AllManRedPacketTool redBagClickZanWithParam:dic andRedBagType:redbagType successBlock:^(NSString *msg) {
        
        int count = [self.detailModel.liked intValue];
        
        if (self->firstZan == YES) {
            if (self->clickZan == YES) {
                [self.zanButton setTitle:[NSString stringWithFormat:@"%d",(count-1)] forState:UIControlStateNormal];
            }else{
                [self.zanButton setTitle:[NSString stringWithFormat:@"%d",(count)] forState:UIControlStateNormal];
            }
            
        }else{
            if (self->clickZan == YES) {
                [self.zanButton setTitle:[NSString stringWithFormat:@"%d",(count)] forState:UIControlStateNormal];
            }else{
                [self.zanButton setTitle:[NSString stringWithFormat:@"%d",(count + 1)] forState:UIControlStateNormal];
            }
        }
        self->clickZan = !self->clickZan;
        self.zanButton.selected = self->clickZan;
    } errorBlock:^(NSError *erreo) {
        [self showHint:@"网络错误"];
    }];
}

- (UIButton *)pinglunButton{
    if (_pinglunButton == nil) {
        UIButton *button = [[UIButton alloc] init];
//        button.frame = CGRectMake(CGRectGetMaxX(_zanButton.frame) + 20 , CGRectGetMinY(_zanButton.frame), 50, 20);
        [button setImage:[UIImage imageNamed:@"comment_"] forState:UIControlStateNormal];
        [button setTitle:@"0" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pinglunButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.buttonView addSubview:button];

        _pinglunButton = button;
    }
    return _pinglunButton;
}

- (UIButton *)shoucangButton{
    if (_shoucangButton == nil) {
        UIButton *button = [[UIButton alloc] init];
//        button.frame = CGRectMake(CGRectGetMaxX(_pinglunButton.frame) + 20 , CGRectGetMinY(_zanButton.frame), 50, 20);
        [button setImage:[UIImage imageNamed:@"collect_unselect"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"collect_"] forState:UIControlStateSelected];
        [button setTitle:@"0" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(shoucangButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0.0, 0.0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.buttonView addSubview:button];
        [self.view bringSubviewToFront:button];

        _shoucangButton = button;
    }
    return _shoucangButton;
}

- (void)shoucangButtonClicked{
    
    NSString *resultStr = nil;
    if (clickShouCang == YES) {
        resultStr = @"unfollowed";
    }else{
        resultStr = @"followed";
    }
    NSString *redbagType;
    NSDictionary *dic;
    if ([self.fromWhere isEqualToString:FromSellerRedBag]) {
        redbagType = Seller_RedBagType;
        dic = @{@"uid":User_ID,@"id":self.detailModel.ID,@"act":resultStr};

    }
    
    if ([self.fromWhere isEqualToString:FromeAllMan]) {
        redbagType = AllMan_RedBagType;
        dic = @{@"uid":User_ID,@"rid":self.detailModel.ID,@"act":resultStr};

    }
    
    if ([self.fromWhere isEqualToString:FromMyCollection]) {
        
        if ([self.mycollectionModel.type isEqualToString:@"1"]) {
            redbagType = Seller_RedBagType;
            dic = @{@"uid":User_ID,@"id":self.detailModel.ID,@"act":resultStr};

        }else{
            redbagType = AllMan_RedBagType;
            dic = @{@"uid":User_ID,@"rid":self.detailModel.ID,@"act":resultStr};

        }
    }
    
    if ([self.fromWhere isEqualToString:FromMyRedBag]) {
        redbagType = AllMan_RedBagType;
        dic = @{@"uid":User_ID,@"rid":self.detailModel.ID,@"act":resultStr};
    }
    
    [AllManRedPacketTool collectionRedBagWithParam:dic andRedBagType:redbagType successBlock:^(NSString *msg) {
        [MBProgressHUD showSuccess:msg toView:self.view];
        
        int count = [self.detailModel.followed intValue];
        
        if (self->firstShoucang == YES) {
            if (self->clickShouCang == YES) {
                [self.shoucangButton setTitle:[NSString stringWithFormat:@"%d",(count-1)] forState:UIControlStateNormal];
            }else{
                [self.shoucangButton setTitle:[NSString stringWithFormat:@"%d",(count)] forState:UIControlStateNormal];
            }
            
        }else{
            if (self->clickShouCang == YES) {
                [self.shoucangButton setTitle:[NSString stringWithFormat:@"%d",(count)] forState:UIControlStateNormal];
            }else{
                [self.shoucangButton setTitle:[NSString stringWithFormat:@"%d",(count + 1)] forState:UIControlStateNormal];
            }
        }
        
        self->clickShouCang = !self->clickShouCang;
        
        self.shoucangButton.selected = self->clickShouCang;

    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
   
}



- (void)pinglunButtonClicked{
    
    AllManRedPacketPinglunViewController *vc = [[AllManRedPacketPinglunViewController alloc] init];
    vc.redBagID = self.detailModel.ID;

    if ([self.fromWhere isEqualToString:FromSellerRedBag]) {
        vc.redBagType = Seller_RedBagType;
    }
    
    if ([self.fromWhere isEqualToString:FromeAllMan]) {
        vc.redBagType = AllMan_RedBagType;
    }
    
    if ([self.fromWhere isEqualToString:FromMyCollection]) {
        
        if ([self.mycollectionModel.type isEqualToString:@"1"]) {
            vc.redBagType = Seller_RedBagType;
        }else{
            vc.redBagType = AllMan_RedBagType;
        }
    }
    
    if ([self.fromWhere isEqualToString:FromMyRedBag]) {
        vc.redBagType = AllMan_RedBagType;
    }
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
