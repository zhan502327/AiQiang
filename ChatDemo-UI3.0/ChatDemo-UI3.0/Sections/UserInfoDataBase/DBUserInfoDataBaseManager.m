//
//  DBUserInfoDataBaseManager.m
//  ChatDemo-UI3.0
//
//  Created by zhandb on 2017/7/27.
//  Copyright © 2017年 zhandb. All rights reserved.
//

#import "DBUserInfoDataBaseManager.h"
#import <FMDB.h>

// 数据库名
#define DBUserInfoDataBaseSQLName @"DBUserInfoDataBaseSQLName.sqlite"

// 数据表名
#define DBUserInfoTableName @"DBUserInfoTable"

// 数据库版本表名
#define DBUserInfoVersionTableNmae @"DBUserInfoTableVersionTable"

// 数据库版本号
static NSString *DBUserInfoTabeleVersion_num = @"1";


static DBUserInfoDataBaseManager *dbManager = nil;


@interface DBUserInfoDataBaseManager ()

@property (nonatomic, strong) FMDatabase *database;

@end

@implementation DBUserInfoDataBaseManager

+ (instancetype)shareDBManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbManager = [[DBUserInfoDataBaseManager alloc] init];
    });
    return dbManager;
}

- (instancetype)init{
    if (self == [super init]) {
        //判断时候有数据库表格存在
        if ([[NSFileManager defaultManager] fileExistsAtPath:[DBUserInfoDataBaseManager dataPath]] == YES) {//路径存在 直接打开

            FMDatabase *database = [FMDatabase databaseWithPath:[DBUserInfoDataBaseManager dataPath]];
            self.database = database;

            if ([self.database open] == NO) {
                [self.database close];
            }else{
                // 2.是否升级版本号
                // 如果需要更新数据库，那么可以在这里对相应的表添加和删除字段 并且更改版本号
                
                NSString *needAddClomn =@"age";//1.数据库升级增加列
                NSString *updateGradeSql = nil;
                if(![self.database columnExists:needAddClomn inTableWithName:DBUserInfoTableName]) {
                    updateGradeSql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ TEXT",DBUserInfoTableName,needAddClomn];
                }
                
                
                NSString* needCutClomn = @"age";//2.数据库升级删除列
                if([self.database columnExists:needCutClomn inTableWithName:DBUserInfoTableName]) {
                    updateGradeSql = [NSString stringWithFormat:@"ALTER TABLE %@ DROP %@ TEXT",DBUserInfoTableName,needCutClomn];
                }
                

                // 如果不需要更新，直接传递 nil  版本号码需要更改
                [self updateGradeSql:nil newVersion:DBUserInfoTabeleVersion_num];
            }
        }else{//没有表格直接创建
            
            FMDatabase *database = [FMDatabase databaseWithPath:[DBUserInfoDataBaseManager dataPath]];
            self.database = database;

            if ([self createtable] == NO) {
                return  nil;
            }
        }
    }
    return self;
}

// 创建userInfoTable  和 版本表
- (BOOL)createtable {
    
    [self.database open];
    
    // 创建版本表
    {
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('id' integer primary key autoincrement, 'version' text not null default '1', 'updateDate' text not null default '')", DBUserInfoVersionTableNmae];
        if([self.database executeUpdate:sql] == NO){
            NSLog(@"创建 DBUserInfoTableVersionTable 表失败");
            [self.database close];
            return NO;
        }
        
        // 创建版本号
        [self addNewVersion:DBUserInfoTabeleVersion_num];
    }
    
    // 创建数据库显示表
    {
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ('userID' integer primary key autoincrement, 'uid' text default '', 'nickname' text default '', 'headimg' text default '', 'remark' text default '')", DBUserInfoTableName];
    
        if([self.database executeUpdate:sql] == NO){
            NSLog(@"创建 DBUserInfoTable 表失败");
            [self.database close];
            return NO;
        }
    }
    
    [self.database close];
    return YES;
}


/**
 添加版本号
 
 @param version version description
 
 @return return value description
 */
- (BOOL)addNewVersion:(NSString*)version{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss-zzz"];
    NSString *datestring = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (version, updateDate) values ('%@','%@')",DBUserInfoVersionTableNmae,version,datestring];

    return [self.database executeUpdate:sql];
}


/**
 更新数据库版本
 1、版本低更新插入新的版本，2、版本一样不需要更新 3、没有记录版本，更新插入
 
 @param updateGradeSql 需要执行的 添加字段的版本号
 @param newVersion     新的版本号
 
 @return 是否更新成功
 */
- (BOOL)updateGradeSql:(NSString *)updateGradeSql newVersion:(NSString *)newVersion {
    
    // 不需要更新
    if (updateGradeSql == nil){
        return YES;
    }else {// 需要更新
        NSString *spl = [NSString stringWithFormat:@"select * from %@ order by id desc limit 0,1",DBUserInfoVersionTableNmae];
        FMResultSet *set = [self.database executeQuery:spl];
        CGFloat lastversion = -1.0;
        while ([set next]) {
            lastversion = [[set stringForColumn:@"version"] floatValue];
            if ([newVersion floatValue] > lastversion){
                // 执行更新数据库版本
                if([self.database executeUpdate:updateGradeSql]){
                    return [self addNewVersion:newVersion];
                }
            }
        }
        // 没有记录版本号，需要更新
        if (lastversion == -1) {
            if([self.database executeUpdate:updateGradeSql]){
                return [self addNewVersion:newVersion];
            }
        }
    }
    return YES;
}


- (BOOL)openDB {
    return [self.database open];
}
- (BOOL)closeDB {
    return [self.database close];
}
- (BOOL)isOpend {
    return [self.database goodConnection];
}

/**
 创建数据表的存储地址
 
 @return 返回之地
 */
+(NSString *)dataPath {
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [document stringByAppendingPathComponent:DBUserInfoDataBaseSQLName];
    
}


#pragma mark - 增
- (ino64_t)addNewUserInfoWithModel:(DBUserInfoDataBaseModel *)model{
    if (model == nil) {
        return NO;
    }
    
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (uid,nickname,headimg,remark) values (?,?,?,?)",DBUserInfoTableName];
    NSString *uid = [NSString stringWithString:model.uid];
    NSString *nickname = [NSString stringWithString:model.nickname];
    NSString *headimg = [NSString stringWithString:model.headimg];
    NSString *remark = [NSString stringWithFormat:@"%@",model.remark];
    
    NSArray *array = @[uid, nickname, headimg, remark];
    if ([self.database executeUpdate:sql withArgumentsInArray:array]){
        return self.database.lastInsertRowId;
    }else{
        NSLog(@"插入数据出错 %@",self.database.lastErrorMessage);
        return -1;
    }
}

#pragma mark - 删除

- (BOOL)deleteUserInfoWithUid:(NSString *)uid{
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where uid=%@",DBUserInfoTableName, uid];
    return [self.database executeUpdate:sql];
}



#pragma mark - 改
- (BOOL)updateUserInfoModelWithModel:(DBUserInfoDataBaseModel *)model{
    NSString *sql = [NSString stringWithFormat:@"update %@ set uid=?,nickname=?,headimg=?,remark=?", DBUserInfoTableName];
    
    NSString *uid = [NSString stringWithString:model.uid];
    NSString *nickname = [NSString stringWithString:model.nickname];
    NSString *headimg = [NSString stringWithString:model.headimg];
    NSString *remark = [NSString stringWithString:model.remark];

    NSArray *array = @[uid, nickname, headimg, remark];
    BOOL isupdate = [self.database executeUpdate:sql withArgumentsInArray:array];
    
    return isupdate;
}


#pragma mark - 查
- (NSArray<DBUserInfoDataBaseModel *> *)getUserInfoModelWithUid:(NSString *)uid{
    if (uid<=0){
        NSLog(@"参数 uid 不对");
        return nil;
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM '%@'WHERE uid = %@",DBUserInfoTableName,uid];
    
    NSMutableArray<DBUserInfoDataBaseModel *> *data = [NSMutableArray array];
    FMResultSet *set = [self.database executeQuery:sql];
    while ([set next]) {
        DBUserInfoDataBaseModel *model = [[DBUserInfoDataBaseModel alloc] init];
        model.uid = [set stringForColumn:@"uid"];
        model.nickname = [set stringForColumn:@"nickname"];
        model.headimg = [set stringForColumn:@"headimg"];
        model.remark = [set stringForColumn:@"remark"];
    
        [data addObject:model];
    }
    if (data.count>0){
        return [NSArray arrayWithArray:data];
    }else{
        return nil;
    }
    
}

// 查询所有数据
- (NSArray<DBUserInfoDataBaseModel *> *)getAllUserInfoModel{
    
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM '%@'",DBUserInfoTableName];
    
    NSMutableArray<DBUserInfoDataBaseModel *> *data = [NSMutableArray array];
    FMResultSet *set = [self.database executeQuery:sql];
    while ([set next]) {
        DBUserInfoDataBaseModel *model = [[DBUserInfoDataBaseModel alloc] init];
        model.uid = [set stringForColumn:@"uid"];
        model.nickname = [set stringForColumn:@"nickname"];
        model.headimg = [set stringForColumn:@"headimg"];
        model.remark = [set stringForColumn:@"remark"];
        
        [data addObject:model];
    }
    if (data.count>0){
        return [NSArray arrayWithArray:data];
    }else{
        return nil;
    }
    
}

@end
