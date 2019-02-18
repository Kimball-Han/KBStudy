//
//  KBTetureCell.m
//  KBStudy
//
//  Created by 韩金波 on 2019/2/18.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBTetureCell.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
@interface KBTetureCell ()

@property(nonatomic, strong)ASTextNode *title;

@property(nonatomic, strong)ASTextNode *subTitle;

@end

@implementation KBTetureCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;

        _title = [[ASTextNode alloc] init];
        _title.attributedText = [[NSAttributedString alloc] initWithString:@"This is title" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        
        _subTitle = [[ASTextNode alloc] init];
        _subTitle.attributedText = [[NSAttributedString alloc] initWithString:@"This is subTitle" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    }
    return self;
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASStackLayoutSpec *stackLayout = [ASStackLayoutSpec verticalStackLayoutSpec];
    stackLayout.lineSpacing = 10;
    
    _subTitle.style.spacingBefore = 40;
    stackLayout.children = @[_title, _subTitle];
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 15, 10, 15) child:stackLayout];
}
@end
