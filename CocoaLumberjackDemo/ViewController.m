//
//  ViewController.m
//  CocoaLumberjackDemo
//
//  Created by 石学谦 on 2020/5/2.
//  Copyright © 2020 shixueqian. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Log文件的路径
    Log(@"当前活跃Log文件路径：currentFilePath=%@",[[SQLogManager sharedInstance] currentFilePath]);
    Log(@"当前logs文件夹内所有Log文件路径：filePaths=%@",[[SQLogManager sharedInstance] filePaths]);
}

//打印各个等级的Log
- (IBAction)onClickBtn1:(id)sender {
    
    LogE(@"LogE");
    LogW(@"LogW");
    LogI(@"LogI");
    LogD(@"LogD");
    LogV(@"LogV");
    
    Log(@"Log");
}
//切换Log等级
- (IBAction)onClickBtn2:(id)sender {
    
    //切换到Verbose等级
    [[SQLogManager sharedInstance] switchLogLevel:DDLogLevelVerbose];
    
}
//清空当前Log
- (IBAction)onClickBtn3:(id)sender {
    
    [[SQLogManager sharedInstance] createAndRollToNewFile];
}
//移除控制台Logger
- (IBAction)onClickBtn4:(id)sender {
    
    [[SQLogManager sharedInstance] removeOSLogger];
}
//添加控制台Logger
- (IBAction)onClickBtn5:(id)sender {
    [[SQLogManager sharedInstance] addOSLogger];
}
//移除文件写入Logger
- (IBAction)onClickBtn6:(id)sender {
    [[SQLogManager sharedInstance] removeFileLogger];
}
//添加文件写入Logger
- (IBAction)onClickBtn7:(id)sender {
    [[SQLogManager sharedInstance] addFileLogger];
}


@end
