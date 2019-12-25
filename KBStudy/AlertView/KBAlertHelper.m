//
//  KBAlertHelper.m
//  KBStudy
//
//  Created by 韩金波 on 2019/12/25.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBAlertHelper.h"
#import "UIViewController+KBHelper.h"
@implementation KBAlertTextField

-(instancetype)initWithConfigurationHandler:(KBAlertTextFieldHandler)handler{
    self = [super init];
    if (self) {
        _handler = handler;
    }
    return self;
}


+(KBAlertTextField *)alertTextFieldHandler:(KBAlertTextFieldHandler)handler{
    return [[KBAlertTextField alloc] initWithConfigurationHandler:handler];
}

@end
@interface KBAlertHelper ()

@property (nonatomic, copy)NSString *kb_title;

@property (nonatomic, copy)NSString *kb_message;

@property (nonatomic, assign) UIAlertControllerStyle kb_preferredStyle;

@property (nonatomic, strong)UIAlertAction *kb_preferredAction;

@property (nonatomic, strong)UIViewController *kb_viewController;

@property (nonatomic, strong)NSMutableArray <UIAlertAction *> *kb_actions;

@property (nonatomic, strong)NSMutableArray <KBAlertTextField *> *kb_textFields;


@end

@implementation KBAlertHelper

+(instancetype)helper{
    return [[KBAlertHelper alloc] init];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.kb_preferredStyle = UIAlertControllerStyleAlert;
    }
    return self;
}

-(KBAlertHelper * _Nonnull (^)(UIAlertControllerStyle))style{
    return ^id(UIAlertControllerStyle style){
        self.kb_preferredStyle = style;
        return self;
    };
}

-(KBAlertHelper * _Nonnull (^)(NSString * _Nullable))title{
    return ^id(NSString * _Nullable title){
        self.kb_title = title;
        return self;
    };
}

-(KBAlertHelper * _Nonnull (^)(NSString * _Nullable))message{
    return ^id(NSString * _Nullable message){
        self.kb_message = message;
        return self;
    };
}

-(KBAlertHelper * _Nonnull (^)(UIAlertAction * _Nonnull))preferredAction{
    return ^id(UIAlertAction * action){
        self.kb_preferredAction = action;
        return self;
    };
}

-(KBAlertHelper * _Nonnull (^)(UIAlertAction * _Nonnull))addAction{
    return ^id(UIAlertAction * action){
        if (![self.kb_actions containsObject:action]) {
            [self.kb_actions addObject:action];
        }
        return self;
    };
}

- (KBAlertHelper * _Nonnull (^)(NSString * _Nullable, UIAlertActionStyle, KBAlertActionHandler _Nullable))addActionWithHandler{
    return ^id(NSString * _Nullable title, UIAlertActionStyle style, KBAlertActionHandler _Nullable hanlder){
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:hanlder];
           return self.addAction(action);
       };
}

-(KBAlertHelper * _Nonnull (^)(KBAlertTextField * _Nonnull))addTextField{
    return ^id(KBAlertTextField * handler){
        if (![self.kb_textFields containsObject:handler]) {
            [self.kb_textFields addObject:handler];
        }
        return self;
    };
}

-(KBAlertHelper * _Nonnull (^)(UIViewController * _Nonnull))fromViewController{
    return ^id(UIViewController * vc){
        self.kb_viewController = vc;
        return self;
    };
}

-(KBAlertHelper * (^)(void))show{
    return ^id(){
        [self present];
        return self;
    };
}

#pragma mark - core

-(NSMutableArray<UIAlertAction *> *)kb_actions{
    if (_kb_actions == nil) {
        _kb_actions = [NSMutableArray array];
    }
    return _kb_actions;
}

-(NSMutableArray<KBAlertTextField *> *)kb_textFields{
    if (_kb_textFields == nil) {
        _kb_textFields = [NSMutableArray array];
    }
    return _kb_textFields;
}

-(UIViewController *)kb_viewController{
    if (_kb_viewController == nil) {
        return  [UIViewController kb_visibleViewController];
    }
    return _kb_viewController;
}


-(void)present{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:self.kb_title message:self.kb_message preferredStyle:self.kb_preferredStyle];
    
   
    [self.kb_actions enumerateObjectsUsingBlock:^(UIAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertController addAction:obj];
    }];
    if (self.kb_preferredAction ) {
        if (![self.kb_actions containsObject:self.kb_preferredAction]) {
            [alertController addAction:self.kb_preferredAction];
        }
        alertController.preferredAction = self.kb_preferredAction;
    }
    
    [self.kb_textFields enumerateObjectsUsingBlock:^(KBAlertTextField * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertController addTextFieldWithConfigurationHandler:obj.handler];
    }];
    
    
    [self.kb_viewController presentViewController:alertController animated:YES completion:nil];
}


@end
