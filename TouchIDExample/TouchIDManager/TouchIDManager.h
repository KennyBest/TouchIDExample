//
//  TouchIDManager.h
//  TouchIDExample
//
//  Created by lining on 2016/12/18.
//  Copyright © 2016年 Kenny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@import LocalAuthentication;

@interface TouchIDManager : NSObject

- (BOOL)canEvaluatePolicy:(LAPolicy)policy failureBlock:(nullable void(^)(NSError* __nullable error))block;


- (void)evaluatePolicy:(LAPolicy) policy localizedReason:(NSString * )localizedReason reply:(void(^)(BOOL success, NSError * __nullable error))reply;

@end

NS_ASSUME_NONNULL_END
