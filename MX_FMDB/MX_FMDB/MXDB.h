//
//  MXDB.h
//  MX_FMDB
//
//  Created by maguanxiao on 16/4/14.
//  Copyright © 2016年 MX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>


#define MXdbName @"MXData.db"
#define TB_name_student @"student"




//string
#define StringFormat(_format,_arg) [NSString stringWithFormat:_format,_arg]
#define SF(_format,_arg) StringFormat(_format,_arg)
#define SF2(_format,_arg1,_arg2) [NSString stringWithFormat:_format,_arg1,_arg2]
#define SF3(_format,_arg1,_arg2,_arg3) [NSString stringWithFormat:_format,_arg1,_arg2,_arg3]
@interface MXDB : NSObject
/**
 *  创建表
 *
 *  @param name 表名
 *  @param keys 主键为id 不用穿
 *
 *  @return bool
 */
+(BOOL)createTbName:(NSString *)name keys:(NSArray *)keys;
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

+(BOOL)insertTbName:(NSString *)name keys:(NSArray *)keys values:(NSArray *)values;
+(BOOL)insertTbName:(NSString *)name dict:(NSDictionary *)dict;
+(BOOL)insertTbName:(NSString *)name array:(NSArray *)array;

/**
 *  删除数据
 *
 *  @param name <#name description#>
 *  @param sql  <#sql description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)deleteTbNmae:(NSString *)name sql:(NSString *)sql;

+(BOOL)updataTbName:(NSString *)name sql:(NSString *)sql keys:(NSArray *)keys values:(NSArray *)values;
/**
 *  获取数据库信息
 *
 *  @param name 表名
 *  @param sql  筛选条件
 *
 *  @return <#return value description#>
 */
+(NSDictionary *)selectDictInfoTbName:(NSString *)name sql:(NSString *)sql keys:(NSArray *)keys;
+(NSArray *)selectArrayInfoTbName:(NSString *)name sql:(NSString *)sql keys:(NSArray *)keys;
+(void)open;
+(void)close;
@end
