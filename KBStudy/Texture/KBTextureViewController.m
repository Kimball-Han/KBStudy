//
//  KBTextureViewController.m
//  KBStudy
//
//  Created by 韩金波 on 2019/2/18.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBTextureViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "KBPagerCell.h"
@interface KBTextureViewController ()<ASPagerDelegate,ASPagerDataSource>
@property (nonatomic, strong)ASPagerNode *pagerNode;
@end



@implementation KBTextureViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pagerNode = [ASPagerNode new];
        _pagerNode.dataSource = self;
        _pagerNode.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubnode:_pagerNode];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _pagerNode.frame = self.view.bounds;

}



- (NSInteger)numberOfPagesInPagerNode:(nonnull ASPagerNode *)pagerNode {
    return 8;
}



- (ASCellNodeBlock)pagerNode:(ASPagerNode *)pagerNode nodeBlockAtIndex:(NSInteger)index;
{
    return ^ASCellNode *(){
        return [[KBPagerCell alloc] init];
    };
}
@end
