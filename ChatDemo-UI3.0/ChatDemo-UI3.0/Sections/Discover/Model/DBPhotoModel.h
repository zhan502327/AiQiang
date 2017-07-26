//
//  DBPhotoModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/28.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface DBPhotoModel : NSObject

@property (nonatomic, copy) NSString *pic;

//ALAsset类代表相册中的每个资源文件，可以通过它获取资源文件的相关信息还能修改和新建资源文件，
@property (nonatomic, strong) ALAsset *asset;

//ALAssetRepresentation类代表相册中每个资源文件的详细信息，可以通过它获取资源的大小，名字，路径等详细信息。
//@property (nonatomic, strong) ALAssetRepresentation* representation;

//@property (nonatomic, copy) NSString *uti;
/*
 //资源图片uti，唯一标示符
 NSLog(@"uti:%@",[representation UTI]);
 */
@property (nonatomic, assign, getter=isShowDelete) BOOL showDelete;

@end
