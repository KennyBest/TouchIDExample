//
//  ViewController.m
//  TouchIDExample
//
//  Created by lining on 2016/12/18.
//  Copyright © 2016年 Kenny. All rights reserved.
//

#import "ViewController.h"
#import "TouchIDManager.h"
#import "OnlyAuthorizationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

}


- (IBAction)checkTouchId:(id)sender {
    
    BOOL result = [TouchIDManager canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics failureBlock:^(NSError *error){
        
    }];
    
    if (result) {
        [TouchIDManager evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"使用指纹识别" reply:^(BOOL success, NSError * _Nullable error) {
            NSLog(@"%d, %@",success, error);
        }];
    }
    
}

/**
 支付宝登录时使用touchId验证
 猜想： 使用touchId仅验证身份
 */

- (IBAction)toggleCreateNewPassword:(UIButton *)sender {
    
    [TouchIDManager setKeyChainValue:@"https://kennybest.github.io" forKey:@"BLOG_ADDRESS"];
    
}

- (IBAction)toggleUpdateExistedPassword:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"更新为冀大神的Blog地址 https://sp55.github.io" preferredStyle: UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"冀大神我又帮你推广一波";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"请我吃烤羊腿" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *field = alert.textFields[0];
        [TouchIDManager updateItemNewValue:field.text forKey:@"BLOG_ADDRESS" opertaionPrompt:@"验证新的Blog地址"];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)toggleDeleteExistedPassword:(id)sender {
    
    [TouchIDManager deleteItemAsyncWithKey:@"BLOG_ADDRESS"];
}

@end
