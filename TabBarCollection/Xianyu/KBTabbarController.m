//
//  KBTabbarController.m
//  KBTabbarController
//
//  Created by kangbing on 16/5/31.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import "KBTabbarController.h"
#import "KBTabbar.h"

#import "HomeVC.h"
#import "DiscoveVC.h"
#import "MineVC.h"

@interface KBTabbarController ()

@end

@implementation KBTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    
    HomeVC *hvc = [[HomeVC alloc] init];
    [self addChildVC:hvc title:@"首页" image:homePage selectedImage:homePageFill];
    
    MineVC *fvc = [[MineVC alloc] init];
    [self addChildVC:fvc title:@"活动" image:homeMine selectedImage:homeMine];
    
    
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    //  设置tabbar
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    // 设置自定义的tabbar
    [self setCustomtabbar];
}

- (void)setCustomtabbar{
    
    KBTabbar *tabbar = [[KBTabbar alloc]init];
    
    [self setValue:tabbar forKeyPath:@"tabBar"];

    [tabbar.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)centerBtnClick:(UIButton *)btn {
    NSLog(@"点击了中间");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"点击了中间按钮" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

//- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName navVc:(Class)navVc {
//    childController.title = title;
//    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    // 设置一下选中tabbar文字颜色
//
//    [childController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }forState:UIControlStateSelected];
//
//    UINavigationController* nav = [[navVc alloc] initWithRootViewController:childController];
//
//    [self addChildViewController:nav];
//}


- (UIImage *)imageWithColor:(UIColor *)color{
    // 一个像素
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
