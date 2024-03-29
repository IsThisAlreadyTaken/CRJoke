//
//  AppDelegate.m
//  CRJoke
//
//  Created by chengran on 15/11/13.
//  Copyright © 2015年 chengran. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarVC.h"
#import "RESideMenu.h"
#import "DEMOLeftMenuViewController.h"


//#import <UIKit/>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //创建总tabBar
    MainTabBarVC *mainView = [[MainTabBarVC alloc] init];
    
    
    //创建侧滑界面
     DEMOLeftMenuViewController *leftMenuViewController = [[DEMOLeftMenuViewController alloc] init];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] init];
    sideMenuViewController.contentViewController = mainView;
    sideMenuViewController.leftMenuViewController = leftMenuViewController;
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
//    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    
    
    self.window.rootViewController = sideMenuViewController;
    
    
//    [[UITabBar appearance] setTintColor:[UIColor clearColor]];
    [[UITabBarItem appearance ] setTitleTextAttributes:@{ NSFontAttributeName :[UIFont systemFontOfSize:12] ,NSForegroundColorAttributeName : [UIColor redColor] } forState:UIControlStateSelected];
    
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    
    
    
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
