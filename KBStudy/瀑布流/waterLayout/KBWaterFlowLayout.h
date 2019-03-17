//
//  KBWaterFlowLayout.h
//  KBStudy
//
//  Created by 韩金波 on 2019/3/17.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KBWaterFlowLayout;
@protocol KBWaterFlowLayoutDelegate <NSObject>

/**
  返回item的大小
 */
- (CGSize)waterFlowLayout:(KBWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
/**
 头视图Size
 */
-(CGSize )waterFlowLayout:(KBWaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section;

/**
 脚视图Size
 */
-(CGSize )waterFlowLayout:(KBWaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section;

@end

@interface KBWaterFlowLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat columnSpacing;

@property (nonatomic, assign) NSInteger columnCount;

@property (nonatomic, assign) CGFloat lineSpacing;

@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@property (nonatomic, weak) id<KBWaterFlowLayoutDelegate> delegate;

@end


