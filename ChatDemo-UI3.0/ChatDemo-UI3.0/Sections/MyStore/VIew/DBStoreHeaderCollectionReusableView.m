//
//  DBStoreHeaderCollectionReusableView.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/8/22.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBStoreHeaderCollectionReusableView.h"

@implementation DBStoreHeaderCollectionReusableView

+ (UICollectionReusableView *)viewWithFrame:(CGRect)frame{
    
    DBStoreHeaderCollectionReusableView *view = [[DBStoreHeaderCollectionReusableView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = frame;
    return view;
}

@end
