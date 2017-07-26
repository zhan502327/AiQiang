//
//  DiscoverDetailTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/24.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverDetailHeaderView.h"
#import "Discover.h"

@interface DiscoverDetailTableViewCell : UITableViewCell

{
    NSInteger imageCount;
}

@property (nonatomic, strong) Discover *model;

@property (nonatomic, weak) DiscoverDetailHeaderView *detailView;

@property (nonatomic, copy) void(^getCellHeight)(CGFloat);

@property (nonatomic, copy) void(^pinglunButtonClickedBlock)();

@property (nonatomic, copy) void(^zanButtonClickedBlock)();

@property (nonatomic, copy) void(^shareButtonClickedBlock)();

@property (nonatomic, copy) void(^iconImageViewBlock)();

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, copy) void(^imageArrayBlcock)(NSMutableArray *imageArray);

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
