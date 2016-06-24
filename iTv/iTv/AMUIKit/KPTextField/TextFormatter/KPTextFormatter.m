//
//  KPTextFormatter.m
//  kaopu
//
//  Created by zhilei on 12/3/14.
//  Copyright (c) 2014 baina. All rights reserved.
//

#import "KPTextFormatter.h"

@implementation KPTextFormatter


- (NSString *)format:(NSString *)string withLocale:(NSLocale *)locale
{
    // 1. 格式化字符串
    NSString* strippedStr = [[self class] stripString:string];
    
    // 2.格式化字符串
    NSString* formattedStr = [[self class] parseString:strippedStr];
    
    return formattedStr;
}


+ (NSString *)stripString:(NSString *)string
{
    NSCharacterSet *doNotWant = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return [[string componentsSeparatedByCharactersInSet:
            	doNotWant]
            componentsJoinedByString:@""];
}

+ (NSString *)parseString:(NSString *)string
{
    return string;
}


@end
