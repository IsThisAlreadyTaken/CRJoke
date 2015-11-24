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
#import "RESideMenu.h"

@interface MainTabBarVC ()

@end

@implementation MainTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //最新
    NewVC *newVC= [[NewVC alloc] init];
    UINavigationController *nvNew  = [self addBarBtnBy:newVC];
    nvNew.tabBarItem.title =@"最新";
    [nvNew.tabBarItem setImage:[[UIImage imageNamed:@"red_New"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
    
    
    //热门
    HotVC *hotVC= [[HotVC alloc] init];
    UINavigationController *nvHot  = [self addBarBtnBy:hotVC];
    nvHot.tabBarItem.title = @"热门";
    [nvHot.tabBarItem setImage:[[UIImage imageNamed:@"captain"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    //真相
    TrueVC *trueVC= [[TrueVC alloc] init];
    UINavigationController *nvTrue  = [self addBarBtnBy:trueVC];
    nvTrue.tabBarItem.title = @"真相";
    [nvTrue.tabBarItem setImage:[[UIImage imageNamed:@"ironman"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //关于
    AboutVC *aboutVC= [[AboutVC alloc] init];
    UINavigationController *nvAbout  = [self addBarBtnBy:aboutVC];
    nvAbout.tabBarItem.title = @"关于";
    [nvAbout.tabBarItem setImage:[[UIImage imageNamed:@"wolverine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
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


# pragma mark -- private 

-(UINavigationController *) addBarBtnBy:(UIViewController *)col
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:col];
    
    
    col.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar-sidebar"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickMenuButton)];
    
    
    return nav;

}


- (void)onClickMenuButton
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

@end
