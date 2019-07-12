//
//  AntOCManager.m
//  AntFramework
//
//  Created by Anthony on 2018/7/20.
//  Copyright © 2018年 马义飞. All rights reserved.
//

#import "AntOCManager.h"

@implementation AntOCManager

+ (void)setStatusBarStyleWith: (UIStatusBarStyle)statusBarStyle
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if ([UIApplication sharedApplication].statusBarStyle != statusBarStyle) {
        [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle animated:true];
    }
#pragma clang diagnostic pop
}

//+ (BOOL)onlyNumberWithString:(NSString *)string {
//    
//    NSString *newString = string;
//    
//    if ([newString containsString:@"+86"]) {
//        newString = [[newString componentsSeparatedByString:@"+86"] componentsJoinedByString:@""];
//    }
//    
//    if ([newString containsString:@" "]) {
//        newString = [[newString componentsSeparatedByString:@" "] componentsJoinedByString:@""];
//    }
//    
//    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
//    newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
//    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
//        return NO;
//    }
//    
//    return YES;
//}

+ (BOOL)authCodeWithTextField:(UITextField *)textField andRange:(NSRange)range andReplacement:(NSString *)string autoCodeCount:(NSInteger)authCodeCount {
    
    NSString *text = [textField text];
    
    NSArray *numbers = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    NSString *temp = nil;
    for(int i =0; i < [text length]; i++) {
        temp = [text substringWithRange:NSMakeRange(i, 1)];
        if ([numbers containsObject:temp]) {
            newString = [NSString stringWithFormat:@"%@%@",newString,temp];
        }
        if (newString.length >= (authCodeCount + 1)) {
            break;
        }
    }
    
    if (newString.length >= (authCodeCount + 1)) {
        return NO;
    }
    
    [textField setText:newString];
    
    return false;
}

+ (BOOL)newPhoneNumberWithTextField:(UITextField *)textField andRange:(NSRange)range andReplacement:(NSString *)string {
    
    NSString *text = [textField text];
    
    NSArray *numbers = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    NSString *temp = nil;
    for(int i =0; i < [text length]; i++) {
        temp = [text substringWithRange:NSMakeRange(i, 1)];
        if ([numbers containsObject:temp]) {
            newString = [NSString stringWithFormat:@"%@%@",newString,temp];
        }
        if (newString.length >= 12) {
            break;
        }
    }
    
    if (newString.length >= 12) {
        return NO;
    }
    
    [textField setText:newString];
    
    return false;
}

+ (BOOL)phoneNumberWithTextField:(UITextField *)textField andRange:(NSRange)range andReplacement:(NSString *)string {
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    BOOL didChanged = NO;
    NSString *newString = @"";
    while (text.length > 0) {
        NSInteger length = 4;
        if (!didChanged) {
            length = 3;
        }
        
        NSString *subString = [text substringToIndex:MIN(text.length, length)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == length) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, length)];
        
        didChanged = YES;
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    if (newString.length >= 14) {
        return NO;
    }
    
    [textField setText:newString];
    
    return NO;
}

+ (BOOL)nameWithTextField:(UITextField *)textField andRange:(NSRange)range andReplacement:(NSString *)string {
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    BOOL didChanged = NO;
    NSString *newString = @"";
    while (text.length > 0) {
        NSInteger length = 4;
        if (!didChanged) {
            length = 3;
        }
        
        NSString *subString = [text substringToIndex:MIN(text.length, length)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == length) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, length)];
        
        didChanged = YES;
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    if (newString.length >= 14) {
        return NO;
    }
    
    [textField setText:newString];
    
    return NO;
}

+ (NSString *)newStringWithTextField:(UITextField *)textField andRange:(NSRange)range andReplacement:(NSString *)string {

    NSString *text = [textField text];
    text = [text stringByReplacingCharactersInRange:range withString:string];
    return text;
}
    
+ (BOOL)idCardWithTextField:(UITextField *)textField andRange:(NSRange)range andReplacement:(NSString *)string {
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789x\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    BOOL didChanged = NO;
    NSString *newString = @"";
    while (text.length > 0) {
        NSInteger length = 8;
        if (!didChanged) {
            length = 6;
        }
        
        NSString *subString = [text substringToIndex:MIN(text.length, length)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == length) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, length)];
        
        didChanged = YES;
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    if (newString.length >= 21) {
        return NO;
    }
    
    [textField setText:newString];
    
    return NO;
}

#pragma mark -- 根据原图获取压缩图片
+ (UIImage *)getSquareImage:(UIImage *)image
{
    CGFloat imageScale = image.size.width/image.size.height*1.0;
    CGSize captureSize = CGSizeZero;
    CGRect captureFrame = CGRectZero;
    
    if (1 < imageScale) { /// 这是一个横图
        captureSize = CGSizeMake(image.size.height, image.size.height);
        captureFrame = CGRectMake(-(image.size.width-captureSize.width)/2, 0, image.size.width, image.size.height);
    } else { /// 这是一个长图
        captureSize = CGSizeMake(image.size.width, image.size.width);
        captureFrame = CGRectMake(0, -(image.size.height-captureSize.height)/2, image.size.width, image.size.height);
    }
    
    UIGraphicsBeginImageContext(captureSize);
    [image drawInRect:captureFrame];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (void)addHtmlInfo:(UIWebView *)webView {
    
    [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function marketMan() {"
     "$(\"input[name=\'val2\']\").val(\"融近昊航\");"
     "$(\"input[name=\'val2\']\").attr(\"disabled\",\"disabled\");"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
    [webView stringByEvaluatingJavaScriptFromString:@"showAlert('这里是JS中alert弹出的message 第一种方式')"];
}

+ (UIColor *)colorWithHexString:(NSString *)color;
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

/**
 *  判断两个浮点数是否整除 1-被除数 2-除数
 *
 *  @param firstNumber  第一个浮点数(被除数)
 *  @param secondNumber 第二个浮点数(除数,不能为0)
 *
 *  @return 返回值可判定是否整除
 */
+ (BOOL)judgeDivisibleWithFirstNumber:(double)firstNumber andSecondNumber:(double)secondNumber {
    // 默认记录为整除
    BOOL isDivisible = YES;
    
    if (secondNumber == 0) {
        return NO;
    }
    
    double result = firstNumber / secondNumber;
    NSString * resultStr = [NSString stringWithFormat:@"%f", result];
    NSRange range = [resultStr rangeOfString:@"."];
    NSString * subStr = [resultStr substringFromIndex:range.location + 1];
    
    for (NSInteger index = 0; index < subStr.length; index ++) {
        unichar ch = [subStr characterAtIndex:index];
        
        // 后面的字符中只要有一个不为0，就可判定不能整除，跳出循环
        if ('0' != ch) {
            //            NSLog(@"不能整除");
            isDivisible = NO;
            break;
        }
    }
    
    // NSLog(@"可以整除");
    return isDivisible;
}


+(UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        //多层present
        while (appRootVC.presentedViewController) {
            appRootVC = appRootVC.presentedViewController;
            if (appRootVC) {
                nextResponder = appRootVC;
            }else{
                break;
            }
        }
        //        nextResponder = appRootVC.presentedViewController;
    }else{
        
        // 如果当前UIViewController顶层不是UIView，那就需要循环获取到该UIViewController对应的UIView，
        // 才能跳出循环
        int i= 0;
        UIView *frontView = [[window subviews] objectAtIndex:i];
        nextResponder = [frontView nextResponder];
        while (![nextResponder isKindOfClass:[UIViewController class]]) {
            i++;
            frontView = [[window subviews]objectAtIndex:i];
            nextResponder = [frontView nextResponder];
        }
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}


@end



















