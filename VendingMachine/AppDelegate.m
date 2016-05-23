//
//  AppDelegate.m
//  VendingMachine
//
//  Created by LEEJIHO on 2016. 5. 13..
//  Copyright © 2016년 LEEJIHO. All rights reserved.
//

#import "AppDelegate.h"
//#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    NSLog(@"willFinishLaunchingWithOptions : %@", launchOptions);
    return YES;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    NSLog(@"didFinishLaunchingWithOptions : %@, application : %@", launchOptions, application);
//     //윈도우 객체 생성
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    
//    // 메인 VC 객체 생성
//    MainViewController *vc = [[MainViewController alloc] init];
//    
//    // 메인 VC 배경 색상
//    [vc.view setBackgroundColor:[UIColor  whiteColor]];
//    
//    // window root로 vc설정
//    self.window.rootViewController = vc;
//    
//    // 화면 갱신
//    [self.window makeKeyAndVisible];
//    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSLog(@"applicationWillResignActive");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
     NSLog(@"applicationDidEnterBackground");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationWillEnterForeground");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
