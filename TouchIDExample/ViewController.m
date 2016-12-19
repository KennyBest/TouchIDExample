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


@end
