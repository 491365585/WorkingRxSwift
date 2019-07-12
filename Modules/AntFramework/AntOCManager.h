//
//  AntOCManager.h
//  AntFramework
//
//  Created by Anthony on 2018/7/20.
//  Copyright © 2018年 马义飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AntOCManager : NSObject

+ (void)setStatusBarStyleWith: (UIStatusBarStyle)statusBarStyle;

//+ (BOOL)onlyNumberWithString:(NSString *)string;

+ (BOOL)phoneNumberWithTextField:(UITextField *)textField andRange:(NSRange)range andReplacement:(NSString *)string;

+ (BOOL)newPhoneNumberWithTextField:(UITextField *)textField andRange:(NSRange)range andReplacement:(NSString *)string;
    
+ (BOOL)idCardWithTextField:(UITextField *)textField andRange:(NSRange)range andReplacement:(NSString *)string;

+ (BOOL)nameWithTextField:(UITextField *)textField andRange:(NSRange)range andReplacement:(NSString *)string;

+ (NSString *)newStringWithTextField:(UITextField *)textField andRange:(NSRange)range andReplacement:(NSString *)string;

+ (UIImage *)getSquareImage:(UIImage *)image;

+ (BOOL)authCodeWithTextField:(UITextField *)textField andRange:(NSRange)range andReplacement:(NSString *)string autoCodeCount:(NSInteger)authCodeCount;

+ (void)addHtmlInfo:(UIWebView *)webView;

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (BOOL)judgeDivisibleWithFirstNumber:(double)firstNumber andSecondNumber:(double)secondNumber;

+ (UIViewController *)getCurrentVC;

@end
