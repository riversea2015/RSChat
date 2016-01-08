//
//  RSDBManager.m
//  RSChat
//
//  Created by hehai on 1/8/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import "RSDBManager.h"
#import "RSFileTools.h"

static RSDBManager *dbManager = nil;

@interface RSDBManager ()
@property (nonatomic, assign) NSInteger openNum;

@end

@implementation RSDBManager

/*
 创建并初始化数据库对象
 另，第一个带参数初始化方法，因为只在.m中使用，故不需要在.h中声明
 */
- (RSDBManager *)initWithDBName:(NSString *)name {
    self = [super init];
    if (self) {
        NSString *filePath = [[RSFileTools getDocPath] stringByAppendingPathComponent:name];
        db = [FMDatabase databaseWithPath:filePath];
    }
    return self;
}

+ (RSDBManager *)sharedManager {
    @synchronized(self) {
        if (!dbManager) {
            dbManager = [[RSDBManager alloc] initWithDBName:kDBNAME];
        }
    }
    return dbManager;
}

/*
 打开、关闭数据库
 */

- (BOOL)openDataBase {
    _openNum++;
    BOOL result = [db open];
    if (result) {
        NSLog(@"open dataBase succeeded");
    } else {
        NSLog(@"open dataBase failed");
        // 打印数据库执行语句及出错提示
        [db setTraceExecution:YES];
        [db setLogsErrors:YES];
    }
    return result;
}

- (BOOL)closeDataBase {
    _openNum--;
    BOOL result = [db open];
    if (result) {
        NSLog(@"open dataBase succeeded, oenNum:%ld", _openNum);
    } else {
        NSLog(@"open dataBase failed, oenNum:%ld", _openNum);
        // 打印数据库执行语句及出错提示
        [db setTraceExecution:YES];
        [db setLogsErrors:YES];
    }
    return result;
}

/*
 创建表
 */

#warning TODO 使用时，creatStr如何生成？是通过Model？
- (BOOL)creatTableWithStr:(NSString *)creatStr {
    return [db executeUpdate:creatStr];
}

@end
