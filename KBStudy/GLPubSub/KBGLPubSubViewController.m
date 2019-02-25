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
