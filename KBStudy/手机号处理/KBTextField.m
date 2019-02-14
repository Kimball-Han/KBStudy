//
//  KBTextField.m
//  KBStudy
//
//  Created by 韩金波 on 2019/1/29.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBTextField.h"

@interface KBTextField ()<UITextFieldDelegate>

@end

@implementation KBTextField
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

-(void)setText:(NSString *)text
{
    [super setText:text];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
}





@end
