//
//  OnlyAuthorizationViewController.m
//  TouchIDExample
//
//  Created by lining on 2016/12/19.
//  Copyright © 2016年 Kenny. All rights reserved.
//

#import "OnlyAuthorizationViewController.h"
#import "TouchIDManager.h"
#import "AppDelegate.h"

@interface OnlyAuthorizationViewController ()

@end

@implementation OnlyAuthorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 类似于支付宝启动后验证 猜想1: 直接启动TouchId验证 验证通过后 路由到主界面进行正常运行 
 
 （又觉得支付宝不会做这么简单）
 
 猜想2 用户验证通过后 通过keychain取到用户的token之类的辨别身份的字段
 */

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [TouchIDManager evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"验证你的身份" reply:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                 [(AppDelegate *)[UIApplication sharedApplication].delegate window].rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
            });
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)toggleDismiss:(UIButton *)sender {
    

}
- (IBAction)toggleUseAnotherAccount:(UIButton *)sender {
    
}

@end
