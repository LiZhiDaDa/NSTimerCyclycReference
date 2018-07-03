//
//  AppDelegate.m
//  WLZCyclycReference
//
//  Created by 王立志 on 2018/6/18.
//  Copyright © 2018年 王立志. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ViewController *c = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:c  ];
    self.window.rootViewController = nav;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    
    __block UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"system handler");
        [application endBackgroundTask:task];
        task = UIBackgroundTaskInvalid;
    }];
//
        NSTimeInterval leftTime = [application backgroundTimeRemaining];
        NSLog(@"time left == %f",leftTime);
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//
//        NSLog(@"we want do something here,");
//
//
//        sleep(185);
//
//        NSTimeInterval leftTime = [application backgroundTimeRemaining];
//        NSLog(@"time left == %f",leftTime);
//
//        NSLog(@"we finished");
//        // tell application we have finished
//        [application endBackgroundTask:task];
//        task = UIBackgroundTaskInvalid;
//    });
    
    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for(int i=0; i<200; i++){
            sleep(1);
            NSLog(@"%d",i);
        }
    });

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
