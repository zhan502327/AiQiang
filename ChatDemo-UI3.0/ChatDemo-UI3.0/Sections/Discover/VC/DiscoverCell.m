//
//  DiscoverCell.m
//  ChatDemo-UI3.0
//
//  Created by 常豪野 on 2017/4/13.
//  Copyright © 2017年 常豪野. All rights reserved.
//

#import "DiscoverCell.h"
#import "Discover.h"
#import <UIImageView+AFNetworking.h>

@interface DiscoverCell()<UITextFieldDelegate>

//头像
@property (weak, nonatomic) IBOutlet UIImageView *headimg;
//昵称
@property (weak, nonatomic) IBOutlet UILabel *nickname;
//创建时间
@property (weak, nonatomic) IBOutlet UILabel *create_time;
//正文
@property (weak, nonatomic) IBOutlet UILabel *content;
//一张图片
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOne;
//两张图片
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViewTwo;
//三张图片
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViewThree;
//四张图片
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViewFour;
//五张图片
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViewFive;
//六张图片
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViewSix;
@property (nonatomic, copy) NSString *textFieldText;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@end
@implementation DiscoverCell



- (IBAction)firstButtonClicked:(id)sender {
    
    if (_firstButtonBlock) {
        _firstButtonBlock();
    }
}



- (IBAction)secondButtonClicked:(id)sender {
    if (_sendPingLunBlock) {
        _secondButtonBlock();
    }
    
}



- (IBAction)thirdButton:(id)sender {
    if (_thirdButtonBlock) {
        _thirdButtonBlock();
    }
    
}

-(void)setMessage:(Discover *)message{
    _message = message;
    
    [self.firstButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self.firstButton setImage:[UIImage imageNamed:@"discover_zan_selected"] forState:UIControlStateSelected];
    
    [self.firstButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self.firstButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.firstButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.firstButton setTitle:message.liked forState:UIControlStateNormal];
    
    [self.secondButton setImage:[UIImage imageNamed:@"discover_comment"] forState:UIControlStateNormal];
    [self.secondButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];

    [self.secondButton setTitle:message.comment forState:UIControlStateNormal];
    
    [self.secondButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.secondButton.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [self.thirdButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    
    if ([message.is_liked isEqualToString:@"1"]) {
        self.firstButton.selected = YES;
//        self.firstButton.enabled = NO;
    }else{
        self.firstButton.selected = NO;
//        self.firstButton.enabled = YES;
    }
    
    self.pingLunTextField.returnKeyType = UIReturnKeySend;
    self.pingLunTextField.delegate = self;
    [self.pingLunTextField addTarget:self action:@selector(pingLunTextFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.headimg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewTap)];
    [self.headimg addGestureRecognizer:tap];
    
    self.imageArray = [NSMutableArray arrayWithCapacity:0];
    self.imageViewArray = [NSMutableArray arrayWithCapacity:0];
    
    //设置头像
    NSString *string=message.headimg;
    NSString *strUrl=[www stringByAppendingString:string];
    NSLog(@"%@",strUrl);

    [self.headimg setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:nil];
    //设置头像的圆角
    self.headimg.layer.masksToBounds=YES;
    self.headimg.layer.cornerRadius=self.headimg.frame.size.height/2;
    
    //设置昵称
    self.nickname.text=message.nickname;
    
    //设置创建时间
    NSString *timeStr=message.create_time;
    //将时间戳转换成标准时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStr.doubleValue];
    NSLog(@"%@",date);
    //格式化时间数据
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    
    NSString *strDate=[dateFormatter stringFromDate:date];
    self.create_time.text=strDate;
    
    //设置正文
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:message.content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 0;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, message.content.length)];
    self.content.attributedText = attributedString;
    
    
    //设置图片
    [self loadImage:message];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"])

    {
        
        if (_sendPingLunBlock) {
            _sendPingLunBlock(self.textFieldText);
        }
        
    }
    return YES;
}

- (void)pingLunTextFieldValueChanged:(UITextField *)textfield{
    self.textFieldText = textfield.text;
}

- (void)iconImageViewTap{
    if (_iconImageViewBlock) {
        _iconImageViewBlock();
    }
    
}

#pragma mark - 设置图片
-(void)loadImage:(Discover *)message{
  
    
    
    //遍历图片数组
    [message.img enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSInteger arrCount=[message.img count];
        if (arrCount==1) {
            //从字典中获取图片的路径
            NSString *imgSrc=obj[@"url"];
            NSString *strUrl=[www stringByAppendingString:imgSrc];
            NSString *encodeURL = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            UIImageView *imageView=self.imageViewOne;
            imageView.layer.masksToBounds = YES;
            imageView.contentMode=UIViewContentModeScaleAspectFill;
            
            UIImage *placeholderImage=[UIImage imageNamed:@"imagePlaceHolder"];
            [imageView sd_setImageWithURL:[NSURL URLWithString:encodeURL] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    [self.imageArray addObject:image];
                }
            }];
            
            
            imageView.userInteractionEnabled = YES;
            imageView.tag = 100+ idx;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClocked:)];
            [imageView addGestureRecognizer:tap];

            [self.imageViewArray addObject:imageView];
        }
        if (arrCount==2) {
            //从字典中获取图片的路径
            NSString *imgSrc=obj[@"url"];
            NSString *strUrl=[www stringByAppendingString:imgSrc];
            NSString *encodeURL = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            UIImageView *imageView=self.imageViewTwo[idx];
            imageView.layer.masksToBounds = YES;
            imageView.contentMode=UIViewContentModeScaleAspectFill;
            UIImage *placeholderImage=[UIImage imageNamed:@"imagePlaceHolder"];
            [imageView sd_setImageWithURL:[NSURL URLWithString:encodeURL] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                if (image) {
                    [self.imageArray addObject:image];
                }
                
            }];
            imageView.userInteractionEnabled = YES;
            imageView.tag = 100+ idx;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClocked:)];
            [imageView addGestureRecognizer:tap];
            [self.imageViewArray addObject:imageView];

            
        }
        if (arrCount==3) {
            //从字典中获取图片的路径
            NSString *imgSrc=obj[@"url"];
            NSString *strUrl=[www stringByAppendingString:imgSrc];
            NSString *encodeURL = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            UIImageView *imageView=self.imageViewThree[idx];
            imageView.layer.masksToBounds = YES;
            imageView.contentMode=UIViewContentModeScaleAspectFill;
            UIImage *placeholderImage=[UIImage imageNamed:@"imagePlaceHolder"];
            [imageView sd_setImageWithURL:[NSURL URLWithString:encodeURL] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    [self.imageArray addObject:image];

                }
            }];
            
            
            imageView.userInteractionEnabled = YES;
            imageView.tag = 100+ idx;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClocked:)];
            [imageView addGestureRecognizer:tap];
            [self.imageViewArray addObject:imageView];

        }
        if (arrCount==4) {
            //从字典中获取图片的路径
            NSString *imgSrc=obj[@"url"];
            NSString *strUrl=[www stringByAppendingString:imgSrc];
            NSString *encodeURL = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            UIImageView *imageView=self.imageViewFour[idx];
            imageView.layer.masksToBounds = YES;
            imageView.contentMode=UIViewContentModeScaleAspectFill;
            UIImage *placeholderImage=[UIImage imageNamed:@"imagePlaceHolder"];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:encodeURL] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    [self.imageArray addObject:image];

                }
            }];
            
            imageView.userInteractionEnabled = YES;
            imageView.tag = 100+ idx;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClocked:)];
            [imageView addGestureRecognizer:tap];
            [self.imageViewArray addObject:imageView];

        }
        if (arrCount==5) {
            //从字典中获取图片的路径
            NSString *imgSrc=obj[@"url"];
            NSString *strUrl=[www stringByAppendingString:imgSrc];
            NSString *encodeURL = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            UIImageView *imageView=self.imageViewFive[idx];
            imageView.layer.masksToBounds = YES;
            imageView.contentMode=UIViewContentModeScaleAspectFill;
            UIImage *placeholderImage=[UIImage imageNamed:@"imagePlaceHolder"];
            [imageView sd_setImageWithURL:[NSURL URLWithString:encodeURL] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    [self.imageArray addObject:image];

                }
            }];
            
            imageView.userInteractionEnabled = YES;
            imageView.tag = 100+ idx;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClocked:)];
            [imageView addGestureRecognizer:tap];
            [self.imageViewArray addObject:imageView];

        }
        if (arrCount==6) {
            //从字典中获取图片的路径
            NSString *imgSrc=obj[@"url"];
            NSString *strUrl=[www stringByAppendingString:imgSrc];
            NSLog(@"%@",strUrl);
            NSString *encodeURL = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            UIImageView *imageView=self.imageViewSix[idx];
            imageView.layer.masksToBounds = YES;
            imageView.contentMode=UIViewContentModeScaleAspectFill;
            NSLog(@"%@",NSStringFromCGRect(imageView.frame));
            UIImage *placeholderImage=[UIImage imageNamed:@"imagePlaceHolder"];
            [imageView sd_setImageWithURL:[NSURL URLWithString:encodeURL] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    [self.imageArray addObject:image];

                }
            }];
            
            imageView.userInteractionEnabled = YES;
            imageView.tag = 100+ idx;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClocked:)];
            [imageView addGestureRecognizer:tap];
            [self.imageViewArray addObject:imageView];

        }
        
    }];

}

- (void)imageViewClocked:(UITapGestureRecognizer *)tap{
    
    UIImageView *view = (UIImageView *)tap.view;
    NSInteger tag = view.tag;
    NSInteger index = tag - 100;
    
    
    if (_imageViewClickedBlock) {
        _imageViewClickedBlock(index, self.imageArray ,view,self.imageViewArray);
    }
    
}

#pragma mark - 返回对应的可重用标识
+(NSString *)getReuseID:(Discover *)message{

    NSInteger arrCount=[message.img count];
    if (arrCount==1) {
        
        return @"one";
    }else if(arrCount==2){
    
        return @"two";
    }else if(arrCount==3){
        
        return @"three";
    }else if(arrCount==4){
        
        return @"four";
    }else if(arrCount==5){
        
        return @"five";
    }else if(arrCount==6){
        
        return @"six";
    }else{

        return @"none";
    }
    
    
}



#pragma mark - 返回对应的行高
+(CGFloat)getRowHeight:(Discover *)message{
    NSInteger arrCount=[message.img count];
    NSLog(@"message.content === %@ ,message.labelHeight===%f", message.content,message.labelHeight);
    
    if (arrCount==1) {
        
        if (message.content.length == 0) {
            return 330 + message.labelHeight +10;

        }else{
            return 350 + message.labelHeight +10;

        }
        
    }else if(arrCount==2){
        
        if (message.content.length == 0) {
            return 220 + message.labelHeight +10;
            
        }else{
            return 240 + message.labelHeight+10;
            
        }
    }else if(arrCount==3){
        
        if (message.content.length == 0) {
            return 220 + message.labelHeight+10;
            
        }else{
            return 260 + message.labelHeight+10;
            
        }
    }else if(arrCount==4){
        if (message.content.length == 0) {
            return 220 + message.labelHeight + 100+10;
            
        }else{
            return 240 + message.labelHeight + 100+10;
            
        }
    }else if(arrCount==5){
        
        if (message.content.length == 0) {
            return 220 + message.labelHeight + 100+10;
            
        }else{
            return 240 + message.labelHeight + 100+10;
            
        }
    }else if(arrCount==6){
        
        if (message.content.length == 0) {
            return 220 + message.labelHeight + 100+10;
            
        }else{
            return 240 + message.labelHeight + 100+10;
            
        }
    }else{
        if (message.content.length == 0) {
            return 120 + message.labelHeight+10;
            
        }else{
            return 140 + message.labelHeight+10;
            
        }

        
    }

    
}



@end
