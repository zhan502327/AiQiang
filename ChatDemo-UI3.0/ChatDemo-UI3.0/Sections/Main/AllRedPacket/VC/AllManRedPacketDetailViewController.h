//
//  AllManRedPacketDetailViewController.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/5/2.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllManRedPacketListModel.h"
#import "MyCollectionListModel.h"
#import "MyRedBagListModel.h"
#import "SellerRedBagListModel.h"


@interface AllManRedPacketDetailViewController : UIViewController

@property (nonatomic, strong) AllManRedPacketListModel *allManmodel;
@property (nonatomic, strong) MyCollectionListModel *mycollectionModel;
@property (nonatomic, strong) MyRedBagListModel *myRedBagModel;
@property (nonatomic, strong) SellerRedBagListModel *sellerRedBagModel;

//主页轮播图 商家红包id
@property (nonatomic, strong) NSString *sellerID;


@end
