//
//  DiscoverDetailReplyTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/26.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DiscoverDetailReplyTableViewCell.h"

@implementation DiscoverDetailReplyTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    DiscoverDetailReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell contentLabel];
    
    return cell;
}


#pragma mark - 懒加载视图
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor=[UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.numberOfLines = 0;//设置UILable自适应
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:titleLabel];
        _contentLabel = titleLabel;
    }
    return _contentLabel;
}

- (void)setModel:(DiscoverHuifuModek *)model{
    _model = model;
    
    NSString *nameOne = model.nickname;
    NSString *nameTwo = model.re_name;
    NSString *replyString = model.content;
    
    NSString *totalString = [NSString stringWithFormat:@"%@回复%@：%@",nameOne,nameTwo,replyString];
    NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithString:totalString];
    [newString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, totalString.length)];
    [newString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, nameOne.length)];
    [newString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(nameOne.length+2, nameTwo.length)];
    //设置行距 实际开发中间距为0太丑了，根据项目需求自己把握
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 0;
    [newString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, totalString.length)];
    self.contentLabel.attributedText = newString;
    
    CGRect labelSize = [totalString boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20 -40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil] context:nil];
    self.contentLabel.frame = CGRectMake(10 + 40, 0, SCREEN_WIDTH - 20-40, labelSize.size.height  + 30);
}

@end
