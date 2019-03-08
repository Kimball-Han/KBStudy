//
//  KBGLPubSubDetailViewController.m
//  KBStudy
//
//  Created by 韩金波 on 2019/2/25.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBGLPubSubDetailViewController.h"
#import <GLPubSub/NSObject+GLPubSub.h>
@interface KBGLPubSubDetailViewController ()

@end

@implementation KBGLPubSubDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    [self subscribe:@"test" handler:^(GLEvent *event) {
        __strong typeof(self) strongSelf =  weakSelf;
        NSLog(@"-----------------");
        strongSelf.title = @"detail";
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // ref to: https://github.com/molon/MLTransition/issues/13
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    });
}

-(void)dealloc
{
//    [self unsubscribeAll];
    NSLog(@"KBGLPubSubDetailViewController dealloc");
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
