//
//  UIViewController+KBHelper.m
//  KBStudy
//
//  Created by 韩金波 on 2019/12/25.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "UIViewController+KBHelper.h"


@implementation UIViewController (KBHelper)

+ (nullable UIViewController *)kb_visibleViewController {
    UIViewController *rootViewController = UIApplication.sharedApplication.delegate.window.rootViewController;
    UIViewController *visibleViewController = [rootViewController kb_visibleViewControllerIfExist];
    return visibleViewController;
}

-(UIViewController *)kb_visibleViewControllerIfExist{
    
    if (self.presentedViewController) {
        return [self.presentedViewController kb_visibleViewControllerIfExist];
    }
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        return [((UINavigationController *)self).visibleViewController kb_visibleViewControllerIfExist];
    }
    
    if ([self isKindOfClass:[UITabBarController class]]) {
        return [((UITabBarController *)self).selectedViewController kb_visibleViewControllerIfExist];
    }
    
    if ([self kb_isViewLoadedAndVisible]) {
        return self;
    } else {
        NSLog(@"找不到可见的viewController");
        return nil;
    }
}

- (BOOL)kb_isViewLoadedAndVisible {
    return self.isViewLoaded;
}

@end
