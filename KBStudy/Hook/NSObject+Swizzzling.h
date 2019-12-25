//
//  NSObject+Swizzzling.h
//  KBStudy
//
//  Created by 韩金波 on 2019/6/11.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>

@interface NSObject (Swizzzling)

- (void)hookIfPossible:(SEL _Nonnull )originSelector  selector:(SEL _Nonnull)selector;

+ (void)hookClass:(Class _Nullable )classObject fromSelector:(SEL _Nullable )fromSelector toSelector:(SEL)toSelector;

@end

