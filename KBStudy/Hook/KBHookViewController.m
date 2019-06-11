//
//  KBHookViewController.m
//  KBStudy
//
//  Created by 韩金波 on 2019/6/11.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBHookViewController.h"
#import "NSObject+Swizzzling.h"
@interface KBHookViewController ()

@end

@implementation KBHookViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self hookIfPossible:@selector(viewWillAppear:) selector:@selector(kb_viewWillAppear:)];
}

-(void)kb_viewWillAppear:(BOOL)animated{
    NSLog(@"1");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"2");
}



@end

