//
//  MyAccountTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/15.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountTableViewCell : UITableViewCell

@property (nonatomic, weak) UIImageView *iconimageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *rightImageView;


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
