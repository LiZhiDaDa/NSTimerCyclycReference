//
//  ViewController.m
//  WLZCyclycReference
//
//  Created by 王立志 on 2018/6/18.
//  Copyright © 2018年 王立志. All rights reserved.
//

#import "ViewController.h"
#import "WLZSecondController.h"

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
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    WLZSecondController *second = [[WLZSecondController alloc] init];
    [self.navigationController pushViewController:second animated:YES];
}

- (void)dealloc{
}



@end
