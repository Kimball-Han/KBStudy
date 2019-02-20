//
//  UIImage+Gradient.h
//  KBStudy
//
//  Created by 韩金波 on 2019/2/20.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Gradient)

/**
 *  获取矩形的渐变色的UIImage
 *
 *  @param size       UIImage的size
 *  @param colors       渐变色数组，可以设置两种颜色
 *  @param gradientType 渐变的方式：0--->从上到下   1--->从左到右
 *
 *  @return 渐变色的UIImage
 */

+ (UIImage*)gradientImageWithSize:(CGSize)size andColors:(NSArray*)colors andGradientType:(int)gradientType;

- (UIImage *)addCornerImageWithSize:(CGSize)size;

- (UIImage *)makeCircularImageWithSize:(CGSize)size withBorderWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
