//
//  UIImage+Gradient.m
//  KBStudy
//
//  Created by 韩金波 on 2019/2/20.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "UIImage+Gradient.h"

@implementation UIImage (Gradient)

+ (UIImage*)gradientImageWithSize:(CGSize)size andColors:(NSArray *)colors andGradientType:(int)gradientType{
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start = CGPointMake(0.0, 0.0);
    CGPoint end = CGPointMake(0.0, size.height);
    
    if (gradientType == 1) {
        start = CGPointMake(0.0, 0.0);
        end = CGPointMake(size.width, 0.0);
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)addCornerImageWithSize:(CGSize)size
{
    // make a CGRect with the image's size
    CGRect circleRect = (CGRect) {CGPointZero, size};
    
    // begin the image context since we're not in a drawRect:
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    // create a UIBezierPath circle
    UIBezierPath *circle = [UIBezierPath bezierPathWithRoundedRect:circleRect cornerRadius:size.height/2];
    
    // clip to the circle
    [circle addClip];
    
    [[UIColor whiteColor] set];
    [circle fill];
    
    // draw the image in the circleRect *AFTER* the context is clipped
    [self drawInRect:circleRect];
    
    // get an image from the image context
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // end the image context since we're not in a drawRect:
    UIGraphicsEndImageContext();
    
    return roundedImage;
}


- (UIImage *)makeCircularImageWithSize:(CGSize)size withBorderWidth:(CGFloat)width
{
    // make a CGRect with the image's size
    CGRect circleRect = (CGRect) {CGPointZero, size};
    
    // begin the image context since we're not in a drawRect:
    UIGraphicsBeginImageContextWithOptions(circleRect.size, NO, 0);
    
    // create a UIBezierPath circle
    UIBezierPath *circle = [UIBezierPath bezierPathWithRoundedRect:circleRect cornerRadius:circleRect.size.width/2];
    
    // clip to the circle
    [circle addClip];
    
    [[UIColor whiteColor] set];
    [circle fill];
    
    // draw the image in the circleRect *AFTER* the context is clipped
    [self drawInRect:circleRect];
    
    // create a border (for white background pictures)
    if (width > 0) {
        circle.lineWidth = width;
        [[UIColor whiteColor] set];
        [circle stroke];
    }
    
    // get an image from the image context
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // end the image context since we're not in a drawRect:
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

@end
