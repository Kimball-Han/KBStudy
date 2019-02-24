//
//  KBSegmentedNode.m
//  KBStudy
//
//  Created by 韩金波 on 2019/2/20.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBSegmentedNode.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "KBSegmentedCell.h"
@interface KBSegmentedNode ()<ASCollectionDelegate,ASCollectionDataSource>

@property(nonatomic,strong)ASCollectionNode *collectionNode;

@end

@implementation KBSegmentedNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        flowLayout.itemSize = CGSizeMake(80, 40);
        _collectionNode = [[ASCollectionNode alloc] initWithCollectionViewLayout:flowLayout];
        _collectionNode.dataSource = self;
        _collectionNode.delegate = self;
    }
    return self;
}
-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsZero child:_collectionNode];
}

-(void)setTitleArrays:(NSArray *)titleArrays
{
    _titleArrays = titleArrays;
    [_collectionNode reloadData];
}


-(void)setCurrentIndex:(NSInteger)currentIndex
{
    if (_currentIndex != currentIndex) {
    
        NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:_currentIndex inSection:0];
        _currentIndex = currentIndex;
        if (currentIndex > self.titleArrays.count) {
            return;
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];
        [self.collectionNode reloadItemsAtIndexPaths:@[oldIndexPath, indexPath]];
        
        [self.collectionNode scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

-(NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section
{
    return self.titleArrays.count;
}

- (ASCellNodeBlock)collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    NSString *title = self.titleArrays[indexPath.row];
    __weak typeof(self) weakSelf = self;
    return ^ASCellNode *(){
        __strong typeof(self) strongSelf = weakSelf;
       KBSegmentedCell *cell =  [[KBSegmentedCell alloc] init];
        cell.attributedString = [strongSelf getAttributedTextWithTitle:title row:indexPath.row];
        return cell;
    };
}

-(NSAttributedString *)getAttributedTextWithTitle:(NSString *)title row:(NSInteger)row
{
    UIFont * font = [UIFont systemFontOfSize:16];
    UIColor *textColor = [UIColor darkTextColor];
    if (row == self.currentIndex) {
        font = [UIFont boldSystemFontOfSize:18];
    }
    
    return [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor}];
}

-(void)collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndex = indexPath.row;
    if (self.didSelected) {
        self.didSelected(indexPath.row);
    }
}

@end
