//
//  RedBagAddimageTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/10.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWPhotosView.h"

@interface RedBagAddimageTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *photosArray;

@property (nonatomic, weak) IWPhotosView *photos_view;
@property (nonatomic, weak) UIButton *addimageButton;

@property (nonatomic, copy) void(^addimageButtonBlock)();

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;



@end
