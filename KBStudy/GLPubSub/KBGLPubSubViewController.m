//
//  KBGLPubSubViewController.m
//  KBStudy
//
//  Created by 韩金波 on 2019/2/25.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBGLPubSubViewController.h"
#import "KBGLPubSubDetailViewController.h"
#import <NSObject+GLPubSub.h>
@interface KBGLPubSubViewController ()

@end

@implementation KBGLPubSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btNext = [UIButton buttonWithType:UIButtonTypeSystem];
    [btNext setTitle:@"跳转" forState:UIControlStateNormal];
    [btNext addTarget:self action:@selector(pushToDetailVC) forControlEvents:UIControlEventTouchUpInside];
    [btNext sizeToFit];
    btNext.center = CGPointMake(100, 200);
    [self.view addSubview:btNext];
    
    UIButton *btPublish = [UIButton buttonWithType:UIButtonTypeSystem];
    [btPublish setTitle:@"发送消息" forState:UIControlStateNormal];
    [btPublish addTarget:self action:@selector(publishEvent) forControlEvents:UIControlEventTouchUpInside];
    [btPublish sizeToFit];
    btPublish.center = CGPointMake(100, 400);
    [self.view addSubview:btPublish];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
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

-(void)pushToDetailVC
{
    KBGLPubSubDetailViewController *detailVC = [KBGLPubSubDetailViewController new];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)publishEvent
{
    [self publish:@"test" data:nil];
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
