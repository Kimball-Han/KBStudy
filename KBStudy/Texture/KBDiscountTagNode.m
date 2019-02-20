//
//  KBDiscountTagNode.m
//  KBStudy
//
//  Created by 韩金波 on 2019/2/20.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBDiscountTagNode.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
@interface KBDiscountTagNode ()

@property(nonatomic, strong)ASImageNode *imageNode;

@property(nonatomic, strong)ASTextNode *discountInteger;

@property(nonatomic, strong)ASTextNode *discountDecimal;

@property(nonatomic, strong)ASTextNode *discountUnit;

@end

@implementation KBDiscountTagNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
        _imageNode = [[ASImageNode alloc] init];
        _imageNode.image = [UIImage imageNamed:@"iconZhekou"];
        
        _discountInteger = [[ASTextNode alloc] init];
        _discountInteger.attributedText = [[NSAttributedString alloc] initWithString:@"8" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
        
        _discountDecimal = [[ASTextNode alloc] init];
        _discountDecimal.attributedText = [[NSAttributedString alloc] initWithString:@".2" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:9]}];
        
        _discountUnit = [[ASTextNode alloc] init];
        _discountUnit.attributedText = [[NSAttributedString alloc] initWithString:@"折" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:9]}];
        
        self.style.preferredSize = CGSizeMake(28, 30);
    }
    return self;
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{


    
    
    ASStackLayoutSpec *rightStack = [ASStackLayoutSpec verticalStackLayoutSpec];
    rightStack.children = @[_discountDecimal,_discountUnit];
    
    ASStackLayoutSpec *mainStack = [ASStackLayoutSpec horizontalStackLayoutSpec];
    mainStack.justifyContent = ASStackLayoutJustifyContentCenter;
    mainStack.children = @[_discountInteger,rightStack];
    ASInsetLayoutSpec *main = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(4, 0, 0, 5) child:mainStack];
    
    
    return [ASBackgroundLayoutSpec backgroundLayoutSpecWithChild:main background:_imageNode] ;
}
@end
