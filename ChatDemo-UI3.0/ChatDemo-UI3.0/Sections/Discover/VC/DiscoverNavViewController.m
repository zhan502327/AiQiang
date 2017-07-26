//
//  DiscoverNavViewController.m
//  Aiqiang
//
//  Created by 闫世宗 on 16/10/14.
//  Copyright © 2016年 闫世宗. All rights reserved.
//

#import "DiscoverNavViewController.h"
#import "DiscoverViewController.h"

@interface DiscoverNavViewController ()

@end

@implementation DiscoverNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DiscoverViewController *discoverVC = [[UIStoryboard storyboardWithName:@"Discover" bundle:nil] instantiateViewControllerWithIdentifier:@"DiscoverViewController"];
    self.viewControllers = @[discoverVC];
    
}

-(void)click{

    NSLog(@"发布");
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
