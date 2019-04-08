//
//  KBFilterView.h
//  KBStudy
//
//  Created by 韩金波 on 2019/3/27.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import <AsyncDisplayKit/ASDisplayNode.h>
@class KBFilterView;
@protocol KBFilterViewDelegate <NSObject>

-(void)filterMenuNode:(KBFilterView *_Nullable)filterMenuNode didSelectedIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface KBFilterView : ASDisplayNode

@property (nonatomic, strong) NSArray <NSString *>* titleArray;

@property (nonatomic, weak) id <KBFilterViewDelegate> delegate;

-(void)updateMenuTitle:(NSString *)title index:(NSInteger)index;

-(void)unselectedAll;

@end

NS_ASSUME_NONNULL_END
