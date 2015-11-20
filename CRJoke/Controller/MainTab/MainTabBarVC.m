//
//  MainTabBarVC.m
//  CRJoke
//
//  Created by chengran on 15/11/13.
//  Copyright © 2015年 chengran. All rights reserved.
//

#import "MainTabBarVC.h"
#import "NewVC.h"
#import "HotVC.h"
#import "AboutVC.h"
#import "TrueVC.h"

@interface MainTabBarVC ()

@end

@implementation MainTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //最新
    NewVC *newVC= [[NewVC alloc] init];
    UINavigationController *nvNew  = [[UINavigationController alloc] initWithRootViewController:newVC];
    nvNew.tabBarItem.title =@"最新";
    
    
    //热门
    HotVC *hotVC= [[HotVC alloc] init];
    UINavigationController *nvHot  = [[UINavigationController alloc] initWithRootViewController:hotVC];
    nvHot.tabBarItem.title = @"热门";

    //真相
    TrueVC *trueVC= [[TrueVC alloc] init];
    UINavigationController *nvTrue  = [[UINavigationController alloc] initWithRootViewController:trueVC];
    nvTrue.tabBarItem.title = @"真相";
    
    //关于
    AboutVC *aboutVC= [[AboutVC alloc] init];
    UINavigationController *nvAbout  = [[UINavigationController alloc] initWithRootViewController:aboutVC];
    nvAbout.tabBarItem.title = @"关于";
    
    
//添加tabBar
    self.viewControllers = @[nvNew,nvHot,nvTrue,nvAbout];
    
    
     
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
