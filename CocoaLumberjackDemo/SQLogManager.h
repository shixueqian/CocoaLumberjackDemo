//
//  SQLogManager.h
//  CocoaLumberjackDemo
//
//  Created by 石学谦 on 2020/5/4.
//  Copyright © 2020 shixueqian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

//声明外部变量
extern DDLogLevel ddLogLevel;


// 默认的宏，方便使用
#define Log(frmt, ...)        LogI(frmt, ##__VA_ARGS__)

// 提供不同的宏，对应到特定参数的对外接口
#define LogE(frmt, ...)       DDLogError(frmt, ##__VA_ARGS__)
#define LogW(frmt, ...)       DDLogWarn(frmt, ##__VA_ARGS__)
#define LogI(frmt, ...)       DDLogInfo(frmt, ##__VA_ARGS__)
#define LogD(frmt, ...)       DDLogDebug(frmt, ##__VA_ARGS__)
#define LogV(frmt, ...)       DDLogVerbose(frmt, ##__VA_ARGS__)




@interface SQLogManager : NSObject

//初始化
+ (void)start;
+ (instancetype)sharedInstance;
- (instancetype)init NS_UNAVAILABLE;

//添加控制台logger
- (void)addOSLogger;
//添加文件写入Logger
- (void)addFileLogger;
//移除控制台logger
- (void)removeOSLogger;
//移除文件写入Logger
- (void)removeFileLogger;

#pragma mark - 等级切换

//切换log等级
- (void)switchLogLevel:(DDLogLevel)logLevel;

#pragma mark - 文件Log操作

- (void)createAndRollToNewFile;
//所有log文件路径
- (NSArray *)filePaths;
//当前活跃的log文件路径
- (NSString *)currentFilePath;

@end

