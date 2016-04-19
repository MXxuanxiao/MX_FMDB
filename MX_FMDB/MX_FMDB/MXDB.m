//
//  MXDB.m
//  MX_FMDB
//
//  Created by maguanxiao on 16/4/14.
//  Copyright © 2016年 MX. All rights reserved.
//

#import "MXDB.h"

@implementation MXDB
+ (FMDatabase *)sharedBase
{
    static FMDatabase *MXBase = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSString *path = SF2(@"%@/%@", NSHomeDirectory(), MXdbName);
        MXBase = [FMDatabase databaseWithPath:path];
    });
    return MXBase;
}
/**
 *  创建表
 *
 *  @param name 表名
 *  @param keys 主键为id 不用传
 *
 *  @return bool
 */
+(BOOL)createTbName:(NSString *)name keys:(NSArray *)keys {
//create table if not exists student(id integer primary key autoincrement,name varchar(20),age integer ,sex integer)
    NSString *key = [keys componentsJoinedByString:@","];
    NSString *sql = SF2(@"create table if not exists %@(id integer primary key autoincrement,%@)", name, key);
    return [[MXDB sharedBase] executeStatements:sql];
//    if ([[MXDB sharedBase] executeQuery:sql]) {
//        NSLog(@"创建成功");
//        return YES;
//    }else{
//        NSLog(@"创建失败");
//        return NO;
//    }
    
}
/**
 *  增加数据
 *
 *  @param name   表名
 *  @param sql    筛选条件
 *  @param keys   key
 *  @param values value
 *
 *  @return bool
 */
+(BOOL)insertTbName:(NSString *)name keys:(NSArray *)keys values:(NSArray *)values {
    //insert into student(name,age,sex) values('233344',18,1)
    NSMutableArray *vs = [NSMutableArray arrayWithArray:values];
    for (int i = 0; i<values.count; i++) {
        id obj = [values objectAtIndex:i];
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *str = SF(@"'%@'", obj);
            [vs replaceObjectAtIndex:i withObject:str];
        }
    }
    NSString *key = [keys componentsJoinedByString:@","];
    NSString *value = [vs componentsJoinedByString:@","];
    NSString *sql = SF3(@"insert into %@(%@) values(%@)", name, key, value);
    return [[MXDB sharedBase] executeStatements:sql];
}
+(BOOL)insertTbName:(NSString *)name dict:(NSDictionary *)dict {
    NSArray *keys = [dict allKeys];
    NSArray *values = [dict allValues];
    return [MXDB insertTbName:name keys:keys values:values];
}
+(BOOL)insertTbName:(NSString *)name array:(NSArray *)array {
    [[MXDB sharedBase] beginTransaction];
    NSInteger flag = 0;
    for (NSDictionary *dict in array) {
        if (![MXDB insertTbName:name dict:dict]) {
            flag = 1;
        }
    }
    if (flag) {
        [[MXDB sharedBase] rollback];
        return NO;
    }
    [[MXDB sharedBase] commit];
    return YES;
}
/**
 *  删除数据
 *
 *  @param name <#name description#>
 *  @param sql  <#sql description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)deleteTbNmae:(NSString *)name sql:(NSString *)sql {
//    @"delete from student where id = 2";
    NSString *delsql =SF2(@"delete from %@ where %@", name, sql);

    return [[MXDB sharedBase] executeStatements:delsql];
}

+(BOOL)updataTbName:(NSString *)name sql:(NSString *)sql keys:(NSArray *)keys values:(NSArray *)values {
    //@"update student set name = 'sb' where id = 2";
    NSString *upSql = SF3(@"update %@ set %@ = %@", name, keys[0], values[0]);
    NSString *updateSql =SF2(@"%@ where %@", upSql,sql);
    return [[MXDB sharedBase] executeStatements:updateSql];
}
/**
 *  获取数据库信息
 *
 *  @param name 表名
 *  @param sql  筛选条件
 *
 *  @return <#return value description#>
 */
+(NSDictionary *)selectDictInfoTbName:(NSString *)name sql:(NSString *)sql keys:(NSArray *)keys {
//    NSString *selectSql = @"select *from student";
//    FMResultSet *set = [dataBase executeQuery:selectSql];
//    while (set.next) {
//        NSLog(@"%@",set);
//        NSLog(@"%d", [set intForColumnIndex:1]);
//        NSLog(@"%@", [set stringForColumn:@"name"]);
    NSString *selSql = SF2(@"select *from %@ where %@", name, sql);
    FMResultSet *set = [[MXDB sharedBase] executeQuery:selSql];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    while (set.next) {
        for (NSString *key in keys) {
            [dict setValue:[set stringForColumn:key] forKey:key];
        }
    }
    return dict;
}

+(NSArray *)selectArrayInfoTbName:(NSString *)name sql:(NSString *)sql keys:(NSArray *)keys {
    NSMutableArray *array = [NSMutableArray array];
    NSString *selSql = SF2(@"select *from %@ where %@", name, sql);
    FMResultSet *set = [[MXDB sharedBase] executeQuery:selSql];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    while (set.next) {
        for (NSString *key in keys) {
            [dict setValue:[set stringForColumn:key] forKey:key];
        }
        [array addObject:dict];
    }
    return array;
    
}
+(void)open {
    [[MXDB sharedBase] open];
}
+(void)close {
    [[MXDB sharedBase] close];
}
@end
