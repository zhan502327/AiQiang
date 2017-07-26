//
//  UILabel+ReplyLabel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/26.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XLRichTextModel : NSObject

@property (nonatomic, copy) NSString *string;
@property (nonatomic, assign) NSRange range;

@end

@interface UILabel (ReplyLabel)
///是否显示点击效果，默认是打开
@property (nonatomic, assign) BOOL isShowTagEffect;

///TagArray  点击的字符串数组
- (void)onTapRangeActionWithString:(NSArray <NSString *> *)TagArray tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;



@end
