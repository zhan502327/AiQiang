//
//  AddressChoicePickerView.h
//  Wujiang
//
//  Created by zhengzeqin on 15/5/27.
//  Copyright (c) 2015年 com.injoinow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaObject.h"

@class AddressChoicePickerView;

typedef void (^AddressChoicePickerViewBlock)(AddressChoicePickerView *view, UIButton *btn, AreaObject *locate);

@interface AddressChoicePickerView : UIView

@property (assign, nonatomic) NSInteger genderOrAdress;

@property (copy, nonatomic) AddressChoicePickerViewBlock adressblock;

@property (copy, nonatomic) AddressChoicePickerViewBlock genderblock;


- (void)show;

@end





