//
//  ViewController.m
//  TouchIDExample
//
//  Created by lining on 2016/12/18.
//  Copyright © 2016年 Kenny. All rights reserved.
//

#import "ViewController.h"
#import "TouchIDManager.h"

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

- (IBAction)checkTouchId:(id)sender {
    
    BOOL result = [TouchIDManager canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics failureBlock:^(NSError *error){
        
    }];
    
    if (result) {
        [TouchIDManager evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"使用指纹识别" reply:^(BOOL success, NSError * _Nullable error) {
            NSLog(@"%d, %@",success, error);
        }];
    }
    
}

@end
