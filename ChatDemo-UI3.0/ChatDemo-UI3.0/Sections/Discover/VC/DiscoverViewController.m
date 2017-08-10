//
//  DiscoverViewController.m
//  ChatDemo-UI3.0
//
//  Created by 常豪野 on 2017/4/13.
//  Copyright © 2017年 常豪野. All rights reserved.
//

#import "DiscoverViewController.h"
#import "Discover.h"
#import "DiscoverCell.h"
#import "CircleDetailViewController.h"
#import "DiscoverPublishViewController.h"
#import "OtherPersonInfoViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "DiscoverTool.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#import "DBShareView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface DiscoverViewController ()<UIGestureRecognizerDelegate>

{
    int page;
}
@property (nonatomic,strong)NSMutableArray *messageList;

@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingTableView *discoverTableView;

@property (nonatomic, weak) UIView *blackview;
@property (nonatomic, weak) DBShareView *shareView;

@end

@implementation DiscoverViewController

-(NSMutableArray *)messageList{

    if (!_messageList) {
        self.messageList=[[NSMutableArray alloc]init];
    }
    return _messageList;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataAfterPublishDiscover) name:@"reloadDataAfterPublishDiscover" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self configUI];
    [self loadData];

    //添加手势
    [self addAGesutreRecognizerForYourView];
}

- (void)configUI{
    self.title = @"发 现";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(issueClick)];
    
    self.discoverTableView.tableFooterView = [[UIView alloc] init];
    self.discoverTableView.backgroundColor = [UIColor whiteColor];
    self.discoverTableView.rowHeight = UITableViewAutomaticDimension;
    self.discoverTableView.estimatedRowHeight = 200;
    
    
    self.discoverTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page = 1;
        [self loadData];
    }];
    
    self.discoverTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->page ++;
        [self loadData];
    }];
    
}

- (void)initData{
    page = 1;

}

- (void)addAGesutreRecognizerForYourView

{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    gestureRecognizer.numberOfTapsRequired = 1;
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [self.discoverTableView addGestureRecognizer:gestureRecognizer];
}

- (void) hideKeyboard:(UITapGestureRecognizer *)recognizer

{
    [self.view endEditing:YES];
    
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



- (void)loadData{
    NSDictionary *param = @{@"uid": User_ID,@"page": [NSString stringWithFormat:@"%d",page]};
    [Discover discoverLIstWithParam:param successBlock:^(NSString *msg, NSMutableArray *modelArray, NSNumber *status) {
        [self endRefresh];
        if (self->page == 1) {
            [self.messageList removeAllObjects];
        }
        
        [self.messageList addObjectsFromArray:modelArray];
        [self.discoverTableView reloadData];

    } errorBlock:^(NSError *error) {
        [self endRefresh];
        [self showHint:@"网络错误"];
    }];

}

- (void)endRefresh{
    [self.discoverTableView.mj_header endRefreshing];
    [_discoverTableView.mj_footer endRefreshing];
}

- (void)reloadDataAfterPublishDiscover{
    [self.discoverTableView.mj_header beginRefreshing];
}

#pragma mark - 发布按钮的点击方法
-(void)issueClick{
    NSLog(@"点击了发布按钮");
    DiscoverPublishViewController *vc = [[DiscoverPublishViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.messageList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Discover *model=self.messageList[indexPath.row];
    NSString *cellid = [DiscoverCell getReuseID:model];
    
    DiscoverCell *cell=[self.tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    typeof(cell) weakcell = cell;
    
    //头像block
    [cell setIconImageViewBlock:^{
        OtherPersonInfoViewController *vc = [[OtherPersonInfoViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.uid = model.uid;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //点赞blcok
    [cell setFirstButtonBlock:^{
        NSString *action;
        if ([model.is_liked isEqualToString:@"1"]) {
//            action = @"unliked";
//            weakcell.firstButton.selected = NO;
    
        }else{
            action = @"liked";
            weakcell.firstButton.selected = YES;
            NSDictionary *param = @{@"uid":User_ID, @"cid":model.discoverID ,@"act":action};
            [DiscoverTool circleSetLikedWithParam:param successBlock:^(NSString *msg, NSNumber *status) {
                [self showHint:msg];
                if ([status intValue] == 1) {
                    
                    model.is_liked = @"1";
                    model.liked = [NSString stringWithFormat:@"%d",[model.liked intValue] + 1];
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
                    
                }
            } errorBlock:^(NSError *error) {
                [self showHint:@"网络错误"];
            }];
        }

        
    }];
    //评论block
    [cell setSecondButtonBlock:^{
        
        Discover *message=self.messageList[indexPath.row];
        
        CircleDetailViewController *vc = [[CircleDetailViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.discoverModel = message;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    //分享block
    [cell setThirdButtonBlock:^{
        [self blackview];
        [self shareView];
    }];
    //图片block
    [cell setImageViewClickedBlock:^(NSInteger index, NSMutableArray *imageArray, UIImageView *imageView,NSMutableArray *imageViewArray){
        
        //1.创建图片浏览器
        MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
        
        //2.告诉图片浏览器显示所有的图片
        NSMutableArray *photos = [NSMutableArray array];
        for (int i = 0 ; i < imageViewArray.count; i++) {
            //传递数据给浏览器
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.url = [NSURL URLWithString:model.img[i][@"url"]];
            photo.srcImageView = imageViewArray[i]; //设置来源哪一个UIImageView
            [photos addObject:photo];
        }
        brower.photos = photos;
        
        //3.设置默认显示的图片索引
        brower.currentPhotoIndex = index;
        
        //4.显示浏览器
        [brower show];
        
    }];
    //评论block
    [cell setSendPingLunBlock:^(NSString *textfieldText){
        weakcell.pingLunTextField.text = nil;
        weakcell.pingLunTextField.placeholder = @"评论";
        [weakcell.pingLunTextField resignFirstResponder];
        NSDictionary *param = @{@"uid":User_ID,@"cid":model.discoverID,@"pid":@"0",@"reid":@"0",@"content":textfieldText,@"reuid":model.uid};
        [DiscoverTool replyPinglunWithSuccessBlockWithPram:param successBlock:^(NSMutableArray *array, NSString *msg, NSNumber *status) {
            [self showHint:msg];
            if ([status intValue] == 1) {
                model.comment = [NSString stringWithFormat:@"%d",[model.comment intValue] + 1];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
            }
            
        } errorBlock:^(NSError *error) {
            [self showHint:@"网络错误"];
        }];
    }];
    
    cell.message = model;
    
    return cell;
}


#pragma mark - 返回不同行的行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Discover *message= self.messageList[indexPath.row];
    return [DiscoverCell getRowHeight:message];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Discover *message=self.messageList[indexPath.row];

    CircleDetailViewController *vc = [[CircleDetailViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.discoverModel = message;
    [vc setDeleteDiscoverReloadDataBlock:^{
        [self.discoverTableView.mj_header beginRefreshing];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
