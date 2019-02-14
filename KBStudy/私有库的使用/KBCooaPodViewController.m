//
//  KBCooaPodViewController.m
//  KBStudy
//
//  Created by 韩金波 on 2019/2/14.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBCooaPodViewController.h"
#import <KBRedView.h>
@interface KBCooaPodViewController ()

@end

@implementation KBCooaPodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    KBRedView *redView = [[KBRedView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:redView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
