//
//  KBPagerCell.m
//  KBStudy
//
//  Created by 韩金波 on 2019/2/20.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBPagerCell.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "KBTetureCell.h"
@interface KBPagerCell ()<ASTableDelegate,ASTableDataSource>
@property (nonatomic,strong) ASTableNode *tableNode;;
@end

@implementation KBPagerCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
        self.tableNode = [[ASTableNode alloc] init];
        self.tableNode.allowsSelection = NO;
        self.tableNode.delegate = self;
        self.tableNode.dataSource = self;
        self.tableNode.automaticallyAdjustsContentOffset = YES;
    }
    return self;
}
-(void)didLoad
{
    [super didLoad];

}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section;
{
    return 10;
}
-(ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ^ASCellNode * (){
        KBTetureCell *cell = [KBTetureCell new];
        return cell;
    };
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsZero child:_tableNode];
}
@end
