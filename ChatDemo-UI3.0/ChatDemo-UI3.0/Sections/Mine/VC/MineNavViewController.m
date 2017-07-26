//
//  MineNavViewController.m
//  Aiqiang
//
//  Created by 闫世宗 on 16/10/14.
//  Copyright © 2016年 闫世宗. All rights reserved.
//

#import "MineNavViewController.h"
#import "DBMineViewController.h"

@interface MineNavViewController ()

@end

@implementation MineNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    MineViewController *mineVC = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"MineViewController"];
    
    
    DBMineViewController *mineVC = [[DBMineViewController alloc] init];
    
    self.viewControllers = @[mineVC];
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
