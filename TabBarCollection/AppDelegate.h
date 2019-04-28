//
//  AppDelegate.h
//  TabBarCollection
//
//  Created by zz on 2019/4/25.
//  Copyright © 2019 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarVC.h"
#import "CenterNoTitleTabBarController.h"
#import "BulgeTabBarController.h"
#import "KBTabbarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (instancetype)shareAppDelegate;

//@property (nonatomic, strong) BaseTabBarVC *tabBarController;
//@property (nonatomic, strong) CenterNoTitleTabBarController *tabBarController;
//@property (nonatomic, strong) BulgeTabBarController *tabBarController;
@property (nonatomic, strong) KBTabbarController *tabBarController;

@end

