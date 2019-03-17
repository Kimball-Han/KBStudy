//
//  KBWaterFlowLayout.m
//  KBStudy
//
//  Created by 韩金波 on 2019/3/17.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBWaterFlowLayout.h"
@interface KBWaterFlowLayout()

@property (strong, nonatomic) NSMutableArray *attrsArray;//存放所有cell的布局属性

@property (nonatomic, strong) NSMutableArray *columnHeights;//存放每一列的最大y值

@property (nonatomic, assign) CGFloat maxColumnHeight;//内容的高度

@end

@implementation KBWaterFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _columnCount = 2;
        _columnSpacing = 10;
        _lineSpacing = 10;
        _edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}
#pragma mark - getters
- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}
-(NSMutableArray *)attrsArray {
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

-(void)prepareLayout
{
    [super prepareLayout];
    //清除以前计算的所有高度
    self.maxColumnHeight = 0;
    
    [self.columnHeights removeAllObjects];
    
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(0)];
    }
    
     [self.attrsArray removeAllObjects];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    
    for (NSInteger section = 0; section < sectionCount; section++ ) {
        if ([self.delegate respondsToSelector:@selector(waterFlowLayout:sizeForHeaderViewInSection:)]) {
            [self.attrsArray addObject:[self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]]];
        }
        
        NSInteger rowCount = [self.collectionView numberOfItemsInSection:section];
        for (NSInteger row = 0; row < rowCount; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrsArray addObject:attrs];
        }
        
        if([self.delegate respondsToSelector:@selector(waterFlowLayout:sizeForFooterViewInSection:)]){
            UICollectionViewLayoutAttributes *footerAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            [self.attrsArray addObject:footerAttrs];
        }
    }
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

-(CGSize)collectionViewContentSize {
   
    return CGSizeMake(self.collectionView.frame.size.width, self.maxColumnHeight + self.edgeInsets.bottom);
}
//返回indexPath位置cell视图对应的布局属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes  layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionW = self.collectionView.frame.size.width;
    //cell的w宽
    CGFloat w = (collectionW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnSpacing) / self.columnCount;
    CGFloat h = [self.delegate waterFlowLayout:self sizeForItemAtIndexPath:indexPath].height;
    
    //取出高度最低的一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnSpacing);
    
    CGFloat y = minColumnHeight;
    if (indexPath.row/self.columnCount == 0 && minColumnHeight == 0) {
        y += self.edgeInsets.top;
    }else{
        y += self.lineSpacing;
    }
    
    self.columnHeights[destColumn] = @(CGRectGetMaxY(CGRectMake(x, y, w, h)));
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.maxColumnHeight < columnHeight) {
        self.maxColumnHeight = columnHeight;
    }

    attrs.frame = CGRectMake(x, y, w, h);
    return attrs;
}

//返回indexPath位置头和脚视图对应的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attri;
    
    if ([UICollectionElementKindSectionHeader isEqualToString:elementKind]) {
        
        //头视图
        attri = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
        
        attri.frame = [self headerViewFrameOfVerticalWaterFlow:indexPath];
        
    }else {
        
        //脚视图
        attri = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:indexPath];
        
        attri.frame = [self footerViewFrameOfVerticalWaterFlow:indexPath];
        
    }
    
    return attri;
    
}
- (CGRect)headerViewFrameOfVerticalWaterFlow:(NSIndexPath *)indexPath{
    
    CGSize size = CGSizeZero;
    
    if([self.delegate respondsToSelector:@selector(waterFlowLayout:sizeForHeaderViewInSection:)]){
        size = [self.delegate waterFlowLayout:self sizeForHeaderViewInSection:indexPath.section];
    }
    
    CGFloat x = 0;
    CGFloat y = self.maxColumnHeight ;
    if (indexPath.section == 0) {
        y = self.edgeInsets.top;
    }else if(size.height != 0){
        y +=  self.lineSpacing;
    }
    
    self.maxColumnHeight = y + size.height;
    //重置maxheight
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.maxColumnHeight)];
    }
    
    return CGRectMake(x , y, self.collectionView.frame.size.width, size.height);
    
}

- (CGRect)footerViewFrameOfVerticalWaterFlow:(NSIndexPath *)indexPath{
    
    CGSize size = CGSizeZero;
    
    if([self.delegate respondsToSelector:@selector(waterFlowLayout:sizeForFooterViewInSection:)]){
        size = [self.delegate waterFlowLayout:self sizeForFooterViewInSection:indexPath.section];
    }

    CGFloat x = 0;
    CGFloat y = size.height == 0 ? self.maxColumnHeight : self.maxColumnHeight + self.lineSpacing;
    
    self.maxColumnHeight = y + size.height;
    
    
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.maxColumnHeight)];
    }
    
    return  CGRectMake(x , y, self.collectionView.frame.size.width, size.height);
}

@end
