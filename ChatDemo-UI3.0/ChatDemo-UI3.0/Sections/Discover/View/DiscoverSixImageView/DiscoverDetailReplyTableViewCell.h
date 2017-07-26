//
//  DiscoverDetailReplyTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/26.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverHuifuModek.h"

@interface DiscoverDetailReplyTableViewCell : UITableViewCell


@property (nonatomic, strong) DiscoverHuifuModek *model;

@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, copy) NSString *textstr;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
