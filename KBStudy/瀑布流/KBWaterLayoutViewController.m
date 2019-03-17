//
//  KBWaterLayoutViewController.m
//  KBStudy
//
//  Created by 韩金波 on 2019/3/17.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBWaterLayoutViewController.h"
#import "KBWaterFlowLayout.h"
#import <Masonry.h>
#import "KBWaterFlowLayoutCell.h"
#import "KBWaterFlowLayoutReusableView.h"
@interface KBWaterLayoutViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,KBWaterFlowLayoutDelegate>

@end

@implementation KBWaterLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    KBWaterFlowLayout *flowLayout  = [[KBWaterFlowLayout alloc] init];
    flowLayout.delegate = self;
    
    UICollectionView *colletionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    colletionView.delegate = self;
    colletionView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        colletionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    colletionView.backgroundColor = [UIColor lightGrayColor];
    [colletionView registerClass:[KBWaterFlowLayoutCell class] forCellWithReuseIdentifier:@"KBWaterFlowLayoutCell"];
    [colletionView registerClass:[KBWaterFlowLayoutReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KBWaterFlowLayoutReusableView"];
    [colletionView registerClass:[KBWaterFlowLayoutReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"KBWaterFlowLayoutReusableView"];
    [self.view addSubview:colletionView];

    [self.view addSubview:colletionView];
    
    
    [colletionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    KBWaterFlowLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KBWaterFlowLayoutCell" forIndexPath:indexPath];
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 4;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

-(UICollectionReusableView  *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"KBWaterFlowLayoutReusableView" forIndexPath:indexPath];
}


- (CGSize)waterFlowLayout:(KBWaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section {
    return CGSizeMake(100,  30);
}

- (CGSize)waterFlowLayout:(KBWaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section {
    return CGSizeMake(100,  60);
}

- (CGSize)waterFlowLayout:(KBWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, arc4random()%100 + 50);

}



@end
