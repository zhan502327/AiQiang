//
//  DiscoverCell.h
//  ChatDemo-UI3.0
//
//  Created by 常豪野 on 2017/4/13.
//  Copyright © 2017年 常豪野. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Discover.h"
@interface DiscoverCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *firstButton;

@property (weak, nonatomic) IBOutlet UIButton *secondButton;

@property (weak, nonatomic) IBOutlet UIButton *thirdButton;

@property (weak, nonatomic) IBOutlet UITextField *pingLunTextField;

@property (nonatomic, strong)Discover *message;

@property (nonatomic, copy) void(^iconImageViewBlock)();

@property (nonatomic, copy) void(^imageViewClickedBlock)(NSInteger index, NSMutableArray *imageArray, UIImageView *view, NSMutableArray *imageViewsArray);

@property (nonatomic, copy) void(^firstButtonBlock)();
@property (nonatomic, copy) void(^secondButtonBlock)();
@property (nonatomic, copy) void(^thirdButtonBlock)();


@property (nonatomic, copy) void(^sendPingLunBlock)(NSString *textfieldText);


//返回对应的可重用标识
+(NSString *)getReuseID:(Discover *)message;
//返回对应的行高
+(CGFloat)getRowHeight:(Discover *)message;



@end
