//
//  NSObject+Category.m
//  PianKe
//
//  Created by 闫世宗 on 16/1/8.
//  Copyright © 2016年 YSZ. All rights reserved.
//

#import "NSObject+Category.h"
//#import "RegisterOrLoginViewController.h"

@implementation NSObject (Category)


- (id)initWithDic:(NSDictionary *)dictionary {
    return [self init];
}

- (void)alertShowWithTitle:(NSString *)title Message:(NSString *)message Onebutton:(NSString *)button {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:button otherButtonTitles:nil, nil];
    [alert show];
}

- (void)gotoLoginFromVC:(UIViewController *)vc {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *login = [UIAlertAction actionWithTitle:@"前往登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        RegisterOrLoginViewController *registerVC = [[RegisterOrLoginViewController alloc] initWithNibName:@"RegisterOrLoginViewController" bundle:[NSBundle mainBundle]];
//        [vc presentViewController:registerVC animated:YES completion:^{
//            
//        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:login];
    [alertVC addAction:cancel];
    [vc presentViewController:alertVC animated:YES completion:^{
    }];
    

    
}

@end
