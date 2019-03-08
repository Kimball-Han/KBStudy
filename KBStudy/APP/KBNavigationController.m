//
//  KBNavigationController.m
//  TEST
//
//  Created by 韩金波 on 2018/8/16.
//  Copyright © 2018年 韩金波. All rights reserved.
//

#import "KBNavigationController.h"

@interface KBNavigationController ()<UIGestureRecognizerDelegate,UINavigationBarDelegate>

@end

@implementation KBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count == 1) {
        return NO;
    }
    return YES;
}
-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
  
    return NO;
}

@end
