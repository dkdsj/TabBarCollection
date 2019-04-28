//
//  AppDelegate.m
//  TabBarCollection
//
//  Created by zz on 2019/4/25.
//  Copyright © 2019 zz. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (instancetype)shareAppDelegate {
    AppDelegate *dg = (AppDelegate *)UIApplication.sharedApplication.delegate;
    return dg;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self launchViewController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)launchViewController {
    self.tabBarController = [[BaseTabBarVC alloc] init];
//    self.tabBarController = [[CenterNoTitleTabBarController alloc] init];
//    self.tabBarController = [[BulgeTabBarController alloc] init];
    self.tabBarController = [[KBTabbarController alloc] init];
    
    self.window.rootViewController = self.tabBarController;
}


@end
