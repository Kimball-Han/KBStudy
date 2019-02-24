//
//  KBSegmentedNode.h
//  KBStudy
//
//  Created by 韩金波 on 2019/2/20.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "ASDisplayNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface KBSegmentedNode : ASDisplayNode

@property(nonatomic,strong)NSArray *titleArrays;

@property(nonatomic,assign)NSInteger currentIndex;

@property(nonatomic,copy) void (^didSelected)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
