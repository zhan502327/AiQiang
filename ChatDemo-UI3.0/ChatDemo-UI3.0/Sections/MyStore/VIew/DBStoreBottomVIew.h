//
//  DBStoreBottomVIew.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/8/22.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBStoreBottomVIew : UIView


@property (nonatomic, copy) void(^storeBottomViewBlock)(NSInteger tag);

+ (DBStoreBottomVIew *)viewWithFrame:(CGRect)frame;



@end