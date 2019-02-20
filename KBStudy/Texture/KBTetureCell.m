//
//  KBTetureCell.m
//  KBStudy
//
//  Created by 韩金波 on 2019/2/18.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBTetureCell.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "KBDiscountTagNode.h"
#import "UIImage+Gradient.h"
@interface KBTetureCell ()

@property(nonatomic, strong)ASTextNode *activityName;

@property(nonatomic, strong)ASTextNode *activityEvent;

@property(nonatomic, strong)ASTextNode *activityMark;

@property(nonatomic, strong)ASTextNode *activityPrice;

@property(nonatomic, strong)ASImageNode *creditTag;

@property(nonatomic, strong)ASTextNode *seatTag;

@property(nonatomic, strong)ASTextNode *eleTag;

@property(nonatomic, strong)ASTextNode *publicize;

@property(nonatomic, strong)ASTextNode *discount;

@property(nonatomic, strong)ASNetworkImageNode *poster;

@property(nonatomic, strong)KBDiscountTagNode *discountTag;

@property(nonatomic, strong)ASButtonNode *hotRank;


@end

@implementation KBTetureCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
        
        _poster = [[ASNetworkImageNode alloc] init];
        _poster.URL = [NSURL URLWithString:@"https://pic2.zhimg.com/80/v2-eeee0ede009709b11c2600b2c7cbb219_hd.jpg"];

        _activityName = [[ASTextNode alloc] init];
        _activityName.maximumNumberOfLines = 2;
        _activityName.truncationMode = NSLineBreakByTruncatingTail;
        _activityName.attributedText = [[NSAttributedString alloc] initWithString:@"[上海]地表最强3地表最强3-周杰伦全球巡演演唱会周杰伦全球巡演演唱会周杰伦全球巡演演唱会周杰伦全球巡演演唱会" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        
        _activityEvent = [[ASTextNode alloc] init];
        _activityEvent.attributedText = [[NSAttributedString alloc] initWithString:@"2019-10-03 12:00 | 上海静安体育中心" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:11]}];
        
        _hotRank = [[ASButtonNode alloc] init];
        _hotRank.contentEdgeInsets = UIEdgeInsetsMake(2, 10, 2, 10);
        
        NSArray * colors = @[[UIColor colorWithRed:255/255.0 green:54/255.0 blue:109/255.0 alpha:1],[UIColor colorWithRed:255/255.0 green:107/255.0 blue:186/255.0 alpha:1]];

        [_hotRank setBackgroundImage:[[[UIImage gradientImageWithSize:CGSizeMake(40, 20) andColors:colors andGradientType:1] addCornerImageWithSize:CGSizeMake(40, 20)] stretchableImageWithLeftCapWidth:20 topCapHeight:10] forState:UIControlStateNormal] ;
        [_hotRank setTitle:@"演唱会热搜榜NO.1" withFont:[UIFont systemFontOfSize:12] withColor:[UIColor whiteColor] forState:UIControlStateNormal];

        _activityMark = [[ASTextNode alloc] init];
        _activityMark.attributedText = [[NSAttributedString alloc] initWithString:@"评分 10.0" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:11]}];
        
        _activityPrice = [[ASTextNode alloc] init];
        _activityPrice.attributedText = [[NSAttributedString alloc] initWithString:@"198 元起" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:11]}];
        
        _discount = [[ASTextNode alloc] init];
        _discount.attributedText = [[NSAttributedString alloc] initWithString:@"这是一段折扣信息" attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:11]}];

        _publicize = [[ASTextNode alloc] init];
        _publicize.attributedText = [[NSAttributedString alloc] initWithString:@"这是一段演出宣传信息" attributes:@{NSForegroundColorAttributeName:[UIColor darkTextColor],NSFontAttributeName:[UIFont systemFontOfSize:11]}];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        paragraphStyle.maximumLineHeight = 24;
        paragraphStyle.minimumLineHeight = 24;
        UIFont *font =   [UIFont systemFontOfSize:11];
        CGFloat baselineOffset = (24 - font.lineHeight) / 2;

        NSDictionary * arrributes = @{NSForegroundColorAttributeName:[UIColor grayColor],
                                      NSParagraphStyleAttributeName:paragraphStyle,
                                      NSFontAttributeName:font,
                                      NSBaselineOffsetAttributeName:@(baselineOffset)};
        _seatTag = [[ASTextNode alloc] init];
        _seatTag.style.preferredSize = CGSizeMake(40, 24);
        _seatTag.attributedText = [[NSAttributedString alloc] initWithString:@"选座" attributes:arrributes];
        
        _eleTag = [[ASTextNode alloc] init];
        _eleTag.style.preferredSize = CGSizeMake(50, 24);
        _eleTag.attributedText = [[NSAttributedString alloc] initWithString:@"电子票" attributes:arrributes];
        
        _discountTag = [[KBDiscountTagNode alloc] init];
        
        

        
    }
    return self;
}
-(void)didLoad
{
    [super didLoad];
    _eleTag.layer.cornerRadius = 12;
    _eleTag.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _eleTag.layer.borderWidth = 0.5;
    
    _seatTag.layer.cornerRadius = 12;
    _seatTag.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _seatTag.layer.borderWidth = 0.5;
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    ASStackLayoutSpec * tagStack = [ASStackLayoutSpec horizontalStackLayoutSpec];
    tagStack.spacing = 10;
    tagStack.children = @[_seatTag,_eleTag];
    
    ASStackLayoutSpec * rankStack = [ASStackLayoutSpec horizontalStackLayoutSpec];
    rankStack.spacing = 10;
    rankStack.children = @[_hotRank,_activityMark];
    
    _activityPrice.style.spacingBefore = 12;
    
    ASStackLayoutSpec *rightContentStack = [ASStackLayoutSpec verticalStackLayoutSpec];
    rightContentStack.alignItems = ASStackLayoutAlignItemsStretch;
    rightContentStack.spacing = 8;
    rightContentStack.style.flexShrink = 1;
    rightContentStack.children = @[_activityName,_activityEvent,rankStack,_activityPrice,_discount,tagStack,_publicize];
    
    
    _poster.style.preferredSize =  CGSizeMake(80, 110);
    
    ASCornerLayoutSpec * leftContent = [ASCornerLayoutSpec cornerLayoutSpecWithChild:_poster corner:_discountTag location:ASCornerLayoutLocationTopLeft];
    leftContent.offset = CGPointMake(16, 12);
    

    ASStackLayoutSpec *mainStack = [ASStackLayoutSpec horizontalStackLayoutSpec];
    mainStack.justifyContent = ASStackLayoutJustifyContentSpaceBetween;
    mainStack.alignItems = ASStackLayoutAlignItemsStart;
    mainStack.spacing = 15;
    mainStack.children = @[leftContent,rightContentStack];
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 15, 10, 15) child:mainStack];
}
@end
