//
//  KBRedView.m
//  Expecta
//
//  Created by 韩金波 on 2019/2/14.
//

#import "KBRedView.h"

@implementation KBRedView
{
    BOOL _isLoad;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    if (_isLoad) {
        return;
    }
    _isLoad = YES;
    self.backgroundColor = [UIColor redColor];
}
@end
