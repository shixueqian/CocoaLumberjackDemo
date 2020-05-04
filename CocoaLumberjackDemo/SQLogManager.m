//
//  SQLogManager.m
//  CocoaLumberjackDemo
//
//  Created by 石学谦 on 2020/5/4.
//  Copyright © 2020 shixueqian. All rights reserved.
//

#import "SQLogManager.h"
#import "SQLogFormatter.h"
#import "SQFileLogFormatter.h"
#import "SQLogFileManager.h"

//设置默认的log等级
#ifdef DEBUG
DDLogLevel ddLogLevel = DDLogLevelDebug;
#else
DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif


@interface SQLogManager ()

@property (nonatomic, strong)DDFileLogger *fileLogger;//控制台logger
@property (nonatomic, strong)DDOSLogger *osLogger;//文件写入Logger

@end

@implementation SQLogManager

+ (void)start {
    
    [self sharedInstance];
}

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}




#pragma mark - Logger添加及删除

//添加控制台logger
- (void)addOSLogger {
    [DDLog addLogger:self.osLogger];
}
//添加文件写入Logger
- (void)addFileLogger {
    [DDLog addLogger:self.fileLogger];
}
//移除控制台logger
- (void)removeOSLogger {
    [DDLog removeLogger:_osLogger];
}
//移除文件写入Logger
- (void)removeFileLogger {
    [DDLog removeLogger:_fileLogger];
}


#pragma mark - 等级切换

//切换log等级
- (void)switchLogLevel:(DDLogLevel)logLevel {
        
    ddLogLevel = logLevel;
}


#pragma mark - 文件Log操作

- (void)createAndRollToNewFile {
    //achive现在的文件，新生成一个文件，并将以后的log写入新文件
    [_fileLogger rollLogFileWithCompletionBlock:^{
        NSLog(@"rollLogFileWithCompletionBlock");
    }];
}

//所有log文件路径
- (NSArray *)filePaths {
    return _fileLogger.logFileManager.sortedLogFilePaths;
}

//当前活跃的log文件路径
- (NSString *)currentFilePath {
    
    NSString *filePath = _fileLogger.currentLogFileInfo.filePath;
    return filePath;
}


#pragma mark - 懒加载

//控制台logger
- (DDOSLogger *)osLogger {
    if (!_osLogger) {
        
        _osLogger = [DDOSLogger sharedInstance];
        //自定义输出格式
        _osLogger.logFormatter = [[SQLogFormatter alloc] init];
    }
    return _osLogger;
}

//文件写入Logger
- (DDFileLogger *)fileLogger {
    if (!_fileLogger) {
        
        //使用自定义的logFileManager
        SQLogFileManager *fileManager = [[SQLogFileManager alloc] init];
        _fileLogger = [[DDFileLogger alloc] initWithLogFileManager:fileManager];
        //使用自定义的Logformatter
        _fileLogger.logFormatter = [[SQFileLogFormatter alloc] init];
        
        //重用log文件，不要每次启动都创建新的log文件(默认值是NO)
        _fileLogger.doNotReuseLogFiles = NO;
        //log文件在24小时内有效，超过时间创建新log文件(默认值是24小时)
        _fileLogger.rollingFrequency = 60*60*24;
        //log文件的最大3M(默认值1M)
        _fileLogger.maximumFileSize = 1024*1024*3;
        //最多保存7个log文件(默认值是5)
        _fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        //log文件夹最多保存10M(默认值是20M)
        _fileLogger.logFileManager.logFilesDiskQuota = 1014*1024*10;
    }
    return _fileLogger;
}

@end
