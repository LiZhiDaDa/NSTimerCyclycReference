//
//  ViewController.m
//  WLZCyclycReference
//
//  Created by 王立志 on 2018/6/18.
//  Copyright © 2018年 王立志. All rights reserved.
//

#import "ViewController.h"
#import "WLZSecondController.h"
#import "WLZThread.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, assign)int repeatTime;
@property (nonatomic, assign)CGPoint point;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
//    [self threadTest];
    [self loadTableView];
}
- (void)a{
    SEL sel;
    //三种 这三种跟直接调用方法没有区别,同步执行任务,阻塞当前线程。执行完sel再继续执行原来任务
    [self performSelector:sel];
    [self performSelector:sel withObject:nil];
    [self performSelector:sel withObject:nil withObject:nil];
    
    //两种   延时执行、不阻塞当前线程
    [self performSelector:sel withObject:nil afterDelay:1];
    NSArray *array;
    [self performSelector:sel withObject:nil afterDelay:1 inModes:array];
    
    //两种 在主线程执行  YES:阻塞主线程  NO:不阻塞主线程
    [self performSelectorOnMainThread:sel withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:sel withObject:nil waitUntilDone:YES modes:array];
    
    //一种 开启子线程执行方法
    [self performSelectorInBackground:sel withObject:nil];
    
    //两种  指定某个线程执行方法  YES:阻塞当前线程  NO:不阻塞当前线程
    NSThread *thread;
    [self performSelector:sel onThread:thread withObject:nil waitUntilDone:YES];
    [self performSelector:sel onThread:thread withObject:nil waitUntilDone:YES modes:array];

}

- (void)threadTest{
    NSLog(@"1");
    SEL sel = @selector(getCurrentThread);
    WLZThread *thread = [[WLZThread alloc] initWithTarget:self selector:@selector(createThread:) object:nil];
    [thread start];
    [self performSelector:sel onThread:thread withObject:nil waitUntilDone:NO];
    
    
    NSLog(@"2");
    
}
- (void)getCurrentThread{
    sleep(3);
    NSThread *currentThread = [NSThread currentThread];
//    [currentThread cancel];
//    currentThread = nil;
    NSLog(@"currentThread == %@",currentThread);
    NSLog(@"3");
    if([currentThread isCancelled]){
        NSLog(@"cancelled");
        [NSThread exit];
    }
}
- (void)createThread:(NSString *)str{
    NSLog(@"createThread");
    
}

//- (void)threadTest{
//    NSLog(@"我是任务1");
//    NSLog(@"我是任务2");
//}

- (void)threadTest1{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSLog(@"1");
        NSThread *mainThread = [NSThread currentThread];
        NSLog(@"currentThread == %@",mainQueue);
        sleep(3);
        NSLog(@"2");
        NSLog(@"123");
    });
    NSLog(@"主线程执行完了");
}

- (void)dealloc{
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    WLZSecondController *second = [[WLZSecondController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTableView{
    UITableView *tableview = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    if(fabs(self.point.y) > 2000){
        cell.backgroundColor = [UIColor blackColor];
    }else{
        cell.backgroundColor = indexPath.row%2 ? [UIColor redColor] : [UIColor greenColor];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.point = [scrollView.panGestureRecognizer velocityInView:self.view];
    NSLog(@"%f",self.point.y);
}

@end
