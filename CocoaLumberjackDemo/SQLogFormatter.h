//
//  SQLogFormatter.h
//  CocoaLumberjackDemo
//
//  Created by 石学谦 on 2020/5/3.
//  Copyright © 2020 shixueqian. All rights reserved.
//  Log输出格式自定义(遵循DDLogFormatter协议，然后实现formatLogMessage:方法)

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQLogFormatter : NSObject<DDLogFormatter>

@end

NS_ASSUME_NONNULL_END
