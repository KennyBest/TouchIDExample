//
//  TouchIDManager.h
//  TouchIDExample
//
//  Created by lining on 2016/12/18.
//  Copyright © 2016年 Kenny. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@import LocalAuthentication;

@interface TouchIDManager : NSObject

+ (BOOL)canEvaluatePolicy:(LAPolicy)policy failureBlock:(nullable void(^)(NSError* __nullable error))block;


+ (void)evaluatePolicy:(LAPolicy) policy localizedReason:(NSString * )localizedReason reply:(void(^)(BOOL success, NSError * __nullable error))reply;

+ (void)setKeyChainValue:(NSString *)value forKey:(NSString *)key;

+ (void)fetchValueWithKey:(NSString *)key useOperationPrompt:(NSString *)prompt completionBlock:(void(^)(NSString *value, NSError *error))block ;

+ (void)updateItemNewValue:(NSString *)newValue forKey:(NSString *)key opertaionPrompt:(NSString *)prompt ;

+ (void)deleteItemAsyncWithKey:(NSString *)key ;

@end

NS_ASSUME_NONNULL_END
