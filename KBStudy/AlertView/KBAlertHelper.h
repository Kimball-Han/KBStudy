//
//  KBAlertHelper.h
//  KBStudy
//
//  Created by 韩金波 on 2019/12/25.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^KBAlertTextFieldHandler)(UITextField * _Nonnull textField);
typedef void(^KBAlertActionHandler)(UIAlertAction * _Nonnull action);

NS_ASSUME_NONNULL_BEGIN

@interface KBAlertTextField : NSObject

@property (nonatomic, copy, readonly)KBAlertTextFieldHandler handler;

+(KBAlertTextField *)alertTextFieldHandler:(KBAlertTextFieldHandler)handler;

@end
/*
 UIAlertActionStyleCancel类型的UIAlertAction按钮在最右边（最下面）的位置,且只能加一个
 preferredAction的UIAlertAction按钮，字体加粗，颜色等不变。只在UIAlertControllerStyleAlert时有效
 */

@interface KBAlertHelper : NSObject

+(instancetype)helper;

-(KBAlertHelper *(^)(UIAlertControllerStyle ))style;

-(KBAlertHelper *(^)(NSString  * _Nullable ))title;

-(KBAlertHelper *(^)(NSString * _Nullable ))message;

-(KBAlertHelper *(^)(UIAlertAction *))addAction;

-(KBAlertHelper *(^)(NSString *  _Nullable,UIAlertActionStyle, KBAlertActionHandler _Nullable))addActionWithHandler;

-(KBAlertHelper *(^)(UIAlertAction *))preferredAction;

-(KBAlertHelper *(^)(KBAlertTextField*))addTextField;

-(KBAlertHelper *(^)(UIViewController *))fromViewController;

-(KBAlertHelper *(^)(void))show;



@end

NS_ASSUME_NONNULL_END
