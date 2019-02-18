//
//  KBMobilePhoneInputViewController.m
//  KBStudy
//
//  Created by 韩金波 on 2019/1/29.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBMobilePhoneInputViewController.h"

@interface KBMobilePhoneInputViewController ()<UITextFieldDelegate>

@end

@implementation KBMobilePhoneInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(15, 300, 300, 60)];
    textFiled.borderStyle = UITextBorderStyleLine;
    textFiled.backgroundColor = [UIColor grayColor];
    textFiled.placeholder = @"请输入手机号";
    textFiled.delegate = self;
    textFiled.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:textFiled];
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [self inputTextField:textField shouldChangeCharactersInRange:range replacementString:string blankLocations:@[@3,@8] limitCount:11];
    return YES;
}

- (BOOL)inputTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
     replacementString:(NSString *)string
        blankLocations:(NSArray<NSNumber *> *)blankLocation
            limitCount:(NSInteger)limitCount
{
    BOOL limit = YES;
    if (limitCount == 0) {
        limit = NO;
    }
    if (textField) {
        NSString *text = textField.text;
        if ([string isEqualToString:@""]) {//删除
            if(range.location < text.length && [text characterAtIndex:range.location] == ' ' && [textField.selectedTextRange isEmpty]){
                NSInteger offset = range.location;
                [textField deleteBackward];
                offset --;
                [textField deleteBackward];
                textField.text = [self insertString:textField.text withBlankLocations:blankLocation];
                //设置光标的位置
                [self setCursorLocation:textField withOffset:offset];
                return NO;
            } else if (range.location + range.length == text.length) {
                return YES;
            }  else{
                return  YES;
            }
        }else{
            if (limit) {
                if ([self removeBlankString:textField.text].length + string.length - range.length > limitCount ) {// [self whiteSpaseString:textField.text].length 目前textfield中有的 内容的长度 string.length 即将加入的内容的长度 range.length
                    return NO;
                }
            }
        }
        
        [textField insertText:string];
        textField.text = [self insertString:textField.text withBlankLocations:blankLocation];
        NSInteger offset = range.location + string.length;
        
        for (NSNumber *location in blankLocation) {
            if (range.location == location.integerValue) {
                offset ++;
            }
        }
        [self setCursorLocation:textField withOffset:offset];
        return NO;
        
    }else{
        return YES;
    }
    return  YES;
}

-(NSString *)insertString:(NSString *)string withBlankLocations:(NSArray <NSNumber *>*)locations
{
 
    if (!string) {
        return nil;
    }
    
    NSMutableString * mutableString = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
    for (NSNumber *location in locations) {
        if (mutableString.length > location.integerValue) {
            [mutableString insertString:@" " atIndex:location.integerValue];
        }
    }
    return [mutableString copy];
}
-(NSString*)removeBlankString:(NSString*)string {
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

// 设置光标
- (void)setCursorLocation:(UITextField *)textField withOffset:(NSInteger) offset{
    UITextPosition *newPostion = [textField positionFromPosition:textField.beginningOfDocument offset:offset] ;
    textField.selectedTextRange = [textField textRangeFromPosition:newPostion toPosition:newPostion];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
