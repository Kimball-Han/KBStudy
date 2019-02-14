//
//
//  Created by 韩金波 on 2018/8/7.
//  Copyright © 2018年 韩金波. All rights reserved.
//

#import "PNVerifyCodeInputView.h"
@interface PNVerifyCodeInputView()
@property(nonatomic, strong)CALayer *cursor;
@end

@implementation PNVerifyCodeInputView

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
    self.backgroundColor = [UIColor whiteColor];
    self.text = [NSMutableString stringWithString:@""];
    self.num = 6;
    self.tintColor = [UIColor blueColor];
    self.textColor = [UIColor blackColor];
    self.cursor = [CALayer layer];
    [self.layer addSublayer:self.cursor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginCusorAnimation) name:UIApplicationDidBecomeActiveNotification object:nil];

}

-(BOOL)hasText
{
    return self.text.length > 0;
}

-(void)insertText:(NSString *)text
{
    if (self.text.length == self.num) {
        return;
    }
    [self.text appendString:text];
    [self setNeedsDisplay];
}
-(void)deleteBackward
{
    if (self.text.length == 0) {
        return;
    }
    [self.text deleteCharactersInRange:NSMakeRange(self.text.length - 1, 1)];
    [self setNeedsDisplay];

}

- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - setters


#pragma mark - Methods;

-(void)drawRect:(CGRect)rect
{
    NSInteger count = self.num;
    NSInteger length = self.text.length;
    CGFloat itemWidth = (rect.size.width - 20)/count;
    CGFloat itemHeight = (rect.size.height - 10);
    self.cursor.bounds = CGRectMake(0, 0, 2, itemHeight/2);
    self.cursor.cornerRadius = 1;
    self.cursor.backgroundColor = self.tintColor.CGColor;

    
    for (int i = 0; i < length; ++i) {
        NSString * string = [self.text substringWithRange:NSMakeRange(i, 1)];
        
        CGSize size = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil].size;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        style.alignment = NSTextAlignmentCenter;
        
        CGRect rect = CGRectMake(i * itemWidth + 10, (itemHeight-size.height)/2 + 5 , itemWidth, itemHeight);
        
        [string drawInRect:rect withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],
                                                 NSParagraphStyleAttributeName:style,
                                                 NSForegroundColorAttributeName:self.textColor
                                                 }];
    }
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    for (int i = 0; i <= count; i++) {
        if (i <= length + 1) {
            CGContextSetStrokeColorWithColor(context, self.tintColor.CGColor);
        }else{
            CGContextSetStrokeColorWithColor(context, self.disableColor.CGColor);
        }
        CGContextMoveToPoint(context, itemWidth * i + 10 , 5);
        CGContextAddLineToPoint(context, itemWidth * i + 10 , itemHeight + 5);
        CGContextStrokePath(context);
    }
    
    NSInteger min = MIN(length + 1, count);
    CGContextSetStrokeColorWithColor(context, self.tintColor.CGColor);
    CGContextMoveToPoint(context,  10 , 5);
    CGContextAddLineToPoint(context, itemWidth * min + 10 ,  5);
    CGContextMoveToPoint(context, 10 ,itemHeight + 5);
    CGContextAddLineToPoint(context, itemWidth * min  +  10 , itemHeight + 5);
    CGContextStrokePath(context);
    
    
    if (length < (count - 1)) {
        CGContextSetStrokeColorWithColor(context, self.disableColor.CGColor);
        CGContextMoveToPoint(context, itemWidth * (length +1) + 10 , 5);
        CGContextAddLineToPoint(context, itemWidth * count + 10 ,  5);
        CGContextMoveToPoint(context, itemWidth * (length +1) + 10 ,itemHeight + 5);
        CGContextAddLineToPoint(context, itemWidth * count + 10 , itemHeight + 5);
        CGContextStrokePath(context);
    }
    
    if (length < count) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.cursor.position = CGPointMake((length + 0.5)*itemWidth + 10, itemHeight * 0.5 + 5);
        [CATransaction commit];
        self.cursor.hidden = NO;
        [self beginCusorAnimation];
    }else{
        [self removeCusorAnimation];
        self.cursor.hidden = YES;
    }
    
}


-(void)beginCusorAnimation
{
//    if (![self isFirstResponder]) {
//        [self becomeFirstResponder];
//    }
    
    if ([[self.cursor animationKeys ] containsObject:@"cursor"]) {
        return;
    }
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @0;
    animation.toValue = @0.8;
    animation.duration = 0.6;
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    [self.cursor addAnimation:animation forKey:@"cursor"];
}

-(void)removeCusorAnimation
{
    [self.cursor removeAllAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self isFirstResponder]) {
        [self becomeFirstResponder];
    }
}
-(void)dealloc
{
    [self removeCusorAnimation];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
