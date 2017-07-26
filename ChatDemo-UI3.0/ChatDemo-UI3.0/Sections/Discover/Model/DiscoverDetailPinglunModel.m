//
//  DiscoverDetailPinglunModel.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/4/25.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DiscoverDetailPinglunModel.h"
#import "DiscoverHuifuModek.h"

@implementation DiscoverDetailPinglunModel

+ (instancetype)messageWithDic:(NSDictionary *)dic{
    
    DiscoverDetailPinglunModel *message=[[DiscoverDetailPinglunModel alloc]init];
    [message setValuesForKeysWithDictionary:dic];
    return message;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }

}

+ (void)discoverPinglunWithSuccessBlockWithPram:(NSDictionary *)param successBlock:(void(^)(NSMutableArray *array, int pageCount))successBlock errorBlock:(void(^)(NSError *error))errorBlock{

    
    [[NetworkManager new] postWithURL:CircleDetailURL parameter:param success:^(NSDictionary  *responseObject) {
        
        //获取JSON
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        
        NSArray *array=responseObject[@"data"];
        int pageCount = [responseObject[@"total_page"] intValue];
        NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i<array.count; i++) {
            
            NSMutableArray *subArray = [NSMutableArray arrayWithCapacity:0];
            DiscoverDetailPinglunModel *pinglunModel = [DiscoverDetailPinglunModel messageWithDic:array[i]];
            [subArray addObject:pinglunModel];
            
            NSArray *replyArray = pinglunModel.reply;
            for (int i = 0; i<replyArray.count; i++) {
                DiscoverHuifuModek *huifuModel = [[DiscoverHuifuModek alloc] init];
                [huifuModel setValuesForKeysWithDictionary:replyArray[i]];
                [subArray addObject:huifuModel];
            }
            [resultArray addObject:subArray];
        }

        
        //调用成功的回调
        if (successBlock) {
            successBlock(resultArray , pageCount);
        }
    } fail:^(NSError *error){
        if (errorBlock) {
            errorBlock(error);
        }
    }];

    
}


@end
