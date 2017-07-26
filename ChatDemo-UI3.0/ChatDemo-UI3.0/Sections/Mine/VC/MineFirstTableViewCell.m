//
//  MineFirstTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/17.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "MineFirstTableViewCell.h"

#define ButtonWidth 80
#define ButtonHeight 70

#define imageViewWidth 25
#define imageViewHeight 25

@implementation MineFirstTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    MineFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell createButton];
    [cell redView];
    return cell;
}

#pragma mark - 懒加载视图

- (UIView *)redView
{
    if (_redView == nil) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(SCREEN_WIDTH - 50, 15, 12, 12);
        view.backgroundColor = [UIColor redColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 6;
        view.hidden = YES;
        [self addSubview:view];
        _redView = view;
    }
    return _redView;
}

- (void)createButton{
    NSArray *nameArray = @[@"我的收藏",@"我的红包",@"我的动态"];

    for (int i = 0; i<nameArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(45 + ((SCREEN_WIDTH - 3*imageViewWidth - 90)/2 + imageViewWidth)*i, 15, imageViewWidth, imageViewHeight);
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"my_%d",i+1]];
        [self.contentView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(20 + ((SCREEN_WIDTH - 3*ButtonWidth - 40)/2 + ButtonWidth)*i, CGRectGetMaxY(imageView.frame), ButtonWidth, 40);
        label.font = DBTitleLabelFont;
        label.text = nameArray[i];
        label.userInteractionEnabled = YES;
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0 + (SCREEN_WIDTH/3) * i, 0, SCREEN_WIDTH / 3, 90);
        button.tag = 100 + i;
        button.backgroundColor = [UIColor clearColor];
//        CGSize imageSize = button.imageView.frame.size;
//        CGSize titleSize = button.titleLabel.frame.size;

//        [button setImageEdgeInsets:UIEdgeInsetsMake(-titleSize.height - 5, 0, 0, -titleSize.width)];
//        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width , -imageSize.height - 5, 0)];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
    }
    
    
    
    
    
}



- (void)buttonClicked:(UIButton *)btn{
    
    switch (btn.tag) {
        case 100:
            if (_firstButtonBlock) {
                _firstButtonBlock();
            }
            break;
        case 101:
            if (_secondButtonBlock) {
                _secondButtonBlock();
            }
            break;
        case 102:
            if (_thirdButtonBlock) {
                _thirdButtonBlock();
            }
            break;
        default:
            break;
    }
    
    
}

#pragma mark -数据处理


@end
