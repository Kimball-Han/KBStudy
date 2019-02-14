//
//  KBHomeLayoutViewController.m
//  KBStudy
//
//  Created by 韩金波 on 2018/12/25.
//  Copyright © 2018 韩金波. All rights reserved.
//

#import "KBHomeLayoutViewController.h"
#import "KBSectionView.h"
#import <Masonry.h>
@interface KBHomeLayoutViewController ()

@property(nonatomic,weak)UIScrollView *scrollView;

@property(nonatomic,weak)UIStackView  *stackView;

@end

@implementation KBHomeLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _scrollView = scrollView;
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.spacing = 10;
    
    [scrollView addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(self.view);
    }];
    _stackView = stackView;
    
    for (int i  = 0 ; i < 10; i++) {
        KBSectionView * sectionView = [[KBSectionView alloc] initWithTitle:[NSString stringWithFormat:@"section %d",i]];
        [_stackView addArrangedSubview:sectionView];
        if (i == 5) {
            sectionView.hidden = YES;//动态配置隐藏，会重新布局;
        }
    }
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
