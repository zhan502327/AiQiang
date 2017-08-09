//
//  CircleDetailViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/24.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "CircleDetailViewController.h"
#import "DiscoverCell.h"
#import "DiscoverDetailTableViewCell.h"
#import "DiscoverDetailPinglunModel.h"
#import "DiscoverHuifuModek.h"
#import "DiscoverPingLunTableViewCell.h"
#import "DiscoverDetailReplyTableViewCell.h"
#import "UILabel+ReplyLabel.h"
#import "DiscoverTool.h"
#import "OtherPersonInfoViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "DBShareView.h"
#import "MyDiscoverTool.h"

#define PlaceHolderStr @"我有话要说~~"

@interface CircleDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>

{
    CGFloat detailViewHeight;
    
    NSIndexPath *index;
    
    BOOL firstZan;
    BOOL clickZan;

}
@property (nonatomic, weak) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, weak) UIView *inputView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIButton *sendMessageButton;

@property (nonatomic, copy) NSString *textFieldText;
@property (nonatomic, weak) UIView *blackview;
@property (nonatomic, weak) DBShareView *shareView;
@end



@implementation CircleDetailViewController

- (void)setCid:(NSString *)cid{
    _cid = cid;
    NSDictionary *param = @{@"uid":User_ID, @"cid":cid};
    
    [MyDiscoverTool oneCircleWithParam:param successBlock:^(Discover *model, NSString *msg, NSNumber *status) {
        self.discoverModel = model;
        [self loadData];
    } errorBlock:^(NSError *error) {
        
    }];
}

- (void)setDiscoverModel:(Discover *)discoverModel{
    _discoverModel = discoverModel;
    
    if ([discoverModel.is_liked isEqualToString:@"0"]) {
//        self.zanButton.selected = NO;
        self->firstZan = NO;
        self->clickZan = NO;
    }else{
//        self.zanButton.selected = YES;
        self->firstZan = YES;
        self->clickZan = YES;
    }
    
    if ([discoverModel.uid isEqualToString:User_ID]) {//删除动态
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(deleteDiscover)];
        self.navigationItem.rightBarButtonItem = item;
        
    }
    
}

- (void)deleteDiscover{
    NSDictionary *param = @{@"uid":User_ID, @"cid":self.discoverModel.discoverID};
    [DiscoverTool deleteDiscoverWith:param successBlock:^(NSString *msg, NSNumber *status) {
        [self showHint:msg];
        if ([status intValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
            if (self->_deleteDiscoverReloadDataBlock) {
                self->_deleteDiscoverReloadDataBlock();
            }
        }
    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpUI];
    [self initData];
    if (self.cid.length == 0) {
        [self loadData];
    }
    [self refreshData];
    

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
- (DBShareView *)shareView{
    if (_shareView == nil) {
        DBShareView *shareViw = [DBShareView viewWithFrame:CGRectMake(0, SCREEN_HEIGHT - 120, SCREEN_HEIGHT, 120) andShareType:5 andMoney:nil];
        [[UIApplication sharedApplication].keyWindow addSubview:shareViw];
        _shareView = shareViw;
    }
    return _shareView;
}


- (void)blackViwClicked{
    [self.view endEditing:YES];
    [self.blackview removeFromSuperview];
    [self.shareView removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 添加对键盘的监控
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
        self.inputView.transform = CGAffineTransformMakeTranslation(0, - keyBoardHeight);
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
        self.inputView.transform = CGAffineTransformIdentity;
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}

- (void)setUpUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"圈子详情";
    
    [self inputView];

}

- (UIView *)inputView{
    if (_inputView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        view.layer.masksToBounds = YES;
        view.layer.borderColor = [UIColor grayColor].CGColor;
        view.layer.borderWidth = 0.5;
        view.frame = CGRectMake(0, SCREEN_HEIGHT - 64 - 45, SCREEN_WIDTH, 45);
        [self.view addSubview:view];
        [self.view bringSubviewToFront:view];
        
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
    self.textFieldText = textfield.text;
}

- (void)sendMessageButtonClicked{
    [self.textField resignFirstResponder];
    self.count = 1;
    
    if (index) {
        NSArray *array = self.dataSource[index.section-1];
        if (index.row == 0) {
            DiscoverDetailPinglunModel *model = array[0];
            [DiscoverTool replyPinglunWithSuccessBlockWithPram:@{@"uid":User_ID,@"cid":self.discoverModel.discoverID,@"pid":model.ID,@"reid":model.ID,@"content":self.textFieldText,@"reuid":model.uid} successBlock:^(NSMutableArray *array, NSString *msg, NSNumber *status) {
                [self showHint:msg];

                if ([status intValue] == 1) {
                    self.discoverModel.comment = [NSString stringWithFormat:@"%d",[self.discoverModel.comment intValue] + 1];
                    [(NSMutableArray *)self.dataSource removeAllObjects];
                    [self loadData];
                }
            } errorBlock:^(NSError *error) {
                [self showHint:@"网络错误"];
            }];
            
        }else{
            DiscoverDetailPinglunModel *pinglunmodel = array[0];
            DiscoverHuifuModek *replyModel = array[index.row];
            [DiscoverTool replyPinglunWithSuccessBlockWithPram:@{@"uid":User_ID,@"cid":self.discoverModel.discoverID,@"pid":replyModel.ID,@"reid":pinglunmodel.ID,@"content":self.textFieldText,@"reuid":replyModel.uid} successBlock:^(NSMutableArray *array, NSString *msg, NSNumber *status) {
                
                [self showHint:msg];
                if ([status intValue]== 1) {
                    self.discoverModel.comment = [NSString stringWithFormat:@"%d",[self.discoverModel.comment intValue] + 1];

                    [(NSMutableArray *)self.dataSource removeAllObjects];
                    [self loadData];
                }
            } errorBlock:^(NSError *error) {
                [self showHint:@"网络错误"];
            }];
        }
        
        index = nil;
    }else{
        NSDictionary *param = @{@"uid":User_ID,@"cid":self.discoverModel.discoverID,@"pid":@"0",@"reid":@"0",@"content":self.textFieldText,@"reuid":self.discoverModel.uid};
        [DiscoverTool replyPinglunWithSuccessBlockWithPram:param successBlock:^(NSMutableArray *array, NSString *msg, NSNumber *status) {
            self.discoverModel.comment = [NSString stringWithFormat:@"%d",[self.discoverModel.comment intValue] + 1];

            [self showHint:msg];
            if ([status intValue] == 1) {
                
                
                [self.dataSource removeAllObjects];
                [self loadData];
            }
      
        } errorBlock:^(NSError *error) {
            
            [self showHint:@"网络错误"];
        }];
        
    }
    
}

- (void)initData{
    
//    firstZan = NO;
//    clickZan = NO;
    
    
    self.count = 1;
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
}

- (void)loadData{
    
    [DiscoverDetailPinglunModel discoverPinglunWithSuccessBlockWithPram:@{@"uid":User_ID,@"page":@"1",@"cid":self.discoverModel.discoverID} successBlock:^(NSMutableArray *array, int pageCount) {

        [self.dataSource addObjectsFromArray:array];
        [self.tableView reloadData];
    } errorBlock:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
}

- (void)refreshData{

    __weak CircleDetailViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        self.count = 1;
        [DiscoverDetailPinglunModel discoverPinglunWithSuccessBlockWithPram:@{@"uid":User_ID,@"page":@"1",@"cid":self.discoverModel.discoverID} successBlock:^(NSMutableArray *array, int pageCount) {

            if ([self.dataSource isKindOfClass:[NSMutableArray class]]) {
                [self.dataSource removeAllObjects];
                
                self.dataSource = array;
                [self.tableView reloadData];
            }else{
                
            }
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        } errorBlock:^(NSError *error) {
            [weakSelf showHint:@"网络错误"];
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        }];
        
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
         weakSelf.count ++;
        NSString *pageCount = [NSString stringWithFormat:@"%ld",(long)weakSelf.count];
        [DiscoverDetailPinglunModel discoverPinglunWithSuccessBlockWithPram:@{@"uid":User_ID,@"page":pageCount,@"cid":self.discoverModel.discoverID} successBlock:^(NSMutableArray *array, int pageCount) {
            
            if ([self.dataSource isKindOfClass:[NSMutableArray class]]) {
                [self.dataSource addObjectsFromArray:array];
                [self.tableView reloadData];
            }

            [weakSelf.tableView.infiniteScrollingView stopAnimating];

        } errorBlock:^(NSError *error) {
            [weakSelf showHint:@"网络错误"];
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
        }];
        
     
    }];
    
    
}

- (TPKeyboardAvoidingTableView *)tableView
{
    if (_tableView == nil) {
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 45) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.backgroundColor = ColorTableViewBg;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view insertSubview:tableView atIndex:1];
        _tableView = tableView;
    }
    return _tableView ;
}
#pragma mark - tableView delegate and tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        NSArray *array = self.dataSource[section-1];
        return array.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        Discover *model = self.discoverModel;
        
        CGFloat imageHeight = 0;
        if (model.img.count == 0) {
            imageHeight = 10;
        }else{
            
            if (model.img.count == 1) {
                imageHeight = 200;
            }else if (model.img.count > 3){
                imageHeight = 200;
            }else{
                imageHeight = 99;
            }
        }
        CGFloat h = 0;
        if (model.content.length > 0) {
            h = 20;
        }
        
        return 90 + imageHeight + model.labelHeight + h;
    
    }else{
        NSArray *sectionArray = self.dataSource[indexPath.section-1];
        if (indexPath.row == 0) {
            DiscoverDetailPinglunModel *model = sectionArray[0];
            CGRect labelSize = [model.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 60, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil] context:nil];
            
            
            return labelSize.size.height + 60;
        }else{
            DiscoverHuifuModek *model = sectionArray[indexPath.row];
            
            NSString *nameOne = model.nickname;
            NSString *nameTwo = model.re_name;
            NSString *replyString = model.content;
            
            NSString *totalString = [NSString stringWithFormat:@"%@回复%@：%@",nameOne,nameTwo,replyString];
            NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithString:totalString];
            [newString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, totalString.length)];
            [newString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, nameOne.length)];
            [newString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(nameOne.length+2, nameTwo.length)];
            //设置行距 实际开发中间距为0太丑了，根据项目需求自己把握
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = 0;
            [newString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, totalString.length)];
            
            CGRect labelSize = [totalString boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20 -40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil] context:nil];
            return labelSize.size.height + 30  ;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        DiscoverDetailTableViewCell *cell = [DiscoverDetailTableViewCell normalTableViewCellWithTableView:tableView];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.discoverModel;
        [cell setGetCellHeight:^(CGFloat height) {
            self->detailViewHeight = height;
        }];
        
        typeof(cell) weakcell = cell;
        
        
        //图片被点击
        [cell setImageArrayBlcock:^(NSMutableArray *imageArray){
        
  
        }];
        
        //头像被点击
        [cell setIconImageViewBlock:^{
            
            OtherPersonInfoViewController *vc = [[OtherPersonInfoViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.uid = self.discoverModel.uid;
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
        //点赞block实现
        [cell setZanButtonClickedBlock:^{
            NSLog(@"点赞button被点击");
            NSString *action;
            if ([self.discoverModel.is_liked isEqualToString:@"1"]) {
                action = @"unliked";
//                weakcell.detailView.zanButton.selected = NO;
//                self.discoverModel.is_liked = @"0";
                
            }else{
                action = @"liked";
//                weakcell.detailView.zanButton.selected = YES;
                self.discoverModel.is_liked = @"1";
                
                
                NSDictionary *param = @{@"uid":User_ID, @"cid":self.discoverModel.discoverID ,@"act":action};
                [DiscoverTool circleSetLikedWithParam:param successBlock:^(NSString *msg, NSNumber *status) {
                    [self showHint:msg];
                    if ([status intValue] == 1) {
                        int count = [self.discoverModel.liked intValue];
                        
                        if (self->firstZan == YES) {
                            if (self->clickZan == YES) {
                                [weakcell.detailView.zanButton setTitle:[NSString stringWithFormat:@"%d",(count-1)] forState:UIControlStateNormal];
                            }else{
                                [weakcell.detailView.zanButton setTitle:[NSString stringWithFormat:@"%d",(count)] forState:UIControlStateNormal];
                            }
                            
                        }else{
                            if (self->clickZan == YES) {
                                [weakcell.detailView.zanButton setTitle:[NSString stringWithFormat:@"%d",(count)] forState:UIControlStateNormal];
                            }else{
                                [weakcell.detailView.zanButton setTitle:[NSString stringWithFormat:@"%d",(count + 1)] forState:UIControlStateNormal];
                            }
                        }
                        self->clickZan = !self->clickZan;
                        weakcell.detailView.zanButton.selected = self->clickZan;
                    }
                } errorBlock:^(NSError *error) {
                    [self showHint:@"网络错误"];
                }];

            }
            
        }];
        //评论block实现
        [cell setPinglunButtonClickedBlock:^{
            NSLog(@"评论button被点击");
            
        }];
        //分享block实现
        [cell setShareButtonClickedBlock:^{
            NSLog(@"分享button被点击");
            [self blackview];
            [self shareView];
            
        }];
    
        return cell;
    }else{
        NSArray *array = self.dataSource[indexPath.section-1];
        if (indexPath.row == 0) {
            DiscoverDetailPinglunModel *model = array[0];
            DiscoverPingLunTableViewCell *cell = [DiscoverPingLunTableViewCell normalTableViewCellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            [cell setIconImageViewVBlock:^{
                OtherPersonInfoViewController *vc = [[OtherPersonInfoViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.uid = model.uid;
                [self.navigationController pushViewController:vc animated:YES];
            }];
            return cell;
        }else{
            DiscoverDetailReplyTableViewCell *cell = [DiscoverDetailReplyTableViewCell normalTableViewCellWithTableView:tableView];
            DiscoverHuifuModek *model = array[indexPath.row];
            cell.model = model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentLabel onTapRangeActionWithString:@[model.nickname,model.re_name] tapClicked:^(NSString *string, NSRange range, NSInteger inde) {
                if (inde == 0) {
                    OtherPersonInfoViewController *vc = [[OtherPersonInfoViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.uid = model.uid;
                    [self.navigationController pushViewController:vc animated:YES];

                }else{
                    OtherPersonInfoViewController *vc = [[OtherPersonInfoViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.uid = model.re_uid;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }];
            return cell;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.textField.text = nil;
    if (indexPath.section == 0) {
        [self.textField becomeFirstResponder];
    }else{
        index = indexPath;
        [self.textField becomeFirstResponder];
        NSArray *array = self.dataSource[indexPath.section-1];
        if (indexPath.row == 0) {
            DiscoverDetailPinglunModel *model = array[0];
            NSString *placeHnolder = [NSString stringWithFormat:@"回复%@:",model.nickname];
            self.textField.placeholder = placeHnolder;
        }else{
            DiscoverHuifuModek *model = array[indexPath.row];

            NSString *placeHnolder = [NSString stringWithFormat:@"回复%@:",model.nickname];
            self.textField.placeholder = placeHnolder;
        }
    }
}

//HeaderInSection  &&  FooterInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (section == 0) {
        UIView *backView = [[UIView alloc]init];
        backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
        backView.backgroundColor = [UIColor whiteColor];
        if (self.dataSource.count == 0) {
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
            label.text = @"暂时一个评论都没有";
            label.backgroundColor = [UIColor whiteColor];
            label.textColor = DBGrayColor;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = DBMidFont;
            [backView addSubview:label];
            UIView *lineview = [[UIView alloc] init];
            lineview.backgroundColor = ColorTableViewBg;
            lineview.frame = CGRectMake(15, 0, SCREEN_WIDTH- 15, 0.5);
            [backView addSubview:lineview];
        }else{
            UIView *lineview = [[UIView alloc] init];
            lineview.backgroundColor = ColorTableViewBg;
            lineview.frame = CGRectMake(15, 0, SCREEN_WIDTH- 15, 0.5);
            [backView addSubview:lineview];
        }
        return backView;
    }else
    {
        return nil;
    }
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    if (section == 0) {
        
        if (self.dataSource.count == 0) {
            return 40;
        }
        return 0.5;
    }else{
        return 0.0000001;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.textField resignFirstResponder];
}


@end
