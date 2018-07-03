//
//  WLZSecondController.m
//  WLZCyclycReference
//
//  Created by 王立志 on 2018/6/18.
//  Copyright © 2018年 王立志. All rights reserved.
//

#import "WLZSecondController.h"
#import "WLZTimer.h"
#import "WLZThread.h"

@interface WLZSecondController ()

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, assign)int repeatTime;
//第一、二种的属性
//@property (nonatomic, strong)NSTimer *timer;
//第三种方法的属性
@property (nonatomic, strong)WLZTimer *timer;

@property (nonatomic, strong)WLZThread *thread;

@end

@implementation WLZSecondController


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
//    [self createTimer];
    [self threadTest];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    self.navigationItem.rightBarButtonItem  = nil;
    UIBarButtonItem * newButton = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(senderHelp)];
    [newButton setTintColor:[UIColor whiteColor]];
    [newButton setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    [newButton setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateHighlighted];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"发布" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)senderHelp{
    NSLog(@"发布");
}

- (void)threadTest{
    NSLog(@"1");
    SEL sel = @selector(getCurrentThread);
//    WLZThread *thread = [[WLZThread alloc] init];
//    WLZThread *thread [[WLZThread alloc] initWithBlock:^{}];
    
//    //NSThread 创建方式1
    WLZThread *thread = [[WLZThread alloc] initWithTarget:self selector:@selector(createThread:) object:nil];
    [thread start];
//
//    //NSThread 创建方式2
//    [WLZThread detachNewThreadWithBlock:^{
//
//    }];
//
//    //NSThread 创建方式3
//    [WLZThread detachNewThreadSelector:@selector(createThread:) toTarget:self withObject:nil];
//
    [self performSelector:sel onThread:thread withObject:nil waitUntilDone:NO];
    thread.name = @"thread2";
    NSLog(@"thread.name === %@",thread.name);
    NSLog(@"2");
}

- (void)createThread:(NSString *)str{
    NSLog(@"createThread");
    [[NSRunLoop currentRunLoop] run];
//    [self.thread cancel];
//    self.thread = nil;
//    [NSThread exit];
}

- (void)getCurrentThread{
    NSThread *currentThread = [NSThread currentThread];
    NSLog(@"currentThread == %@",currentThread);
    NSLog(@"3");
    [currentThread cancel];
    if([currentThread isCancelled]){
        NSLog(@"cancelled");
        [NSThread exit];
    }
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
    self.timer = [[WLZTimer alloc] initWithTimeInterval:1 Target:self andSelector:@selector(change)];
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
