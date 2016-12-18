//
//  TouchIDManager.m
//  TouchIDExample
//
//  Created by lining on 2016/12/18.
//  Copyright © 2016年 Kenny. All rights reserved.
//

#import "TouchIDManager.h"

@implementation TouchIDManager

- (BOOL)canEvaluatePolicy:(LAPolicy)policy failureBlock:(void (^)(NSError * _Nullable))block {
    
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    BOOL result = [context canEvaluatePolicy:policy error:&error];
    
    if (!result && block) {
        block(error);
    }
    
    return result;
}

- (void)evaluatePolicy:(LAPolicy)policy localizedReason:(NSString *)localizedReason reply:(void (^)(BOOL, NSError * _Nullable))reply {
    
    LAContext *context = [[LAContext alloc] init];
    
    [context evaluatePolicy:policy localizedReason:localizedReason reply:^(BOOL success, NSError * _Nullable error) {
        
    }];
}

@end
