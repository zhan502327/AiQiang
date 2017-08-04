//
//  ASBirthSelectSheet.m
//  ASBirthSheet
//
//  Created by Ashen on 15/12/8.
//  Copyright © 2015年 Ashen. All rights reserved.
//

#import "ASBirthSelectSheet.h"
#import <UIKit/UIKit.h>

static CGFloat MainScreenHeight = 0;
static CGFloat MainScreenWidth = 0;


@interface ASBirthSelectSheet()


@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *btnDone;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) NSDateFormatter *formatter;

@end
@implementation ASBirthSelectSheet

- (instancetype)init{
    if (self = [super init]) {
        MainScreenHeight = [UIScreen mainScreen].bounds.size.height;
        MainScreenWidth = [UIScreen mainScreen].bounds.size.width;
        //        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
        [self addGestureRecognizer:tap];
        [self makeUI];

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        MainScreenHeight = [UIScreen mainScreen].bounds.size.height;
        MainScreenWidth = [UIScreen mainScreen].bounds.size.width;
//        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
        [self addGestureRecognizer:tap];
        [self makeUI];
    }
    return self;
}

- (void)makeUI {

    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, MainScreenHeight - 250 - 64, MainScreenWidth, 250)];
    _containerView.backgroundColor = [UIColor whiteColor];
    _containerView.layer.cornerRadius = 3;
    _containerView.layer.masksToBounds = YES;
    
    UIView *topview = [[UIView alloc] init];
    topview.backgroundColor =  ColorTableViewBg;
    topview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    [_containerView addSubview:topview];
    
    _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnCancel.frame = CGRectMake(10, 0, 60, 40);
    [_btnCancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btnCancel.titleLabel.font = [UIFont systemFontOfSize:20];
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnCancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:_btnCancel];
    
    
    _btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDone.frame = CGRectMake(SCREEN_WIDTH - 70, 0, 60, 40);
    _btnDone.titleLabel.font = [UIFont systemFontOfSize:20];
    [_btnDone setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_btnDone setTitle:@"确定" forState:UIControlStateNormal];
    [_btnDone addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
//    _btnDone.layer.borderWidth = 0.3;
//    _btnDone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [topview addSubview:_btnDone];
    
    
    _datePicker =  [[UIDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topview.frame), MainScreenWidth, 200)];
    [_datePicker setDate:[NSDate date] animated:YES];
    [_datePicker setMaximumDate:[NSDate date]];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    _datePicker.tintColor = [UIColor colorWithRed:51.0/255
                                            green:51.0/255
                                             blue:51.0/255
                                            alpha:1.0];
    
    [_datePicker setMinimumDate:[self.formatter dateFromString:@"1900-01-01日"]];
    [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [_containerView addSubview:_datePicker];
    
    [self addSubview:_containerView];
}



#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {

}
#pragma mark - Action
- (void)doneAction:(UIButton *)btn {
    if (self.GetSelectDate) {
        _GetSelectDate([self.formatter stringFromDate:_datePicker.date]);
    }
    if (_cancelViewAnimationBlock) {
        _cancelViewAnimationBlock();
    }
}

- (void)cancelAction:(UIButton *)btn {
    if (_cancelViewAnimationBlock) {
        _cancelViewAnimationBlock();
    }
}

- (void)dateChange:(id)datePicker {
    
}

#pragma mark - setter、getter
- (void)setSelectDate:(NSString *)selectDate {
    [_datePicker setDate:[self.formatter dateFromString:selectDate] animated:YES];
}
- (NSDateFormatter *)formatter {
    if (_formatter) {
        return _formatter;
    }
    _formatter =[[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    return _formatter;
    
}

@end
