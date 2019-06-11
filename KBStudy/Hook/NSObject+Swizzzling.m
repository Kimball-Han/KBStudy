//
//  NSObject+Swizzzling.m
//  KBStudy
//
//  Created by 韩金波 on 2019/6/11.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "NSObject+Swizzzling.h"

static NSMutableDictionary *_impLookupTable;
static NSString *const KBSwizzleInfoPointerKey = @"pointer";
static NSString *const KBSwizzleInfoOwnerKey = @"owner";
static NSString *const KBSwizzleInfoOriginSelectorKey = @"originSelector";
static NSString *const KBSwizzleInfoSelectorKey = @"selector";


@implementation NSObject (Swizzzling)

void kb_implementation(id self, SEL _cmd){
    Class baseClass =  [self class];
    NSString *className = NSStringFromClass(baseClass);
    NSString *key = [NSString stringWithFormat:@"%@_%@",className,NSStringFromSelector(_cmd)];

    NSDictionary *swizzleInfo = [_impLookupTable objectForKey:key];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSString *selectorName = [swizzleInfo valueForKey:KBSwizzleInfoSelectorKey];
    SEL selector = NSSelectorFromString(selectorName);
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector];
    }
#pragma clang diagnostic pop
    NSValue *impValue = [swizzleInfo valueForKey:KBSwizzleInfoPointerKey];
    IMP impPointer = [impValue pointerValue];
    
    if (impPointer) {
        ((void(*)(id,SEL))impPointer)(self,_cmd);
    }

}

- (void)hookIfPossible:(SEL)originSelector selector:(SEL)selector{
    if (![self respondsToSelector:originSelector]|| ![self respondsToSelector:selector]) {
        return;
    }
    if (!_impLookupTable) {
        _impLookupTable = [[NSMutableDictionary alloc] init];
    }
    
    for (NSDictionary *info in [_impLookupTable allValues]) {
        Class class = [info objectForKey:KBSwizzleInfoOwnerKey];
        NSString *orginSelectorName = [info objectForKey:KBSwizzleInfoOriginSelectorKey];
        if ([self isKindOfClass:class] &&[orginSelectorName isEqualToString:NSStringFromSelector(originSelector)]) {
            return;
        }
    }
    
    Class baseClass =  [self class];
    NSString *className = NSStringFromClass(baseClass);
    
    NSString *orginSelectorName = NSStringFromSelector(originSelector);
    
    NSString *selectorName = NSStringFromSelector(selector);

    NSString *key = [NSString stringWithFormat:@"%@_%@",className,orginSelectorName];
    
    Method method = class_getInstanceMethod(baseClass, originSelector);
    IMP oldImplementation = method_setImplementation(method, (IMP)kb_implementation);
    
    
    NSDictionary *swizzledInfo = @{KBSwizzleInfoOwnerKey: baseClass,
                                   KBSwizzleInfoOriginSelectorKey:orginSelectorName,
                                   KBSwizzleInfoSelectorKey: selectorName,
                                   KBSwizzleInfoPointerKey: [NSValue valueWithPointer:oldImplementation]};
    
    [_impLookupTable setObject:swizzledInfo forKey:key];
}
@end
