//
//  KBFilterView.m
//  KBStudy
//
//  Created by 韩金波 on 2019/3/27.
//  Copyright © 2019 韩金波. All rights reserved.
//
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "KBFilterView.h"
@interface KBFilterView()

@property (nonatomic, strong)NSMutableArray <ASDisplayNode *> * subnodeArray;

@property (nonatomic, strong)NSMutableArray <ASButtonNode *> * filterButtonArray;


@end

@implementation KBFilterView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
    }
    return self;
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASStackLayoutSpec *stack = [ASStackLayoutSpec horizontalStackLayoutSpec];
    stack.lineSpacing = 0;
    stack.children = self.subnodeArray;
    stack.alignItems = ASStackLayoutAlignItemsCenter;
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 15, 0, 15) child:stack];
}

-(void)setTitleArray:(NSArray<NSString *> *)titleArray{
    _titleArray = titleArray;
    NSInteger count = titleArray.count;
    NSMutableArray *itemButtonArray = [NSMutableArray array];
    NSMutableArray *subnodeArray = [NSMutableArray array];

    [titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       ASButtonNode *itemButton = [[ASButtonNode alloc] init];
        [itemButton setTitle:obj withFont:[UIFont systemFontOfSize:14] withColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [itemButton setTitle:obj withFont:[UIFont systemFontOfSize:14] withColor:[UIColor redColor] forState:UIControlStateSelected];
        [itemButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [itemButton setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [itemButton addTarget:self action:@selector(itemButtonEvent:) forControlEvents:ASControlNodeEventTouchUpInside];
        itemButton.style.flexGrow = 1;
        itemButton.style.flexShrink = 1;
        [itemButtonArray addObject:itemButton];
        [subnodeArray addObject:itemButton];

        if (idx != count -1) {
            ASDisplayNode *lineNode = [[ASDisplayNode alloc] init];
            lineNode.backgroundColor = [UIColor lightGrayColor];
           ASInsetLayoutSpec *inset= [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(15, 0, 15, 0) child:lineNode];
            inset.style.flexBasis = ASDimensionMake(1.0);

            [subnodeArray addObject:inset];
        }
    }];
    self.filterButtonArray = itemButtonArray;
    self.subnodeArray = subnodeArray;
    if (count > 0) {
        [self setNeedsLayout];
    }
}

-(void)itemButtonEvent:(ASButtonNode *)sender{
    [self.filterButtonArray enumerateObjectsUsingBlock:^(ASButtonNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == sender) {
            obj.selected = YES;
            if ([self.delegate respondsToSelector:@selector(filterMenuNode:didSelectedIndex:)]) {
                [self.delegate filterMenuNode:self didSelectedIndex:idx];
            }
        }else{
            obj.selected = NO;
        }
    }];
}

-(void)updateMenuTitle:(NSString *)title index:(NSInteger)index{
    if (index >= 0 && self.filterButtonArray.count > index) {
        ASButtonNode *itemButton = self.filterButtonArray[index];
        itemButton.selected = NO;
        if (title.length > 0) {
            [itemButton setTitle:title withFont:[UIFont systemFontOfSize:14] withColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            [itemButton setTitle:title withFont:[UIFont systemFontOfSize:14] withColor:[UIColor redColor] forState:UIControlStateSelected];
        }
    }
}

-(void)unselectedAll{
    [self.filterButtonArray enumerateObjectsUsingBlock:^(ASButtonNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = YES;
    }];
}

@end
