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

#import "ApplyFriendCell.h"

@implementation ApplyFriendCell
+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    ApplyFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];

    cell.accessibilityIdentifier = @"table_cell";

    [cell headerImageView];
    [cell titleLabel];
    [cell contentLabel];
    [cell addButton];
    [cell refuseButton];
    [cell bottomLineView];

    return cell;
}

- (UIImageView *)headerImageView{
    if (_headerImageView == nil) {
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.frame = CGRectMake(10, 10, 40, 40);
        imageview.backgroundColor = [UIColor clearColor];
        
        imageview.clipsToBounds = YES;
        imageview.layer.cornerRadius = 5.0;
        [self.contentView addSubview:imageview];
        _headerImageView = imageview;
    }
    return _headerImageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.accessibilityIdentifier = @"title";
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel * contentLabel = [[UILabel alloc] init];
        contentLabel.accessibilityIdentifier = @"content";
        contentLabel.numberOfLines = 0;
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:contentLabel];
        _contentLabel = contentLabel;
    }
    return _contentLabel;
}

- (UIButton *)addButton{
    if (_addButton == nil) {
        UIButton * addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 0, 50, 30)];
        addButton.accessibilityIdentifier = @"accept";
        //        [_addButton setBackgroundColor:[UIColor colorWithRed:10 / 255.0 green:82 / 255.0 blue:104 / 255.0 alpha:1.0]];
        [addButton setBackgroundColor:[UIColor redColor]];
        [addButton setTitle:NSLocalizedString(@"accept", @"Accept") forState:UIControlStateNormal];
        [addButton setTitle:@"同意" forState:UIControlStateNormal];
        
        addButton.clipsToBounds = YES;
        addButton.layer.masksToBounds = YES;
        addButton.layer.cornerRadius = 3;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [addButton addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}


- (UIButton *)refuseButton{
    if (_refuseButton == nil) {
        UIButton * refuseButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 120, 0, 50, 30)];
        refuseButton.accessibilityIdentifier = @"decline";
        [refuseButton setBackgroundColor:[UIColor colorWithRed:87 / 255.0 green:186 / 255.0 blue:205 / 255.0 alpha:1.0]];
        [refuseButton setTitle:NSLocalizedString(@"reject", @"Reject") forState:UIControlStateNormal];
        refuseButton.clipsToBounds = YES;
        [refuseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //----------隐藏拒绝按钮
        refuseButton.hidden = YES;
        refuseButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [refuseButton addTarget:self action:@selector(refuseFriend) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:refuseButton];
        _refuseButton = refuseButton;
    }
    return _refuseButton;
}

- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
        [self.contentView addSubview:bottomLineView];
        _bottomLineView = bottomLineView;
    }
    return _bottomLineView;
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

            }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _addButton.frame = CGRectMake(self.contentView.frame.size.width - 110, (self.contentView.frame.size.height - 30) / 2, 100, 30);
    _refuseButton.frame = CGRectMake(self.contentView.frame.size.width - 170, (self.contentView.frame.size.height - 30) / 2, 50, 30);
    _bottomLineView.frame = CGRectMake(0, self.contentView.frame.size.height - 1, self.contentView.frame.size.width, 1);
    if (_contentLabel.text.length > 0) {
        _titleLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 10, 10, self.contentView.frame.size.width - 120 - (CGRectGetMaxX(_headerImageView.frame) + 10), 20);
        _contentLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame), _titleLabel.frame.size.width, self.contentView.frame.size.height - 20 - _titleLabel.frame.size.height);
    }
    else{
        _titleLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 10, 10, self.contentView.frame.size.width - 120 - (CGRectGetMaxX(_headerImageView.frame) + 10), self.contentView.frame.size.height - 20);
        _contentLabel.frame = CGRectZero;
    }
}

- (void)addFriend
{
    if(_delegate && [_delegate respondsToSelector:@selector(applyCellAddFriendAtIndexPath:)])
    {
        [_delegate applyCellAddFriendAtIndexPath:self.indexPath];
    }
}

- (void)refuseFriend
{
    if(_delegate && [_delegate respondsToSelector:@selector(applyCellRefuseFriendAtIndexPath:)])
    {
        [_delegate applyCellRefuseFriendAtIndexPath:self.indexPath];
    }
}

+ (CGFloat)heightWithContent:(NSString *)content
{
    if (!content || content.length == 0) {
        return 60;
    }
    else{
        NSDictionary * attrs = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0], NSFontAttributeName,nil];
        CGSize size = [content boundingRectWithSize:CGSizeMake(320 - 60 - 120, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        return size.height > 20 ? (size.height + 40) : 60;
    }
}

- (void)setModel:(FriendsCheckListModel *)model{
    
    _model = model;
    
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:[model.from_uid isEqualToString:User_ID] ? model.to_headimg :model.from_headimg]];
    
    _titleLabel.text = [model.from_uid isEqualToString:User_ID] ? model.to_nickname : model.from_nickname;
    _contentLabel.text = model.msg;
    
    if ([model.status isEqualToString:@"1"]) {
        _addButton.userInteractionEnabled = NO;
        _addButton.backgroundColor = [UIColor whiteColor];
        [_addButton setTitleColor:DBGrayColor forState:UIControlStateNormal];
        [_addButton setTitle:@"已同意" forState:UIControlStateNormal];
        
    }else{
        if ([model.from_uid isEqualToString:User_ID]) {
            _addButton.userInteractionEnabled = NO;
            [_addButton setTitle:@"等待验证" forState:UIControlStateNormal];
            [_addButton setBackgroundColor:[UIColor whiteColor]];
            [_addButton setTitleColor:DBGrayColor forState:UIControlStateNormal];
        }else{
            _addButton.userInteractionEnabled = YES;
            _addButton.backgroundColor = [UIColor redColor];
            [_addButton setTitle:@"同意" forState:UIControlStateNormal];
            [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        }
        
        
    }
    
    
}






@end
