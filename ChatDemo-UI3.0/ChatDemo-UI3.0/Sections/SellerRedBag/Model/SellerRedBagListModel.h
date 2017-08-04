//
//  SellerRedBagListModel.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/20.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SellerRedBagListModel : NSObject

/*
 id: "4",
 start_time: "1488297598",
 title: "等额红包测试",
 img: "/Uploads/Picture/2017-03-13/58c60b8bee3eb.png",
 count_down: 0
 
 
 id = 1;
 img = "/Uploads/Picture/2017-08-04/59841e07ef3fc.jpg";
 "start_time" = 1501776000;
 title = "\U7231\U62a2APP\U9650\U65f6\U798f\U5229\Uff0c\U4eca\U65e5\U9996\U53d1";
 "v_img" = "/Uploads/Picture/2017-08-04/59841e0d02bad.png";
 
 
 */
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *count_down;



@end
