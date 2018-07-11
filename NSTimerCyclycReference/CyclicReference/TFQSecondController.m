//
//  TFQSecondController.m
//  TFQCyclycReference
//
//  Created by 王立志 on 2018/6/18.
//  Copyright © 2018年 Thread_Fight_Queue. All rights reserved.
//

#import "TFQSecondController.h"
#import "TFQTimer.h"

@interface TFQSecondController ()

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, assign)int repeatTime;
//第一、二种的属性
//@property (nonatomic, strong)NSTimer *timer;
//第三种方法的属性
@property (nonatomic, strong)TFQTimer *timer;

@end

@implementation TFQSecondController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.repeatTime = 60;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    self.label.text = @"60";
    self.label.textColor = [UIColor blackColor];
    [self.view addSubview:self.label];
    [self createTimer];
}

#pragma mark - 第一种方法
//- (void)createTimer{
//    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(change) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
//}
//
//- (void)didMoveToParentViewController:(UIViewController *)parent{
//    if(parent == nil){
//        [self.timer invalidate];
//    }
//}
//
//- (void)change{
//    self.repeatTime --;
//    self.label.text = [NSString stringWithFormat:@"%d",self.repeatTime];
//    if(self.repeatTime == 0){
//        [self.timer invalidate];
//    }
//}
//
//- (void)dealloc{
//    NSLog(@"dealloc");
//}

#pragma mark - 第二种方法  这里只是随意创建了一个button，具体的图片、文案可以自己调试。
//- (void)createTimer{
//    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(change) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//    [self changeBackBarButtonItem];
//}
//
//- (void)changeBackBarButtonItem{
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(invalidateTimer)];
//}
//
//- (void)invalidateTimer{
//    [self.timer invalidate];
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)change{
//    self.repeatTime --;
//    self.label.text = [NSString stringWithFormat:@"%d",self.repeatTime];
//    if(self.repeatTime == 0){
//        [self.timer invalidate];
//    }
//}
//
//- (void)dealloc{
//    NSLog(@"dealloc");
//}


#pragma mark - 第三种方法
/*
 *  与第前两种不同的是：前两种只是在合适的时机解决循环引用，
 *  第三种根本就不会造成循环引用，可以封装起来供多个地方使用，而且遵循单一职责原则
 *
 */
- (void)createTimer{
    self.timer = [[TFQTimer alloc] initWithTimeInterval:1 Target:self andSelector:@selector(change)];
}

- (void)change{
    self.repeatTime --;
    self.label.text = [NSString stringWithFormat:@"%d",self.repeatTime];
    if(self.repeatTime == 0){
        [self.timer closeTimer];
    }
}

- (void)dealloc{
    [self.timer closeTimer];
    NSLog(@"dealloc");
}

#pragma mark - system method
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.repeatTime = 60;
}

@end
