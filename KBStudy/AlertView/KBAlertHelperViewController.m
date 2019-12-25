//
//  KBAlertHelperViewController.m
//  KBStudy
//
//  Created by 韩金波 on 2019/12/25.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBAlertHelperViewController.h"
#import "KBAlertHelper.h"
@interface KBAlertHelperViewController ()

@property (nonatomic, strong) UITextField * textField;
@end

@implementation KBAlertHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * sender = [UIButton buttonWithType:UIButtonTypeSystem];
    sender.frame = CGRectMake(100, 200, 200, 40);
    [self.view addSubview:sender];
    [sender setTitle:@"Test Alert" forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(testAlertView) forControlEvents:UIControlEventTouchUpInside];
}


-(void)testAlertView{
    self.textField = nil;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"ok  text:%@",self.textField.text);
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Destructive " style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Destructive");
    }];
    UIAlertAction *preferredAction = [UIAlertAction actionWithTitle:@"preferredAction cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"preferredAction  cancel");
    }];

    KBAlertTextField *name =[KBAlertTextField alertTextFieldHandler:^(UITextField * _Nullable textField) {
        textField.placeholder = @"请输入姓名";
        self.textField = textField;
    }];
    
    KBAlertTextField *age =[KBAlertTextField alertTextFieldHandler:^(UITextField * _Nullable textField) {
           textField.placeholder = @"请输入年龄";
    }];
    
    KBAlertHelper.helper
    .style(UIAlertControllerStyleAlert)
    .addAction(okAction)
    .addAction(cancelAction)
    .preferredAction(preferredAction)
    .addTextField(name)
    .addTextField(age)
    .title(@"title")
    .message(@"message")
    .addActionWithHandler(@"确认",UIAlertActionStyleDefault,nil)
    .addActionWithHandler(@"测试",UIAlertActionStyleDestructive,^(UIAlertAction * action){
        NSLog(@"测试");
    })
    .fromViewController(self)
    .show();

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
