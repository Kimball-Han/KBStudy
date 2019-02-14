//
//  PNVerifyCodeView.h
//  TEST
//
//  Created by 韩金波 on 2018/8/7.
//  Copyright © 2018年 韩金波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNVerifyCodeInputView : UIView<UIKeyInput,UITextInputTraits>

@property(nonatomic,strong)NSMutableString *text;

@property(nonatomic,assign)NSInteger num;


@property(nonatomic,strong)UIColor *tintColor;

@property(nonatomic,strong)UIColor *disableColor;

@property(nonatomic,strong)UIColor *textColor;

@end
