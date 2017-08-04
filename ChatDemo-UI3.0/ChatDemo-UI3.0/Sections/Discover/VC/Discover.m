//
//  Discover.m
//  ChatDemo-UI3.0
//
//  Created by 常豪野 on 2017/4/13.
//  Copyright © 2017年 常豪野. All rights reserved.
//

#import "Discover.h"
#import "DiscoverViewController.h"

@interface DiscoverViewController()

@end

@implementation Discover

+ (instancetype)messageWithDic:(NSDictionary *)dic{
    
    Discover *message=[[Discover alloc]init];
    [message setValuesForKeysWithDictionary:dic];
    if (dic[@"id"]) {

        message.discoverID = dic[@"id"];
    }
    
    if (dic[@"content"]) {
        
        NSString *str = dic[@"content"];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 0;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle,NSFontAttributeName:DBMaxFont};
        
        CGRect labelSize = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        message.labelHeight = labelSize.size.height;
    }
    
    return message;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

//- (void)setValue:(id)value forKey:(NSString *)key{
//    [super setValue:value forKey:key];
//    if ([key isEqualToString:@"content"]) {
//        NSString *str = value;
//        if (str.length == 0) {
//            self.labelHeight = 0;
//        }else{
//            CGRect labelSize = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:DBMaxFont,NSFontAttributeName, nil] context:nil];
//            self.labelHeight = labelSize.size.height;
//        }
//   
//    }
//}


//发送异步请求，获取数据，字典转模型
+ (void)messageListWithSuccessBlock:(void(^)(NSMutableArray *array))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    
    

}

+ (void)discoverLIstWithParam:(NSDictionary *)param successBlock:(void(^)(NSString *msg, NSMutableArray *modelArray, NSNumber *status))successBlock errorBlock:(void(^)(NSError *error))errorBlock{
    
    NSString *urlStr = CircleListURL;
    [[NetworkManager new] postWithURL:urlStr parameter:param success:^(NSDictionary  *responseObject) {
        
        //获取JSON
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        
        NSArray *array=responseObject[@"data"];
        NSString *msg = responseObject[@"msg"];
        NSNumber *status = responseObject[@"status"];
        
        //字典转模型
        NSMutableArray *mArray=[NSMutableArray arrayWithCapacity:0];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Discover *message=[self messageWithDic:obj];
            [mArray addObject:message];
        }];
        
        NSLog(@"%@",mArray);
        
        //调用成功的回调
        if (successBlock) {
            successBlock(msg, mArray, status);
        }
    } fail:^(NSError *error){
        if (errorBlock) {
            errorBlock(error);
        }
    }];
    
    
    
}


@end
