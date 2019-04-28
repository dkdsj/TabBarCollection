//
//  BaseTabBarVC.m
//  XinZhiBle
//
//  Created by zz on 2019/3/19.
//  Copyright © 2019 zz. All rights reserved.
//

#import "BaseTabBarVC.h"
#import "HomeVC.h"
#import "DiscoveVC.h"
#import "MineVC.h"

@interface BaseTabBarVC ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAllChildViewController];
}
// 添加全部的 childViewcontroller
- (void)addAllChildViewController {
    UIImage *homePage = [UIImage imageNamed:@"tabBar_home"];
    UIImage *homeMine = [UIImage imageNamed:@"tabBar_mine"];
    UIImage *homeDiscove = [UIImage imageNamed:@"tabBar_find"];
    
    UIImage *homePageFill = [homePage imageChangeColor:kColorCustom];
    UIImage *homeMineFill = [homeMine imageChangeColor:kColorCustom];
    UIImage *homeDiscoveFill = [homeDiscove imageChangeColor:kColorCustom];
    
    HomeVC *hv = [[HomeVC alloc] init];
    [self addChildVC:hv title:@"首页" image:homePage selectedImage:homePageFill];
    
    DiscoveVC *ov = [[DiscoveVC alloc] init];
    [self addChildVC:ov title:@"订单" image:homeDiscove selectedImage:homeDiscoveFill];
    
    MineVC *mv = [[MineVC alloc] init];
    [self addChildVC:mv title:@"我的" image:homeMine selectedImage:homeMineFill];
}

#pragma mark - 添加子控制器
-(void)addChildVC:(UIViewController *)childVc title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selImage {
    //设置子控制器的TabBarButton属性
    childVc.tabBarItem.title = title;//tab的title
    childVc.navigationItem.title = title;//nav的title
    childVc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    childVc.tabBarItem.selectedImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    KLTNavigationController *baseNav = [[KLTNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:baseNav];
}

-(void)addChildVC:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)image selectedImageName:(NSString *)selImage {
    //设置子控制器的TabBarButton属性
    childVc.tabBarItem.title = title;//tab的title
    childVc.navigationItem.title = title;//nav的title
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    KLTNavigationController *baseNav = [[KLTNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:baseNav];
}

+ (void)initialize {
    //设置未选中的TabBarItem的字体颜色、大小
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    attrs[NSForegroundColorAttributeName] = kColorWithHex(0x515151);
    
    //设置选中了的TabBarItem的字体颜色、大小
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    selectedAttrs[NSForegroundColorAttributeName] = kColorCustom;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

#pragma mark - 控制屏幕旋转方法
- (BOOL)shouldAutorotate{
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

@end
