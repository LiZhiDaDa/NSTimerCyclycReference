//
//  ViewController.m
//  TFQCyclycReference
//
//  Created by 王立志 on 2018/6/18.
//  Copyright © 2018年 Thread_Fight_Queue. All rights reserved.
//

#import "ViewController.h"
#import "TFQSecondController.h"

@interface ViewController ()

@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, assign)int repeatTime;
@property (nonatomic, assign)CGPoint point;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    //test
    //我提交了1.0版本
    //我提交了v1.1版本
        
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TFQSecondController *second = [[TFQSecondController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
}

- (void)dealloc{
}



@end
