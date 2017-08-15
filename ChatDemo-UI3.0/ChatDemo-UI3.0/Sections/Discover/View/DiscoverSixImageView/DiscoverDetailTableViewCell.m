//
//  DiscoverDetailTableViewCell.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/24.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DiscoverDetailTableViewCell.h"
#import "SDAutoLayout.h"

#define GAP 10

#define viewW_H 90

@implementation DiscoverDetailTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    DiscoverDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell detailView];
    
    cell.imageArray = [NSMutableArray array];
    return cell;
}
- (DiscoverDetailHeaderView *)detailView{
    if (_detailView == nil) {
        DiscoverDetailHeaderView *view = [DiscoverDetailHeaderView customViewWithFrame];
        [view setIcomImageViewTapblock:^{
            if (self->_iconImageViewBlock) {
                self->_iconImageViewBlock();
            }
            
        }];
        [self.contentView addSubview:view];
        _detailView = view;
    }
    return _detailView;
}


#pragma mark -数据处理
-(void)setModel:(Discover *)model
{
    _model = model;
    if (_model) {        
        
        
        if ([model.is_liked isEqualToString:@"1"]) {
            self.detailView.zanButton.selected = YES;
            //        self.firstButton.enabled = NO;
        }else{
            self.detailView.zanButton.selected = NO;
            //        self.firstButton.enabled = YES;
        }
        
        [self.detailView.zanButton setTitle:model.liked forState:UIControlStateNormal];
        [self.detailView.zanButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        
        [self.detailView.pinglunButton setTitle:model.comment forState:UIControlStateNormal];
        [self.detailView.pinglunButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];

        
        if (model.img.count == 0) {
            self.detailView.contentImageView.hidden = YES;
        }else
        {
            self.detailView.contentImageView.hidden = NO;
        }
        //设置头像
        NSString *string=model.headimg;
        NSString *strUrl=[www stringByAppendingString:string];
        
        [self.detailView.iconImageView sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:nil];

        
        //设置昵称
        self.detailView.nameLabel.text=model.nickname;
        
        //设置创建时间
        NSString *timeStr=model.create_time;
        //将时间戳转换成标准时间
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStr.doubleValue];
        NSLog(@"%@",date);
        //格式化时间数据
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
        
        NSString *strDate=[dateFormatter stringFromDate:date];
        self.detailView.timeLabel.text=strDate;
        
        
        //设置frame
        [self configerFrameWithModel:model];

        
        //加载图片
        if (model.img.count > 0) {
            
            [self loadImage:model];
            if (_imageArrayBlcock) {
                _imageArrayBlcock(self.imageArray);
            }
        }
        
        //设置正文
        self.detailView.contentLabel.isAttributedContent = YES;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.content];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 10;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, model.content.length)];
        self.detailView.contentLabel.attributedText = attributedString;
    
        self.detailView.imageCount = model.img.count;
        
        
        //添加button的点击事件
        [self.detailView.zanButton addTarget:self action:@selector(zanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self.detailView.pinglunButton addTarget:self action:@selector(pingLunButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self.detailView.shareButton addTarget:self action:@selector(shareButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)zanButtonClicked
{
    if (_zanButtonClickedBlock) {
        _zanButtonClickedBlock();
    }
}

- (void)pingLunButtonClicked{
    if (_pinglunButtonClickedBlock) {
        _pinglunButtonClickedBlock();
    }
}

- (void)shareButtonClicked{
    if (_shareButtonClickedBlock) {
        _shareButtonClickedBlock();
    }
}


-(void)loadImage:(Discover *)message{
    UIImage *placeholderImage=[UIImage imageNamed:@"imagePlaceHolder"];
    if (message.img.count > 0) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *dic in message.img) {
            NSString *urlstr = dic[@"url"];
            NSString *result = [www stringByAppendingString:urlstr];
            NSString *encodeURL = [result stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [array addObject:encodeURL];
        }
        
        if (message.img.count == 1 ) {
            
            
            [self.detailView.imageView1 sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    [self.imageArray  addObject:image];
                }
            }];
            
        }else if (message.img.count == 2){
                        
            
            [self.detailView.imageView1 sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    [self.imageArray addObject:image];
                }
            }];
            
            [self.detailView.imageView2 sd_setImageWithURL:[NSURL URLWithString:array[1]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            
        }else if (message.img.count == 3){
            [self.detailView.imageView1 sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    [self.imageArray addObject:image];
                }
            }];
            [self.detailView.imageView2 sd_setImageWithURL:[NSURL URLWithString:array[1]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    [self.imageArray addObject:image];
                }
            }];
            
            [self.detailView.imageView3 sd_setImageWithURL:[NSURL URLWithString:array[2]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            
        }else if (message.img.count == 4){
            
            [self.detailView.imageView1 sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            [self.detailView.imageView2 sd_setImageWithURL:[NSURL URLWithString:array[1]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            
            [self.detailView.imageView3 sd_setImageWithURL:[NSURL URLWithString:array[2]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            
            [self.detailView.imageView4 sd_setImageWithURL:[NSURL URLWithString:array[3]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            
        }else if (message.img.count == 5){
            [self.detailView.imageView1 sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            [self.detailView.imageView2 sd_setImageWithURL:[NSURL URLWithString:array[1]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            [self.detailView.imageView3 sd_setImageWithURL:[NSURL URLWithString:array[2]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            [self.detailView.imageView4 sd_setImageWithURL:[NSURL URLWithString:array[3]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            [self.detailView.imageView5 sd_setImageWithURL:[NSURL URLWithString:array[4]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            
        }else{
            [self.detailView.imageView1 sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            [self.detailView.imageView2 sd_setImageWithURL:[NSURL URLWithString:array[1]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            [self.detailView.imageView3 sd_setImageWithURL:[NSURL URLWithString:array[2]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            [self.detailView.imageView4 sd_setImageWithURL:[NSURL URLWithString:array[3]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            [self.detailView.imageView5 sd_setImageWithURL:[NSURL URLWithString:array[4]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
            [self.detailView.imageView6 sd_setImageWithURL:[NSURL URLWithString:array[5]] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image ) {
                    [self.imageArray addObject:image];
                }
            }];
        }
    }
}



- (void)configerFrameWithModel:(Discover *)model{
    
//    NSArray *topViewarray = @[self.detailView.iconImageView, self.detailView.nameLabel,self.detailView.timeLabel,self.detailView.contentLabel,self.detailView.contentImageView,self.detailView.zanButton,self.detailView.pinglunButton,self.detailView.shareButton,self.detailView.pinglunLabel];
    
    
    NSArray *topViewarray = nil;
    if (model.img.count > 0) {
        topViewarray = @[self.detailView.iconImageView, self.detailView.nameLabel,self.detailView.timeLabel,self.detailView.contentLabel,self.detailView.contentImageView,self.detailView.zanButton,self.detailView.pinglunButton,self.detailView.shareButton];
    }else{
        topViewarray = @[self.detailView.iconImageView, self.detailView.nameLabel,self.detailView.timeLabel,self.detailView.contentLabel,self.detailView.zanButton,self.detailView.pinglunButton,self.detailView.shareButton];
    }
    [self.detailView sd_addSubviews:topViewarray];
    
    
    self.detailView.iconImageView.sd_layout
    .leftSpaceToView(self.detailView, GAP)
    .topSpaceToView(self.detailView, GAP)
    .widthIs(50)
    .heightIs(50);
    
    self.detailView.nameLabel.sd_layout
    .leftSpaceToView(self.detailView.iconImageView,GAP)
    .topSpaceToView(self.detailView, GAP + 5)
    .heightIs(20)
    .widthIs(200);
    
    self.detailView.timeLabel.sd_layout
    .leftEqualToView(self.detailView.nameLabel)
    .topSpaceToView(self.detailView.nameLabel,5)
    .widthIs(200)
    .heightIs(20);
    
    self.detailView.contentLabel.sd_layout
    .topSpaceToView(self.detailView.iconImageView,GAP)
    .leftSpaceToView(self.detailView,GAP)
    .rightSpaceToView(self.detailView,GAP)
    .autoHeightRatio(0);
    
    if (model.img.count > 0) {
        CGFloat contentImageViewHeight;
        if (model.img.count == 1) {
            contentImageViewHeight = 190;
        }else if (model.img.count > 3){
            contentImageViewHeight = 190;
        }else{
            contentImageViewHeight = 89;
        }
        self.detailView.contentImageView.sd_layout
        .topSpaceToView(self.detailView.contentLabel,GAP )
        .leftEqualToView(self.detailView.contentLabel)
        .rightEqualToView(self.detailView.contentLabel)
        .heightIs(contentImageViewHeight);
        
        [self configerContentImageViewFrameWithModel:model];
        
    }else{

        self.detailView.contentImageView.sd_layout
        .topSpaceToView(self.detailView.contentLabel,GAP )
        .leftEqualToView(self.detailView.contentLabel)
        .rightEqualToView(self.detailView.contentLabel)
        .heightIs(0.01);

    }
    
    self.detailView.shareButton.sd_layout
    .topSpaceToView(self.detailView.contentImageView,GAP)
    .rightSpaceToView(self.detailView,GAP + GAP)
    .widthIs(40)
    .heightIs(20);
    
    self.detailView.pinglunButton.sd_layout
    .topEqualToView(self.detailView.shareButton)
    .rightSpaceToView(self.detailView.shareButton,GAP + GAP + 3)
    .widthIs(40)
    .heightIs(20);
    
    self.detailView.zanButton.sd_layout
    .topEqualToView(self.detailView.shareButton)
    .rightSpaceToView(self.detailView.pinglunButton,GAP + GAP + 10)
    .widthIs(40)
    .heightIs(20);
    
//    self.detailView.pinglunLabel.sd_layout
//    .topSpaceToView(self.detailView.zanButton,GAP)
//    .leftSpaceToView(self.detailView,GAP+GAP)
//    .rightSpaceToView(self.detailView,GAP+GAP)
//    .heightIs(25);
    
    
    self.detailView.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView);
    
    [self.detailView setupAutoHeightWithBottomView:self.detailView.zanButton bottomMargin:10];
    
    
    self.cellHeight = CGRectGetMaxY(self.detailView.frame);
    
    
    
}

- (void)configerContentImageViewFrameWithModel:(Discover *)model{
    
    int iCount =(int) model.img.count;
    if (iCount == 1) {
        self.detailView.imageView1.hidden = NO;
        self.detailView.imageView2.hidden = YES;
        self.detailView.imageView3.hidden = YES;
        self.detailView.imageView4.hidden = YES;
        self.detailView.imageView5.hidden = YES;
        self.detailView.imageView6.hidden = YES;
        
        self.detailView.imageView1.frame = CGRectMake(0, 0, 190, 190);
        
    }else if (iCount == 2){
        
        self.detailView.imageView1.hidden = NO;
        self.detailView.imageView2.hidden = NO;
        self.detailView.imageView3.hidden = YES;
        self.detailView.imageView4.hidden = YES;
        self.detailView.imageView5.hidden = YES;
        self.detailView.imageView6.hidden = YES;
        self.detailView.imageView1.frame = CGRectMake(0, 0, viewW_H, viewW_H);
        
        self.detailView.imageView2.frame = CGRectMake(viewW_H + GAP, 0, viewW_H, viewW_H);
    }else if (iCount == 3){
 
        self.detailView.imageView1.hidden = NO;
        self.detailView.imageView2.hidden = NO;
        self.detailView.imageView3.hidden = NO;
        self.detailView.imageView4.hidden = YES;
        self.detailView.imageView5.hidden = YES;
        self.detailView.imageView6.hidden = YES;
        self.detailView.imageView1.frame = CGRectMake(0, 0, viewW_H, viewW_H);
        self.detailView.imageView2.frame = CGRectMake(viewW_H + GAP, 0, viewW_H, viewW_H);
        
        self.detailView.imageView3.frame = CGRectMake(viewW_H + GAP + viewW_H + GAP, 0, viewW_H, viewW_H);
    }else if (iCount == 4){
        self.detailView.imageView1.hidden = NO;
        self.detailView.imageView2.hidden = NO;
        self.detailView.imageView3.hidden = NO;
        self.detailView.imageView4.hidden = NO;
        self.detailView.imageView5.hidden = YES;
        self.detailView.imageView6.hidden = YES;
        self.detailView.imageView1.frame = CGRectMake(0, 0, viewW_H, viewW_H);
        self.detailView.imageView2.frame = CGRectMake(viewW_H + GAP, 0, viewW_H, viewW_H);
        self.detailView.imageView3.frame = CGRectMake(0, viewW_H + GAP, viewW_H, viewW_H);
        self.detailView.imageView4.frame = CGRectMake(viewW_H + GAP , viewW_H + GAP, viewW_H, viewW_H);
        

    }else if (iCount == 5){
        self.detailView.imageView1.hidden = NO;
        self.detailView.imageView2.hidden = NO;
        self.detailView.imageView3.hidden = NO;
        self.detailView.imageView4.hidden = NO;
        self.detailView.imageView5.hidden = NO;
        self.detailView.imageView6.hidden = YES;
        
  
        self.detailView.imageView1.frame = CGRectMake(0, 0, viewW_H, viewW_H);
        self.detailView.imageView2.frame = CGRectMake(viewW_H + GAP , 0, viewW_H, viewW_H);
        self.detailView.imageView3.frame = CGRectMake(viewW_H + GAP + viewW_H + GAP, 0, viewW_H, viewW_H);
        self.detailView.imageView4.frame = CGRectMake(0, viewW_H + GAP, viewW_H, viewW_H);
        self.detailView.imageView5.frame = CGRectMake(viewW_H + GAP, viewW_H + GAP, viewW_H, viewW_H);
        
        
    }else if (iCount == 6){
        
        self.detailView.imageView1.hidden = NO;
        self.detailView.imageView2.hidden = NO;
        self.detailView.imageView3.hidden = NO;
        self.detailView.imageView4.hidden = NO;
        self.detailView.imageView5.hidden = NO;
        self.detailView.imageView6.hidden = NO;

        self.detailView.imageView1.frame = CGRectMake(0, 0, viewW_H, viewW_H);
        self.detailView.imageView2.frame = CGRectMake(viewW_H + GAP, 0, viewW_H, viewW_H);
        self.detailView.imageView3.frame = CGRectMake(viewW_H + GAP + viewW_H + GAP, 0, viewW_H, viewW_H);
        self.detailView.imageView4.frame = CGRectMake(0, viewW_H + GAP, viewW_H, viewW_H);
        self.detailView.imageView5.frame = CGRectMake(viewW_H + GAP , viewW_H + GAP, viewW_H, viewW_H);
        self.detailView.imageView6.frame = CGRectMake(viewW_H + GAP + viewW_H + GAP , viewW_H + GAP, viewW_H, viewW_H);
    }else{
        
    }
    
}



- (void)setGetCellHeight:(void (^)(CGFloat))getCellHeight{
    CGFloat detailViewHeight = self.detailView.frame.size.height;
    
    _getCellHeight = getCellHeight;
    if (_getCellHeight) {
        _getCellHeight(detailViewHeight);
    }
}


@end
