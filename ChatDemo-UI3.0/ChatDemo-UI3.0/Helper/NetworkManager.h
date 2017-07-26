//
//  NetworkManager.h
//  Store
//
//  Created by 闫世宗 on 16/4/11.
//  Copyright © 2016年 闫世宗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NetworkManager : NSObject

//检测IP
- (NSString *)getIPAddress;

//get请求
- (void)getWithURL:(NSString *)urlString
           success:(void(^)(id obj))success
              fail:(void(^)(NSError *error))fail;

//post请求
- (void)postWithURL:(NSString *)urlString
              parameter:(NSDictionary *)paraDIC
                success:(void(^)(id obj))success
                   fail:(void(^)(NSError *error))fail;
//上传1张图片
- (void)networkWithURL:(NSString *)urlString
                   pic:(UIImage *)image
             parameter:(NSDictionary *)paraDIC
               success:(void (^)(id obj))success
                  fail:(void (^)(NSError *error))fail;

//上传多张图片
- (void)networkWithURL:(NSString *)urlString
            imageArray:(NSArray *)imageArray
             parameter:(NSDictionary *)paraDIC
               success:(void (^)(id obj))success
                  fail:(void (^)(NSError *error))fail;

//+ (NSString *)postRequestWithURL: (NSString *)url  // IN
//                      postParems: (NSMutableDictionary *)postParems // IN
//                     picFilePath: (UIImage *)image  // IN
//                     picFileName: (NSString *)picFileName;

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
