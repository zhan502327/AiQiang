//
//  DBChatBlackListViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/20.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBChatBlackListViewController.h"

@interface DBChatBlackListViewController ()

@end

@implementation DBChatBlackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI{
    self.title = @"黑名单";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
