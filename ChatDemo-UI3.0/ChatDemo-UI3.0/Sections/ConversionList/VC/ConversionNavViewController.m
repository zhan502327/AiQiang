//
//  ConversionNavViewController.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/21.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "ConversionNavViewController.h"
#import "ConversationListController.h"

@interface ConversionNavViewController ()

@end

@implementation ConversionNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ConversationListController *conversationListVC = [[ConversationListController alloc] initWithNibName:nil bundle:nil];
    conversationListVC.navigationItem.title = @"会 话";
    
    self.viewControllers = @[conversationListVC];
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
