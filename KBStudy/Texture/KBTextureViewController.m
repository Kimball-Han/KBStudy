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
#import "KBSegmentedNode.h"
#import <Masonry.h>
#import "KBFilterView.h"
@interface KBTextureViewController ()<ASPagerDelegate,ASPagerDataSource>

@property (nonatomic, strong)ASPagerNode *pagerNode;

@property (nonatomic, strong)ASDisplayNode *rootNode;

@property (nonatomic, strong)KBSegmentedNode * segmentedNode;

@property (nonatomic, strong)KBFilterView * filterNode;

@end



@implementation KBTextureViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _pagerNode = [ASPagerNode new];
        _pagerNode.dataSource = self;
        _pagerNode.delegate = self;
        _pagerNode.style.flexGrow = 1;
        if (@available(iOS 11.0, *)) {
            _pagerNode.view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        
        _segmentedNode = [[KBSegmentedNode alloc] init];
        _segmentedNode.style.flexBasis = ASDimensionMake(40);
        _segmentedNode.titleArrays =@[@"title1",@"title2",@"title3",@"title4",@"title5",@"title6",@"title7",@"title8"];
        
        _filterNode = [[KBFilterView alloc] init];
        _filterNode.style.flexBasis = ASDimensionMake(40);
        _filterNode.titleArray = @[@"button 1",@"button 2"];
        
        __weak typeof(self) weakSelf = self;
        _segmentedNode.didSelected = ^(NSInteger index) {
            __strong typeof(self) strongSelf = weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.pagerNode scrollToPageAtIndex:index animated:YES];
            });
        };
        
        _rootNode = [[ASDisplayNode alloc] init];
        _rootNode.automaticallyManagesSubnodes = YES;
        _rootNode.layoutSpecBlock = ^ASLayoutSpec * _Nonnull(__kindof ASDisplayNode * _Nonnull node, ASSizeRange constrainedSize) {
            __strong typeof(self) strongSelf = weakSelf;
            ASStackLayoutSpec *stackLayout = [ASStackLayoutSpec verticalStackLayoutSpec];
            stackLayout.spacing = 0;
            stackLayout.justifyContent = ASStackLayoutJustifyContentSpaceBetween;
            stackLayout.children = @[strongSelf.segmentedNode,strongSelf.filterNode,strongSelf.pagerNode];
            return stackLayout;
        };

    }
    return self;
}

-(void)dealloc
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubnode:_rootNode];
    [_rootNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(0);
            make.left.right.bottom.mas_equalTo(0);
        } else {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
        }
    }];
    self.view.backgroundColor = [UIColor whiteColor];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
 
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.segmentedNode setCurrentIndex:self.pagerNode.currentPageIndex];
}

@end
