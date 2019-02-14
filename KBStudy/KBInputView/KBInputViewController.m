//
//  ViewController.m
//  TEST
//
//  Created by 韩金波 on 2018/4/26.
//  Copyright © 2018年 韩金波. All rights reserved.
//
#import <Masonry.h>
#import "KBInputViewController.h"
#import "PNVerifyCodeInputView.h"

@interface KBInputViewController ()

@property(nonatomic,strong) PNVerifyCodeInputView *input ;
@end

@implementation KBInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.input = [[PNVerifyCodeInputView alloc] init];
    [self.view addSubview:self.input];

    
    [self.input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(284, 54));
    }];


}


@end
