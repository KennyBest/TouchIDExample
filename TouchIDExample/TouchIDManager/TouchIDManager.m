//
//  TouchIDManager.m
//  TouchIDExample
//
//  Created by lining on 2016/12/18.
//  Copyright © 2016年 Kenny. All rights reserved.
//

#import "TouchIDManager.h"

@implementation TouchIDManager

+ (BOOL)canEvaluatePolicy:(LAPolicy)policy failureBlock:(void (^)(NSError * _Nullable))block {
    
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    BOOL result = [context canEvaluatePolicy:policy error:&error];
    
    if (!result && block) {
        block(error);
    }
    
    return result;
}

+ (void)evaluatePolicy:(LAPolicy)policy localizedReason:(NSString *)localizedReason reply:(void (^)(BOOL, NSError * _Nullable))reply {
    
    LAContext *context = [[LAContext alloc] init];
    
    [context evaluatePolicy:policy localizedReason:localizedReason reply:^(BOOL success, NSError * _Nullable error) {
        reply(success, error);
    }];
}

+ (void)setKeyChainValue:(NSString *)value forKey:(NSString *)key {
    CFErrorRef error = NULL;
    
    SecAccessControlRef sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, kSecAccessControlTouchIDAny, &error);
    
    if (sacObject == NULL || error != nil) {
        NSString *errorString = [NSString stringWithFormat:@"存储失败:%@", error];
        [self showAlertControllerWithMessage:errorString];
        
        return;
    }
    
    NSData *secretPasswordTextData = [value dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *attributes = @{
                                 (id)kSecClass: (id)kSecClassGenericPassword,
                                 (id)kSecAttrService: key,
                                 (id)kSecValueData: secretPasswordTextData,
                                 (id)kSecUseAuthenticationUI: (id)kSecUseAuthenticationUIAllow,
                                 (id)kSecAttrAccessControl: (__bridge_transfer id)sacObject
                                 };
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)attributes, nil);
        
        NSString *message = [NSString stringWithFormat:@"储存结果: %d", status];
        
        [self showAlertControllerWithMessage:message];
    });
    
}


+ (void)fetchValueWithKey:(NSString *)key useOperationPrompt:(NSString *)prompt completionBlock:(void(^)(NSString *value, NSError *error))block {
    NSDictionary *query = @{
                            (id)kSecClass: (id)kSecClassGenericPassword,
                            (id)kSecAttrService: key,
                            (id)kSecReturnData: @YES,
                            (id)kSecUseOperationPrompt: prompt
                            };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CFTypeRef dataTypeRef = NULL;
        NSString *result = nil;
        NSError *error = nil;
        
        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)(query), &dataTypeRef);
        if (status == errSecSuccess) {
            NSData *resultData = (__bridge_transfer NSData *)dataTypeRef;
            
           result = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        } else {
           error = [NSError errorWithDomain:@"com.kennybest.github.io" code:1000 userInfo:@{NSLocalizedDescriptionKey: [self keyChainErrorToString:status]}];
        }
        
        if (block) {
            block(result, error);
        }
    });
}

+ (void)updateItemNewValue:(NSString *)newValue forKey:(NSString *)key opertaionPrompt:(NSString *)prompt {
    NSDictionary *query = @{
                            (id)kSecClass: (id)kSecClassGenericPassword,
                            (id)kSecAttrService: key,
                            (id)kSecUseOperationPrompt: prompt
                            };
    
    NSData *updatedData = [newValue dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *changes = @{
                              (id)kSecValueData: updatedData
                              };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)changes);
        
        NSString *errorString = [self keyChainErrorToString:status];
        
        [self showAlertControllerWithMessage:errorString];
    });
}

+ (void)deleteItemAsyncWithKey:(NSString *)key {
    NSDictionary *query = @{
                            (id)kSecClass: (id)kSecClassGenericPassword,
                            (id)kSecAttrService: key
                            };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
        
        NSString *errorString = [self keyChainErrorToString:status];
        
        [self showAlertControllerWithMessage:errorString];
    });
}

+ (NSString *)keyChainErrorToString:(OSStatus)error {
    NSString *message = [NSString stringWithFormat:@"%ld", (long)error];
    
    switch (error) {
        case errSecSuccess:
            message = @"success";
            break;
            
            case errSecDuplicateItem:
            message = @"error item already exists";
            break;
            
            case errSecItemNotFound:
            message = @"error item not found";
            break;
            
            case errSecAuthFailed:
            message = @"error item authentication failed";
            
        default:
            break;
    }
    
    return message;
}

+ (void)showAlertControllerWithMessage:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [[[[UIApplication sharedApplication] delegate] window].rootViewController presentViewController:alert animated:YES completion:nil];
    
}
@end
