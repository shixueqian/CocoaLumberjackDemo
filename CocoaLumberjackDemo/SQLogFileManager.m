//
//  SQLogFileManager.m
//  CocoaLumberjackDemo
//
//  Created by 石学谦 on 2020/5/3.
//  Copyright © 2020 shixueqian. All rights reserved.
//

#import "SQLogFileManager.h"

@implementation SQLogFileManager

//重写方法(log文件名生成规则)
- (NSString *)newLogFileName {
    
    NSString *timeStamp = [self getTimestamp];
    
    return [NSString stringWithFormat:@"%@.log", timeStamp];
}

//重写方法(是否是log文件)
- (BOOL)isLogFile:(NSString *)fileName {
    
    BOOL hasProperSuffix = [fileName hasSuffix:@".log"];
    
    return hasProperSuffix;
}

- (NSString *)getTimestamp {
    static dispatch_once_t onceToken;
    static NSDateFormatter *dateFormatter;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"YYYY.MM.dd-HH.mm.ss"];
    });
    return [dateFormatter stringFromDate:NSDate.date];
}

//重写方法(log文件夹路径)
- (NSString *)defaultLogsDirectory {

#if TARGET_OS_IPHONE
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *baseDir = paths.firstObject;
    NSString *logsDirectory = [baseDir stringByAppendingPathComponent:@"SQLog/Logs"];
#else
    NSString *appName = [[NSProcessInfo processInfo] processName];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? paths[0] : NSTemporaryDirectory();
    NSString *logsDirectory = [[basePath stringByAppendingPathComponent:@"SQLog/Logs"] stringByAppendingPathComponent:appName];
#endif

    return logsDirectory;
}

@end
