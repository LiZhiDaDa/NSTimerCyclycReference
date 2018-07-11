//
//  WLZTimer.m
//  WLZCyclycReference
//
//  Created by 王立志 on 2018/6/19.
//  Copyright © 2018年 王立志. All rights reserved.
//

#import "WLZTimer.h"

@interface WLZTimer ()

@property (nonatomic, strong)NSTimer *timer;

@end

@implementation WLZTimer

- (instancetype)initWithTimeInterval:(NSTimeInterval)interval Target:(id)target andSelector:(SEL)selector{
    if(self == [super init]){
        self.target = target;
        self.selector = selector;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(dosomething) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)dosomething{
    //这里是否要开启线程
//    dispatch_async(dispatch_get_main_queue(), ^{
        id target = self.target;
        SEL selector = self.selector;
        if([target respondsToSelector:selector]){
            [target performSelector:selector withObject:nil];
        }
//    });
}

- (void)closeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc{
    NSLog(@"WLZTimer dealloc");
}

@end
