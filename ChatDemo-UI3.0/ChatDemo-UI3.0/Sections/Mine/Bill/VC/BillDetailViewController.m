//
//  BillDetailViewController.m
//  ChatDemo-UI3.0
//
//  Created by 闫世宗 on 2017/3/27.
//  Copyright © 2017年 闫世宗. All rights reserved.
//

#import "BillDetailViewController.h"
#import "BillModel.h"

@interface BillDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *jine;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *jiaoyidanhao;
@property (weak, nonatomic) IBOutlet UILabel *leftMoney;
@property (weak, nonatomic) IBOutlet UILabel *beizhu;

@end

@implementation BillDetailViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (void)setModel:(BillModel *)model {
//    if (_model != model) {
//        _model = model;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self->_jine.text = model.amount;
//            if ([model.type isEqualToString:@"1"]) {
//                self->_type.text = @"收入";
//            } else {
//                self->_type.text = @"支出";
//            }
//            self->_time.text = model.create_time;
//            self->_jiaoyidanhao.text = model.number;
//            self->_leftMoney.text = [NSString stringWithFormat:@"%@", model.amount_after];
//            self->_beizhu.text = model.log;
//            
//        });
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
