//
//  PublishRedBagViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/9.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "PublishRedBagViewController.h"
#import "RedBagButonTableViewCell.h"
#import "RedBagTextFieldTableViewCell.h"
#import "TPKeyboardAvoidingTableView.h"
#import "RedbagTextViewTableViewCell.h"
#import "RedBagAddimageTableViewCell.h"
#import "UzysAssetsPickerController.h"
#import "DBPhotoModel.h"
#import "AllManRedPacketTool.h"
#import "InPutPasswordview.h"
#import "MineTool.h"
#import "RedBagChainTool.h"
#import "DBImageManger.h"

@interface PublishRedBagViewController ()<UITableViewDelegate,UITableViewDataSource,UzysAssetsPickerControllerDelegate, UITextViewDelegate>
@property (nonatomic, weak) TPKeyboardAvoidingTableView *tableView;

@property (nonatomic, strong) NSMutableArray *photosArray;//添加的图片数组
@property (nonatomic, strong) NSMutableArray *deleteImages;//删除的图片数组
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, copy) NSString *redBagtitle;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *total_amount;
@property (nonatomic, copy) NSString *sex;


@property (nonatomic, weak) UIView *blackview;
@property (nonatomic, weak) UIView *choosePayTypeView;
@property (nonatomic, weak) InPutPasswordview *passWordView;

@property (nonatomic, copy) NSString *rmb;
@property (nonatomic, copy) NSString *balance;

@end

@implementation PublishRedBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initData];
    [self tableView];
    [self addNotice];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 添加对键盘的监控
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)keyBoardWillShow:(NSNotification *) note {
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
        self.inputView.transform = CGAffineTransformMakeTranslation(0, - keyBoardHeight);
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
    
}

- (void)keyBoardWillHide:(NSNotification *) note {
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.inputView.transform = CGAffineTransformIdentity;
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}


- (UIView *)blackview{
    if (_blackview == nil) {
        UIView *view = [[UIView alloc] init];
        view.userInteractionEnabled = YES;
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.7;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackViwClicked)];
        [view addGestureRecognizer:tap];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        _blackview = view;
    }
    return _blackview;
}

- (void)blackViwClicked{
    [self.view endEditing:YES];
    [self.blackview removeFromSuperview];
    [self.choosePayTypeView removeFromSuperview];
    [self.passWordView removeFromSuperview];

    
}

- (UIView *)choosePayTypeView{
    if (_choosePayTypeView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        view.frame = CGRectMake(20, SCREEN_HEIGHT/4, SCREEN_WIDTH - 40, 320);
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 5;
        
        [self configChoosePayTypeViewWith:view];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        _choosePayTypeView = view;
    }
    return _choosePayTypeView;
}

- (void)configChoosePayTypeViewWith:(UIView *)view{
    
    //取消按钮
    UIButton *cancelbutton = [[UIButton alloc] init];
    cancelbutton.frame = CGRectMake(0, 10, 30, 30);
    [cancelbutton setImage:[UIImage imageNamed:@"closer_1"] forState:UIControlStateNormal];
    [cancelbutton addTarget:self action:@selector(cancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelbutton];
    
    
    //支付label
    UILabel *titlelabel = [[UILabel alloc] init];
    titlelabel.frame = CGRectMake(CGRectGetMaxX(cancelbutton.frame), 10, view.frame.size.width - 60, 30);
    titlelabel.text = @"支付";
    titlelabel.textColor = [UIColor blackColor];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont systemFontOfSize:17];
    [view addSubview:titlelabel];
    
    
    //lineView
    UIView *topLineView = [[UIView alloc] init];
    topLineView.frame =CGRectMake(0, CGRectGetMaxY(cancelbutton.frame) + 10, view.frame.size.width, 0.5);
    topLineView.backgroundColor = [UIColor grayColor];
    [view addSubview:topLineView];
    
    //选择支付方式
    UILabel *payTypeLabel = [[UILabel alloc] init];
    payTypeLabel.frame = CGRectMake(0, CGRectGetMaxY(topLineView.frame)+20, view.frame.size.width, 30);
    payTypeLabel.textAlignment = NSTextAlignmentCenter;
    payTypeLabel.textColor = [UIColor grayColor];
    payTypeLabel.text = @"选择支付方式";
    payTypeLabel.font = [UIFont systemFontOfSize:17];
    [view addSubview:payTypeLabel];
    
    //金额Label
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.textColor = [UIColor blackColor];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.font = [UIFont systemFontOfSize:40];
    moneyLabel.frame = CGRectMake(0, CGRectGetMaxY(payTypeLabel.frame)+ 20, view.frame.size.width, 60);
    moneyLabel.tag = 10;
    [view addSubview:moneyLabel];
    
    //lineView
    UIView *firstLineView = [[UIView alloc] init];
    firstLineView.frame = CGRectMake(10, CGRectGetMaxY(moneyLabel.frame) + 20, view.frame.size.width - 10, 0.5);
    firstLineView.backgroundColor = [UIColor grayColor];
    [view addSubview:firstLineView];
    
    //
    NSArray *titleArray = @[@"现金余额",@"红包余额"];
    
    for (int i = 0; i<titleArray.count; i++) {
        
        //money图标
        UIImageView *moneyImageView = [[UIImageView alloc] init];
        moneyImageView.image = [UIImage imageNamed:@"paytype_money"];
        moneyImageView.frame = CGRectMake(10, CGRectGetMaxY(firstLineView.frame) + 10 + 50.5 *i, 30, 30);
        moneyImageView.layer.masksToBounds = YES;
        moneyImageView.layer.cornerRadius = 15;
        [view addSubview:moneyImageView];
        
        //箭头图标
        UIImageView *arrowImageView = [[UIImageView  alloc] init];
        arrowImageView.image = [UIImage imageNamed:@"right_1"];
        arrowImageView.frame = CGRectMake(view.frame.size.width - 10 - 20, CGRectGetMaxY(firstLineView.frame) + 15 + 50.5 *i, 20, 20);
        [view addSubview:arrowImageView];
        
        //余额
        UILabel *resultMoneyLabel = [[UILabel alloc] init];
        resultMoneyLabel.textColor = [UIColor blackColor];
        resultMoneyLabel.frame = CGRectMake(CGRectGetMaxX(moneyImageView.frame) + 10, CGRectGetMaxY(firstLineView.frame) + 50.5*i, CGRectGetMinX(arrowImageView.frame) - CGRectGetMaxX(moneyImageView.frame)  , 50);
        resultMoneyLabel.textAlignment = NSTextAlignmentLeft;
        resultMoneyLabel.font = [UIFont systemFontOfSize:17];
        resultMoneyLabel.tag = 100 + i;
        [view addSubview:resultMoneyLabel];
        
        //分割线
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor grayColor];
        lineView.frame = CGRectMake(CGRectGetMinX(moneyImageView.frame), CGRectGetMaxY(firstLineView.frame) + 50 + 50.5 *i, view.frame.size.width - 10, 0.5);
        [view addSubview:lineView];
        
        //透明按钮
        UIButton *chooseButton = [[UIButton alloc] init];
        chooseButton.frame = CGRectMake(0, CGRectGetMinY(resultMoneyLabel.frame) , view.frame.size.width, 50);
        chooseButton.backgroundColor = [UIColor clearColor];
        [chooseButton addTarget:self action:@selector(choosetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        chooseButton.tag = 200 + i;
        [view addSubview:chooseButton];
        
        
    }
    
}

- (void)choosetButtonClicked:(UIButton *)button{
    NSString *type;
    if (button.tag == 200) {
        type = @"r";
    }
    if (button.tag == 201) {
        type = @"b";
    }
    [self.choosePayTypeView removeFromSuperview];
    [self.passWordView.passwordView.textField becomeFirstResponder];
    self.passWordView.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[self.total_amount floatValue]];
    
    [self.passWordView.passwordView setSixNumberBlock:^(NSString *password){
        
        [self.passWordView.passwordView.textField resignFirstResponder];
        NSDictionary *param = @{@"uid":User_ID,@"pay_password":password};
        
        [RedBagChainTool checkPayPasswordWithParam:param successBlock:^(NSString *msg, NSNumber *status) {
            [self showHint:msg];
            if ([status intValue] == 1) {
                
                //数据
                NSString *title = (self.redBagtitle == nil) ? @"" : self.redBagtitle;
                NSString *des = (self.desc == nil) ? @"" : self.desc;
                NSString *num = (self.num == nil) ? @"" : self.num;
                NSString *total_amount = (self.total_amount == nil) ? @"" : self.total_amount;
                total_amount = [NSString stringWithFormat:@"%.2f",[total_amount floatValue]];
                
                NSDictionary *dic = @{@"title":title,@"desc":des,@"num":num,@"total_amount":total_amount,@"uid":User_ID,@"sex":self.sex,@"type":type};
                
                NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:0];
                if (self.datas.count > 0) {
                    for (int i = 0; i<self.datas.count; i++) {
                        UIImage *image = [UIImage imageWithData:self.datas[i]];
                        NSData *imageData =  [DBImageManger imageMangerWithImage:image andMaxSize:50];
                        
                        UIImage *after_image = [UIImage imageWithData:imageData];
                        [imageArray addObject:after_image];
                    }
                }
                
                [[NetworkManager new] networkWithURL:AllManRedBagPublishRedBagURL imageArray:imageArray parameter:dic success:^(id obj) {
                    
                    int status = [obj[@"status"] intValue];
                    NSString *msg = obj[@"msg"];
                    [self showHint:msg];

                    if (status == 1) {
                        
                        [self.blackview removeFromSuperview];
                        [self.choosePayTypeView removeFromSuperview];
                        [self.passWordView removeFromSuperview];
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }
                    
                } fail:^(NSError *error) {
                    
                    [self showHint:@"网络错误"];

                }];
            }else{
                [self showHint:msg];
                [self.blackview removeFromSuperview];
                [self.choosePayTypeView removeFromSuperview];
                [self.passWordView removeFromSuperview];
            }
        } errorBlock:^(NSError *error) {
            [self showHint:@"网络错误"];
            
        }];
    }];
}



- (void)cancleButtonClick{
    [self.view endEditing:YES];
    [self.blackview removeFromSuperview];
    [self.choosePayTypeView removeFromSuperview];
    [self.passWordView removeFromSuperview];
}

- (InPutPasswordview *)passWordView{
    if (_passWordView == nil) {
        InPutPasswordview *contentView = [InPutPasswordview viewWithFrame:CGRectMake(20, SCREEN_HEIGHT/4, SCREEN_WIDTH - 40, (SCREEN_WIDTH - 40)/6 + 150)];
        [[UIApplication sharedApplication].keyWindow addSubview:contentView];
        _passWordView = contentView;
    }
    return _passWordView;
}



- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发红包";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendRedBag)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)sendRedBag{
    [self.view endEditing:YES];
    
    //数据
    NSString *title = (self.redBagtitle == nil) ? @"" : self.redBagtitle;
    NSString *des = (self.desc == nil) ? @"" : self.desc;
    NSString *num = (self.num == nil) ? @"" : self.num;
    NSString *total_amount = (self.total_amount == nil) ? @"" : self.total_amount;
    total_amount = [NSString stringWithFormat:@"%.2f",[total_amount floatValue]];
    
    if (total_amount.length == 0) {
        [self showHint:@"请输入红包金额"];
        return ;
    }
    
    if (num.length == 0 ) {
        [self showHint:@"请输入红包个数"];
        return;
    }
    
    if (title.length == 0) {
        [self showHint:@"请输入标题"];
        return;
    }
    
    if (des.length == 0) {
        [self showHint:@"请输入内容"];
        return;
    }

    
    NSDictionary *moneyParam = @{@"uid":User_ID};
    [MineTool userMoneyWithSuccessBlockWithPram:moneyParam successBlock:^(NSString *rmb, NSString *balance) {
        self.rmb = rmb;
        
        self.balance = balance;
        
        [self blackview];
        UILabel *moneylabel = [self.choosePayTypeView viewWithTag:10];
        moneylabel.text = [NSString stringWithFormat:@"¥ %@",total_amount];
        
        UILabel *firstLabel = [self.choosePayTypeView viewWithTag:100];
        firstLabel.text = [NSString stringWithFormat:@"现金余额（余额 ¥%@）",self.rmb];
        
        UILabel *secondLabel = [self.choosePayTypeView viewWithTag:101];
        secondLabel.text = [NSString stringWithFormat:@"红包余额（余额 ¥%@）",self.balance];
    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

- (void)initData{
    self.sex = @"0";
}

- (NSMutableArray *)photosArray {
    if (_photosArray == nil) {
        _photosArray = [NSMutableArray array];
    }
    return _photosArray;
}

- (NSMutableArray *)deleteImages{
    if (_deleteImages == nil) {
        _deleteImages = [NSMutableArray array];
    }
    return _deleteImages;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        tableView.backgroundColor = ColorTableViewBg;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [[UIView alloc] init];
        
        [self.view insertSubview:tableView atIndex:1];
        _tableView = tableView;
    }
    return _tableView ;
}
#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 2;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 50;
        }else{
            return 200;
        }

    }else{
        
        if (self.photosArray.count == 0 || self.photosArray.count == 1 || self.photosArray.count == 2) {
            return 100;
        }else{
            return 190;
        }
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            RedBagTextFieldTableViewCell *cell = [RedBagTextFieldTableViewCell normalTableViewCellWithTableView:tableView];
            cell.nameLabel.text = @"总金额：";
            cell.rightLabel.text = @"元";
            cell.textField.tag = 100;
            [cell.textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
            return cell;
        }else if (indexPath.row == 1){
            RedBagTextFieldTableViewCell *cell = [RedBagTextFieldTableViewCell normalTableViewCellWithTableView:tableView];
            cell.nameLabel.text = @"红包个数：";
            cell.rightLabel.text = @"个";
            cell.textField.tag = 101;
            [cell.textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
            return cell;
        }else{
            RedBagButonTableViewCell *cell = [RedBagButonTableViewCell normalTableViewCellWithTableView:tableView];
            [cell setFirstBlcok:^{
                self.sex = @"1";
            }];
            
            [cell setSecongBlock:^{
                self.sex = @"2";
                
            }];
            
            [cell  setThirdBlock:^{
                self.sex = @"0";
                
            }];
            return cell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            RedbagTextViewTableViewCell *cell = [RedbagTextViewTableViewCell normalTableViewCellWithTableView:tableView];
            cell.nameLabel.text = @"标题：";
            cell.textView.tag = 200;
            cell.textView.delegate = self;
            return cell;
            
        }else{
            RedbagTextViewTableViewCell *cell = [RedbagTextViewTableViewCell normalTableViewCellWithTableView:tableView];
            cell.nameLabel.text = @"内容：";
            cell.textView.tag = 201;
            cell.textView.delegate = self;
            return cell;
            
        }
    }else{//添加图片
        RedBagAddimageTableViewCell *cell = [RedBagAddimageTableViewCell normalTableViewCellWithTableView:tableView];
        cell.photosArray = self.photosArray;
        [cell setAddimageButtonBlock:^{
           
            UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
            picker.delegate = self;
            picker.maximumNumberOfSelectionVideo = 0;
            picker.maximumNumberOfSelectionPhoto = 6 - self.photosArray.count;
            [self presentViewController:picker animated:YES completion:^{
                
            }];


        }];
        self.datas = [cell.photos_view datas];
        return cell;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.tag == 200) {
        self.redBagtitle = textView.text;
    }else{
        self.desc = textView.text;
    }
}


- (void)textFieldValueChanged:(UITextField *)textField{
    
    if (textField.tag == 100) {
        self.total_amount = textField.text;
    }else{
        self.num = textField.text;
    }
}

//图片选择之后的回调
- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) {
        // Photo
        NSMutableArray *array = [NSMutableArray array];
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *asset = obj;
            DBPhotoModel *photo = [[DBPhotoModel alloc] init];
            photo.pic = asset.defaultRepresentation.url.absoluteString;
            photo.asset = asset;
            photo.showDelete = YES;
            [array addObject:photo];
            [self.photosArray addObject:photo];
        }];
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}


- (void)addNotice {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(deleteImage:) name:IWImagesDeleteNotification object:nil];
}

- (void)deleteImage:(NSNotification *)notification {
    NSString *url = notification.userInfo[IWImagesDeleteNotificationPic];
    NSMutableArray *tempImages = [NSMutableArray array];
    for (DBPhotoModel *photo in self.photosArray) {
        if ([photo.pic isEqualToString:url]) {
            [self.deleteImages addObject:url];
        } else {
            [tempImages addObject:photo];
        }
    }
    self.photosArray = tempImages;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
//HeaderInSection  &&  FooterInSection

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 0, SCREEN_WIDTH - 40, 15);
    label.text = @"注：您可以指定抢此红包人的性别";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:9];
    label.textAlignment = NSTextAlignmentLeft;
    if (section == 0) {
        [backView addSubview:label];
    }
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }else{
        return 10;
    }
}

@end
