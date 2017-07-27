//
//  DBUserInfoDataBaseManager.h
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/27.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBUserInfoDataBaseModel.h"

@interface DBUserInfoDataBaseManager : NSObject


//创建单例
+ (instancetype)shareDBManager;

- (BOOL)openDB;
- (BOOL)closeDB;
- (BOOL)isOpend;


/**
 增  插入数据
 @param messageModel 用户模型
 @return 消息id 也就是主键
 */

- (ino64_t)addNewUserInfoWithModel:(DBUserInfoDataBaseModel *)model;


/**
 删  根据id 删除数据
 @param uid
 @return 是否删除成功
 */
- (BOOL)deleteUserInfoWithUid:(NSString *)uid;

/**
 改
 @param messageModel 数据模型
 
 @return 是否修改成功
 */
- (BOOL)updateUserInfoModelWithModel:(DBUserInfoDataBaseModel *)model;

/**
 查 获取所有数据
 @param loginid  用户id , 可以多账号登录，获取不同的数据
 @param friendid 不同的聊天对象
 @param offset   查询数据起始位置
 @param limit    一次查询的最大个数，查询最新20条 offset=0,limit=20. 查询最新20-40条，offset=20,limit=20;
 如果是 -1 表示获取从开始位置起的所有数据。
 
 @return 模型数组
 */

- (NSArray<DBUserInfoDataBaseModel *> *)getAllUserInfoModelWithUid:(NSString *)uid;

@end
