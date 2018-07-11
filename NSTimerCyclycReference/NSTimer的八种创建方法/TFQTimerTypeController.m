//
//  TFQTimerTypeController.m
//  TFQCyclycReference
//
//  Created by 王立志 on 2018/6/19.
//  Copyright © 2018年 Thread_Fight_Queue. All rights reserved.
//

#import "TFQTimerTypeController.h"

@interface TFQTimerTypeController ()

@end

@implementation TFQTimerTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - CreateTimer
/**
 *   一、 NSTimer 具体有八种创建方式如下所示
 *   12、34、56、78 是参数对应的关系
 *
 *   二、 按照创建方式又分为三大类
 *   timerWithTimeInterval 135、scheduledTimerWithTimeInterval 246、initWithFireDate 78
 *
 *   三、 按照运行方式又可以分为两大类
 *   一种需要手动加入runloop 13578、另一种就是自动加入runloop 246(弊端:runloop只能是当前runloop，模式是NSDefaultRunLoopMode)
 *
 *   参数介绍:
 *   interval: 时间间隔,单位:秒,如果<0,系统默认为0.1
 *   target: 定时器绑定对象,一般都是self
 *   selector: 需要调用的实例方法
 *   userInfo: 传递相关信息
 *   repeats: YES:循环   NO:执行一次就失效
 *   block: 需要执行的代码块  作用等同于  selector里边的方法体
 *   invocation: 需要执行的方法,具体使用方法可以自己baidu,现在这个已经很少用了。
 *   fireDate: 触发的时间，一般都写[NSDate date]，这样的话定时器会立马触发一次，并且以此时间为基准。如果没有此参数的方法，则都是以当前时间为基准，第一次触发时间是当前时间加
 *             上时间间隔interval
 */
- (void)createTimer{
    NSInvocation *invocation = [[NSInvocation alloc] init];
    
    //1
    NSTimer *timer1 = [NSTimer timerWithTimeInterval:1 invocation:invocation repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];
    
    //2
    [NSTimer scheduledTimerWithTimeInterval:1 invocation:invocation repeats:YES];

    //3
    [NSTimer timerWithTimeInterval:1 target:self selector:@selector(doSomething) userInfo:nil repeats:YES];
    
    //4
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doSomething) userInfo:nil repeats:YES];
    
    //5   API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0))
    [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //定时器需要执行的方法
    }];
    
    //6   API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0))
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //定时器需要执行的方法
    }];
    
    NSDate *date = [NSDate date];
    //7   API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0))
    NSTimer *timer7 = [[NSTimer alloc] initWithFireDate:date interval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //定时器需要执行的方法
    }];
    [timer7 fire];
    
    //8
    NSTimer *timer8 = [[NSTimer alloc] initWithFireDate:date interval:1 target:self selector:@selector(doSomething) userInfo:nil repeats:YES];
    
    //该方法表示定时器只会执行一次，无视repeats
    [timer8 fire];
}

- (void)doSomething{
    NSLog(@"do something");
}

@end























