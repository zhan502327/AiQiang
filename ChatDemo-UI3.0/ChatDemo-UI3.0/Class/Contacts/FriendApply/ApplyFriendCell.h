/************************************************************
  *  * Hyphenate CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2016 Hyphenate Inc. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of Hyphenate Inc.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from Hyphenate Inc.
  */

#import <UIKit/UIKit.h>
#import "FriendsCheckListModel.h"

@protocol ApplyFriendCellDelegate;

@interface ApplyFriendCell : UITableViewCell

@property (nonatomic) id<ApplyFriendCellDelegate> delegate;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (weak, nonatomic) UIImageView *headerImageView;//头像
@property (weak, nonatomic) UILabel *titleLabel;//标题
@property (weak, nonatomic) UILabel *contentLabel;//详情
@property (weak, nonatomic) UIButton *addButton;//接受按钮
@property (weak, nonatomic) UIButton *refuseButton;//拒绝按钮
@property (weak, nonatomic) UIView *bottomLineView;

@property (nonatomic, strong) FriendsCheckListModel *model;

+ (CGFloat)heightWithContent:(NSString *)content;
+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end

@protocol ApplyFriendCellDelegate <NSObject>

- (void)applyCellAddFriendAtIndexPath:(NSIndexPath *)indexPath;
- (void)applyCellRefuseFriendAtIndexPath:(NSIndexPath *)indexPath;



@end
