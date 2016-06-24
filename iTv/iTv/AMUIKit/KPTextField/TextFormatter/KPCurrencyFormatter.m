//
//  KPCurrencyFormatter.m
//  kaopu
//
//  Created by zhilei on 12/3/14.
//  Copyright (c) 2014 baina. All rights reserved.
//

#import "KPCurrencyFormatter.h"

@implementation KPCurrencyFormatter


+ (NSString *)stripString:(NSString *)string
{
    // 1. 格式化字符串，移除杂项字符，只保留数字和点
    NSMutableCharacterSet* doNotWant = [[[NSCharacterSet decimalDigitCharacterSet] invertedSet] mutableCopy];
    [doNotWant removeCharactersInString:@"."];
    
    NSString* decimalString = [[string componentsSeparatedByCharactersInSet:
                                doNotWant]
                               componentsJoinedByString:@""];
    
    // 如果有多个'.',则保留第一个'.'
    NSArray* comps = [decimalString componentsSeparatedByString:@"."];
    
    NSMutableString *resultStr = [NSMutableString string];
    
    
    // 2. 拼接字符串
    [comps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSString* item = obj;
        if (!item.length)
            return ;
        
        [resultStr appendString:obj];
        if (comps.count > 1 &&  idx == 0) {
            [resultStr appendString:@"."];
        }
    }];
    
    return resultStr;
}

+ (NSString *)parseString:(NSString *)string
{
    if (string == nil || !(string.length >0)) {
        return nil;
    }
    
    NSMutableString *strippedStr = [NSMutableString stringWithString:string];
    if ([strippedStr hasPrefix:@"¥"]) {
        [strippedStr deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    NSRange range = [strippedStr rangeOfString:@"."];
    BOOL hasFloat = !(range.location == NSNotFound);
    
    
    NSMutableString* results = [NSMutableString string];
    
    if (hasFloat) {
        
        NSRange dotRange = [strippedStr rangeOfString:@"."];
        NSString *IntegerPart = [strippedStr substringWithRange:NSMakeRange(0, dotRange.location)];
        NSString *DecimalPart = [strippedStr substringWithRange:NSMakeRange(dotRange.location, strippedStr.length-dotRange.location)];
        
        
        NSLog(@"int string: %@ decimal string:%@", IntegerPart, DecimalPart);

        [results appendString:[self formateString:IntegerPart]];
        [results appendString:DecimalPart];
        
    }else{
        
        [results appendString:[self formateString:strippedStr]];
    }
    
    if (![results hasPrefix:@"¥"]) {
        [results insertString:@"¥" atIndex:0];
    }
    
    return results;
}

+ (NSString *)formateString:(NSString *)string
{
    if (string.length == 0)
        return string;
    if (string.intValue == 0) {
        string = @"0";
    }
    
    if (string.length > 1 && [string hasPrefix:@"0"]) {
        string = [string substringFromIndex:1];
    }
    
    NSMutableString* results = [NSMutableString stringWithString:string];
    
    NSUInteger seperatorCount = results.length / 3;
    
    for (NSUInteger i = 1; i <= seperatorCount; i++) {
        NSUInteger index = string.length - i * 3;
        if (index > 0){
            [results insertString:@"," atIndex:string.length - i * 3];
        }
    }

    
    return results;
}



@end
