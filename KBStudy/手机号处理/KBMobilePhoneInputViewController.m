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
    
    UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 300, 300, 60)];
    textFiled.placeholder = @"请输入手机号";
    textFiled.delegate = self;
    [self.view addSubview:textFiled];
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
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
