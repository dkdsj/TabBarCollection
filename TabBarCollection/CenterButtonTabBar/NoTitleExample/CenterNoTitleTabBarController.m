//
//  CenterNoTitleTabBarController.m
//  MCTabBarController
//
//  Created by caohouhong on 2018/12/7.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "CenterNoTitleTabBarController.h"
#import "HomeVC.h"
#import "DiscoveVC.h"
#import "MineVC.h"

@interface CenterNoTitleTabBarController ()

@end

@implementation CenterNoTitleTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //选中时的颜色
//    self.mcTabbar.tintColor = [UIColor colorWithRed:27.0/255.0 green:118.0/255.0 blue:208/255.0 alpha:1];
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    self.mcTabbar.translucent = NO;
    
#if 0
    self.mcTabbar.centerImage = [UIImage imageNamed:@"tab_unselect_gray"];
    self.mcTabbar.centerSelectedImage = [UIImage imageNamed:@"tab_select_blue"];
#else
    //zz add
    UIImage *homeEarth = [UIImage imageNamed:@"earth"];
    UIImage *homeEarthFill = [homeEarth imageChangeColor:kColorCustom];
    
    self.mcTabbar.centerImage = homeEarth;
    self.mcTabbar.centerSelectedImage = homeEarthFill;
#endif
    
    
    // 可设置宽高
//    self.mcTabbar.centerWidth = 40;
//    self.mcTabbar.centerHeight = 40;
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//添加子控制器
- (void)addChildViewControllers{
    UIImage *homePage = [UIImage imageNamed:@"tabBar_home"];
    UIImage *homeMine = [UIImage imageNamed:@"tabBar_mine"];
    
    UIImage *homePageFill = [homePage imageChangeColor:kColorCustom];
    UIImage *homeMineFill = [homeMine imageChangeColor:kColorCustom];
    
    //图片大小建议32*32
    [self addChildVC:[[HomeVC alloc] init] title:@"首页" image:homePage selectedImage:homePageFill];
    //中间这个不设置东西，只占位
    [self addChildVC:[[DiscoveVC alloc] init] title:@"发现" image:nil selectedImage:nil];
    [self addChildVC:[MineVC new] title:@"我的" image:homeMine selectedImage:homeMineFill];
    
}

@end
