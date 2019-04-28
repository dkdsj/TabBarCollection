//
//  BulgeTabBarController.m
//  MCTabBarController
//
//  Created by caohouhong on 2018/12/7.
//  Copyright © 2018年 caohouhong. All rights reserved.
//  

#import "BulgeTabBarController.h"
#import "HomeVC.h"
#import "DiscoveVC.h"
#import "MineVC.h"

@interface BulgeTabBarController ()<MCTabBarControllerDelegate>

@end

@implementation BulgeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //选中时的颜色
    self.mcTabbar.tintColor = kColorCustom;
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    self.mcTabbar.translucent = NO;
    
    //zz add
    UIImage *homeEarth = [UIImage imageNamed:@"earth"];
    UIImage *homeEarthFill = [homeEarth imageChangeColor:kColorCustom];

    self.mcTabbar.centerImage = homeEarth;
    self.mcTabbar.centerSelectedImage = homeEarthFill;

    self.mcTabbar.position = MCTabBarCenterButtonPositionTop;//change
    self.mcDelegate = self;
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
    [self addChildVC:[[HomeVC alloc] init] title:@"首页" image:homePage selectImage:homePageFill];
    //中间这个不设置东西，只占位
    [self addChildVC:[[DiscoveVC alloc] init] title:@"发现" image:nil selectImage:nil];
    
    [self addChildVC:[[MineVC alloc] init] title:@"我的" image:homeMine selectImage:homeMineFill];
}

- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage {
    childVC.tabBarItem.image = image;
    // 选中的颜色由tabbar的tintColor决定
    childVC.tabBarItem.selectedImage = selectImage;
    childVC.title = title;
    childVC.navigationItem.title = title;

    KLTNavigationController *baseNav = [[KLTNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:baseNav];
}

// 使用MCTabBarController 自定义的 选中代理
- (void)mcTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 2){
        
        //zz del
//        [self rotationAnimation];
    }else {
        [self.mcTabbar.centerBtn.layer removeAllAnimations];
    }
}

//旋转动画
- (void)rotationAnimation{
    if ([@"key" isEqualToString:[self.mcTabbar.centerBtn.layer animationKeys].firstObject]){
        return;
    }
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3.0;
    rotationAnimation.repeatCount = HUGE;
    [self.mcTabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
}

@end
