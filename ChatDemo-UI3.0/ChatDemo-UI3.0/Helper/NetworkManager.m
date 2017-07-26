//
//  NetworkManager.m
//  Store
//
//  Created by 闫世宗 on 16/4/11.
//  Copyright © 2016年 闫世宗. All rights reserved.
//

#import "NetworkManager.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"


@implementation NetworkManager

//获取IP

- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

- (void)getWithURL:(NSString *)urlString
           success:(void(^)(id obj))success
              fail:(void(^)(NSError *error))fail {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(error) {
            fail(error);
        } else {
            success(responseObject);
        }
        
    }];
    //开启任务
    [dataTask resume];

}

- (void)postWithURL:(NSString *)urlString
          parameter:(NSDictionary *)paraDIC
            success:(void(^)(id obj))success
               fail:(void(^)(NSError *error))fail {
  
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString  parameters:paraDIC constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } error:nil];
    //创建请求任务
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSString *key = @"";
        for (id obj in paraDIC.allValues) {
            key = [key stringByAppendingFormat:@"%@", obj];
        }
        if(error) {
            fail(error);
        } else {
            success(responseObject);
        }
        
    }];
    //开启任务
    [dataTask resume];
}

- (void)networkWithURL:(NSString *)urlString
                   pic:(UIImage *)image
             parameter:(NSDictionary *)paraDIC
               success:(void (^)(id obj))success
                  fail:(void (^)(NSError *error))fail {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [[manager POST:urlString parameters:paraDIC constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //在这里提交图片/视频/音频等数据
        //先把图片转换成NSData
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        //第二个参数是服务器提供的字段名
        [formData appendPartWithFileData:data name:@"headimg" fileName:[NSString stringWithFormat:@"%f.png", [[NSDate date] timeIntervalSince1970]] mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }] resume];
    
    
}

- (void)networkWithURL:(NSString *)urlString imageArray:(NSArray *)imageArray parameter:(NSDictionary *)paraDIC success:(void (^)(id obj))success fail:(void (^)(NSError *error))fail {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [[manager POST:urlString parameters:paraDIC constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for(NSInteger i = 0; i < imageArray.count; i++) {
            NSData * imageData = UIImageJPEGRepresentation([imageArray objectAtIndex:i], 0.5);
            
            // 上传的参数名
            NSString *name = [NSString stringWithFormat:@"img%ld", i];
            // 上传filename
            NSString * fileName = [NSString stringWithFormat:@"%f.png", [[NSDate date] timeIntervalSince1970]];
            
            [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }] resume];

    
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2. 设置接受JSON格式
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [mgr.requestSerializer setStringEncoding:NSUTF8StringEncoding];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    
    // 3.发送请求
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if (success) {
              success(responseObject);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}



//static NSString * const FORM_FLE_INPUT = @"image";
//
//+ (NSString *)postRequestWithURL: (NSString *)url
//                      postParems: (NSMutableDictionary *)postParems
//                     picFilePath: (UIImage *)image
//                     picFileName: (NSString *)picFileName {
//    
//    
//    NSString *TWITTERFON_FORM_BOUNDARY = @"0xKhTmLbOuNdArY";
//    //根据url初始化request
//    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
//                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
//                                                       timeoutInterval:10];
//    //分界线 --AaB03x
//    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
//    //结束符 AaB03x--
//    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
//    //得到图片的data
//    NSData* data;
////    if(picFilePath){
////        
////        UIImage *image=[UIImage imageWithContentsOfFile:picFilePath];
////        //判断图片是不是png格式的文件
////        if (UIImagePNGRepresentation(image)) {
////            //返回为png图像。
////            data = UIImagePNGRepresentation(image);
////        }else {
////            //返回为JPEG图像。
////            data = UIImageJPEGRepresentation(image, 1.0);
////        }
////    }
//    data = UIImagePNGRepresentation(image);
//    //http body的字符串
//    NSMutableString *body=[[NSMutableString alloc]init];
//    //参数的集合的所有key的集合
//    NSArray *keys= [postParems allKeys];
//    
//    //遍历keys
//    for(int i=0;i<[keys count];i++)
//    {
//        //得到当前key
//        NSString *key=[keys objectAtIndex:i];
//        
//        //添加分界线，换行
//        [body appendFormat:@"%@\r\n",MPboundary];
//        //添加字段名称，换2行
//        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
//        //添加字段的值
//        [body appendFormat:@"%@\r\n",[postParems objectForKey:key]];
//        
//        NSLog(@"添加字段的值==%@",[postParems objectForKey:key]);
//    }
//    
//    if(image){
//        ////添加分界线，换行
//        [body appendFormat:@"%@\r\n",MPboundary];
//        
//        //声明pic字段，文件名为boris.png
//        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",FORM_FLE_INPUT, picFileName];
//        //声明上传文件的格式
//        [body appendFormat:@"Content-Type: image/jpge,image/gif, image/jpeg, image/pjpeg, image/pjpeg\r\n\r\n"];
//    }
//    
//    //声明结束符：--AaB03x--
//    NSString *end = [[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
//    //声明myRequestData，用来放入http body
//    NSMutableData *myRequestData = [NSMutableData data];
//    
//    //将body字符串转化为UTF8格式的二进制
//    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
//    if(image){
//        //将image的data加入
//        [myRequestData appendData:data];
//    }
//    //加入结束符--AaB03x--
//    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    //设置HTTPHeader中Content-Type的值
//    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
//    //设置HTTPHeader
//    [request setValue:content forHTTPHeaderField:@"Content-Type"];
//    //设置Content-Length
//    [request setValue:[NSString stringWithFormat:@"%ld", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
//    //设置http body
//    [request setHTTPBody:myRequestData];
//    //http method
//    [request setHTTPMethod:@"POST"];
//    
//    
//    NSHTTPURLResponse *urlResponese = nil;
//    NSError *error = [[NSError alloc]init];
//    NSData* resultData = [NSURLConnection sendSynchronousRequest:request   returningResponse:&urlResponese error:&error];
//    NSString* result= [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
//    if([urlResponese statusCode] >=200&&[urlResponese statusCode]<300){
//        NSLog(@"返回结果=====%@",result);
//        return result;
//    }
//    return nil;
//}



@end
