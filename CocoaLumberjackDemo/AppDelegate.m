//
//  AppDelegate.m
//  CocoaLumberjackDemo
//
//  Created by 石学谦 on 2020/5/2.
//  Copyright © 2020 shixueqian. All rights reserved.
//

#import "AppDelegate.h"
#import "SQLogFormatter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Log功能初始化
    [SQLogManager start];
    
    //添加控制台Logger
    [[SQLogManager sharedInstance] addOSLogger];
    //添加文件写入Logger
    [[SQLogManager sharedInstance] addFileLogger];
    
    Log(@"沙盒地址：%@",NSHomeDirectory());
    
    return YES;
}





@end
