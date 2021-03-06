//
//  MCTabBarController.m
//  MCTabBarController
//
//  Created by caohouhong on 2018/12/7.
//  Copyright © 2018年 caohouhong. All rights reserved.
//  github:https://github.com/Ccalary/MCTabBarController

#import "MCTabBarController.h"

@interface MCTabBarController ()<UITabBarControllerDelegate>
@end

@implementation MCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mcTabbar = [[MCTabBar alloc] init];
    [_mcTabbar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_mcTabbar forKeyPath:@"tabBar"];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addChildVC:(UIViewController *)childVc title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    //设置子控制器的TabBarButton属性
    childVc.tabBarItem.title = title;//tab的title
    childVc.navigationItem.title = title;//nav的title
    childVc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    KLTNavigationController *baseNav = [[KLTNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:baseNav];
}

- (void)addChildVC:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)image selectedImageName:(NSString *)selectedImageName {
    //设置子控制器的TabBarButton属性
    childVc.tabBarItem.title = title;//tab的title
    childVc.navigationItem.title = title;//nav的title
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    KLTNavigationController *baseNav = [[KLTNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:baseNav];
}

// 重写选中事件， 处理中间按钮选中问题
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    _mcTabbar.centerBtn.selected = (tabBarController.selectedIndex == self.viewControllers.count/2);
    
    if (self.mcDelegate){
        [self.mcDelegate mcTabBarController:tabBarController didSelectViewController:viewController];
    }
}

- (void)buttonAction:(UIButton *)button{
    NSInteger count = self.viewControllers.count;
    self.selectedIndex = count/2;//关联中间按钮
    [self tabBarController:self didSelectViewController:self.viewControllers[self.selectedIndex]];
}
@end
