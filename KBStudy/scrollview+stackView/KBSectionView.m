//
//  KBSectionView.m
//  KBStudy
//
//  Created by 韩金波 on 2018/12/25.
//  Copyright © 2018 韩金波. All rights reserved.
//

#import "KBSectionView.h"
#import <Masonry.h>
@implementation KBSectionView
{
    __weak UILabel *_lblTitle;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *lblTitle = [[UILabel alloc] init];
        lblTitle.text = title;
        [self addSubview:lblTitle];
        CGFloat  top = arc4random_uniform(100) + 30.0;
        [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(20);
            make.bottom.mas_equalTo(- top);
        }];
    }
    return self;
}

@end
