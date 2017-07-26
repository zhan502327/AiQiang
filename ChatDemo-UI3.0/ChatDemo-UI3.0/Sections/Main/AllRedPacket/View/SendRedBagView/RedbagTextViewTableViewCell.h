//
//  RedbagTextViewTableViewCell.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/9.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedbagTextViewTableViewCell : UITableViewCell

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UITextView *textView;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
