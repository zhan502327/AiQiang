//
//  DBWebViewViewController.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/6/20.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBWebViewViewController.h"

@interface DBWebViewViewController ()

@property (nonatomic, weak) UIWebView *webview;

@end

@implementation DBWebViewViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    

}

- (void)setType:(NSString *)type{
    _type = type;
    
    if ([type isEqualToString:@"yong_hu_xie_yi"]) {
        
        self.title = @"用户协议";
        NSURL* url = [NSURL URLWithString:@"http://www.iiqiang.com/Home/Help/agreement"];//创建URL
        
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        
        [self.webview loadRequest:request];
        
    }
    
    if ([type isEqualToString:@"cha_xun_bang_zhu"]) {
        self.title = @"查询帮助";
        
        NSURL* url = [NSURL URLWithString:@"http://www.iiqiang.com/Home/Help/index"];//创建URL
        
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        
        [self.webview loadRequest:request];
        
    }
    
}




- (UIWebView *)webview{
    if (_webview == nil) {
        UIWebView *webview = [[UIWebView alloc] init];
        webview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        [self.view addSubview:webview];
        _webview = webview;
    }
    return _webview;
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
