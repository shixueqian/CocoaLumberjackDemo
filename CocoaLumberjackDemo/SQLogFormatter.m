//
//  SQLogFormatter.m
//  CocoaLumberjackDemo
//
//  Created by 石学谦 on 2020/5/3.
//  Copyright © 2020 shixueqian. All rights reserved.
//

#import "SQLogFormatter.h"

@implementation SQLogFormatter


//实现方法
- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
 NSString *logLevel = nil;
     switch (logMessage->_flag) {
         case DDLogFlagError:
             logLevel = @"Error";
             break;
         case DDLogFlagWarning:
             logLevel = @"Warn";
             break;
         case DDLogFlagInfo:
             logLevel = @"Info";
             break;
         case DDLogFlagDebug:
             logLevel = @"Debug";
             break;
         default:
             logLevel = @"Verbose";
             break;
     }
     NSString *formatLog = [NSString stringWithFormat:@"[SQ]%@%@-%ld\n%@",logLevel,logMessage->_function,logMessage->_line,logMessage->_message];
     return formatLog;
}

@end
