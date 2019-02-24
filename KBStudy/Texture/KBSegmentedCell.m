//
//  KBSegmentedCell.m
//  KBStudy
//
//  Created by 韩金波 on 2019/2/20.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBSegmentedCell.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface KBSegmentedCell ()

@property(nonatomic, strong) ASTextNode * title;

@end

@implementation KBSegmentedCell
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyManagesSubnodes = YES;
        _title = [[ASTextNode alloc] init];
    }
    return self;
}
-(void)setAttributedString:(NSAttributedString *)attributedString
{
    _attributedString = attributedString;
    _title.attributedText = attributedString;
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    return [ASCenterLayoutSpec centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY sizingOptions:ASCenterLayoutSpecSizingOptionDefault child:_title];
}
@end
