//
//  IWPhotoView.h
//  Conedot
//
//  Created by 范超 on 15/5/23.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DBPhotoModel;

@interface IWPhotoView : UIImageView
@property (nonatomic, strong) DBPhotoModel *photo;
@end
