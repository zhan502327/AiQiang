//
//  AddressChoicePickerView.m
//  Wujiang
//
//  Created by zhengzeqin on 15/5/27.
//  Copyright (c) 2015年 com.injoinow. All rights reserved.
//  make by 郑泽钦 分享

#import "AddressChoicePickerView.h"

@interface AddressChoicePickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHegithCons;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

@property (strong, nonatomic) AreaObject *locate;

//区域 数组
@property (strong, nonatomic) NSArray *regionArr;
//省 数组
@property (strong, nonatomic) NSArray *provinceArr;
//城市 数组
@property (strong, nonatomic) NSArray *cityArr;
//区县 数组
@property (strong, nonatomic) NSArray *areaArr;

@end


@implementation AddressChoicePickerView

#pragma mark - setter && getter

- (AreaObject *)locate{
    if (!_locate) {
        _locate = [[AreaObject alloc] init];
    }
    return _locate;
}


- (instancetype)init{
    
    if (self = [super init]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"AddressChoicePickerView" owner:nil options:nil] firstObject];
        self.frame = [UIScreen mainScreen].bounds;
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
        
        self.provinceArr = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
        self.cityArr = self.provinceArr[0][@"cities"];
        self.areaArr = self.cityArr[0][@"areas"];
        
        self.locate.province = self.provinceArr[0][@"state"];
        self.locate.city = self.cityArr[0][@"city"];
        self.locate.gender = @"男";
        
        if (self.areaArr.count) {
            self.locate.area = self.areaArr[0];
        } else {
            self.locate.area = @"";
        }
        [self customView];
    }
    return self;
}

- (void)customView{
    self.contentViewHegithCons.constant = 0;
    [self layoutIfNeeded];
}

#pragma mark - action

//选择完成
- (IBAction)finishBtnPress:(UIButton *)sender {
    if (_genderOrAdress) {
        if (self.genderblock) {
            self.genderblock(self, sender, self.locate);
        }
    } else {
        if (self.adressblock) {
            self.adressblock(self, sender, self.locate);
        }
    }
    
    [self hide];
}

//隐藏
- (IBAction)dissmissBtnPress:(UIButton *)sender {
    
    [self hide];
}

#pragma  mark - function

- (void)show{
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = [win.subviews firstObject];
    [topView addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentViewHegithCons.constant = 250;
        [self layoutIfNeeded];
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.contentViewHegithCons.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (_genderOrAdress) {
        return 1;
    }
    return 3;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_genderOrAdress) {
        return 2;
    }
    
    switch (component) {
        case 0:
            return self.provinceArr.count;
            break;
        case 1:
            return self.cityArr.count;
            break;
        case 2:
            if (self.areaArr.count) {
                return self.areaArr.count;
                break;
            }
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (_genderOrAdress) {
        if (row == 0) {
            return @"男";
        } else {
            return @"女";
        }
    }
    
    switch (component) {
        case 0:
            return [[self.provinceArr objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [[self.cityArr objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            if (self.areaArr.count) {
                return [self.areaArr objectAtIndex:row];
                break;
            }
        default:
            return  @"";
            break;
    }
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (_genderOrAdress) {
        if (row == 0) {
            self.locate.gender = @"男";
        } else {
            self.locate.gender = @"女";
        }
        return;
    }
    
    switch (component) {
        case 0: {
            self.cityArr = [[self.provinceArr objectAtIndex:row] objectForKey:@"cities"];
            [self.pickView reloadComponent:1];
            [self.pickView selectRow:0 inComponent:1 animated:YES];
            
            self.areaArr = [[self.cityArr objectAtIndex:0] objectForKey:@"areas"];
            [self.pickView reloadComponent:2];
            [self.pickView selectRow:0 inComponent:2 animated:YES];
            
            self.locate.province = self.provinceArr[row][@"state"];
            self.locate.city = self.cityArr[0][@"city"];
            
            if (self.areaArr.count) {
                self.locate.area = self.areaArr[0];
            }else{
                self.locate.area = @"";
            }
            
            break;
        }
        case 1: {
            self.areaArr = [[self.cityArr objectAtIndex:row] objectForKey:@"areas"];
            [self.pickView reloadComponent:2];
            [self.pickView selectRow:0 inComponent:2 animated:YES];
            
            self.locate.city = self.cityArr[row][@"city"];
            
            if (self.areaArr.count) {
                self.locate.area = self.areaArr[0];
            } else {
                self.locate.area = @"";
            }
            
            break;
        }
        case 2: {
            if (self.areaArr.count) {
                self.locate.area = self.areaArr[row];
            } else {
                self.locate.area = @"";
            }
            
            break;
        }
        default:
            break;
    }
}


@end
