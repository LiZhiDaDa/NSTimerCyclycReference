//
//  TFQTimer.h
//  TFQCyclycReference
//
//  Created by 王立志 on 2018/6/19.
//  Copyright © 2018年 Thread_Fight_Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFQTimer : NSObject

@property (nonatomic, weak)id target;
@property (nonatomic, assign)SEL selector;

///创建timer
- (instancetype)initWithTimeInterval:(NSTimeInterval)interval Target:(id)target andSelector:(SEL)selector;
///销毁timer
- (void)closeTimer;

@end
