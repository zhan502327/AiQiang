//
//  FriendNavViewController.m
//  Aiqiang
//
//  Created by 闫世宗 on 16/10/14.
//  Copyright © 2016年 闫世宗. All rights reserved.
//

#import "FriendNavViewController.h"
#import "ContactListViewController.h"

@interface FriendNavViewController ()

@end

@implementation FriendNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ContactListViewController *contactsVC = [[ContactListViewController alloc] initWithNibName:nil bundle:nil];
    contactsVC.navigationItem.title = @"好 友";
    self.viewControllers = @[contactsVC];
}

@end
